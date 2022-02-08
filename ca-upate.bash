#!/bin/bash

TARGET_DIR="/usr/local/share/ca-certificates"
TARGET_URL="https://letsencrypt.org/certs/lets-encrypt-r3.pem"
TARGET_FILE="lets-encrypt-r3.crt"
DLBIN=""

echo "--- Debian/Ubuntu CA certificate update utility for Let's Encrypt. ---"
echo "Checking prerequisites..."
if ! id | grep "root" >& /dev/null; then
	echo "Error: This utility needs root privilege."
	exit 4
fi


if ! dpkg -L ca-certificates >& /dev/null; then
	echo "Error: Package 'ca-certificates' isn't instaled."
	echo 2;
fi

[[ -z "${DLBIN}" ]] && which curl >& /dev/null && DLBIN="curl"
[[ -z "${DLBIN}" ]] && which wget >& /dev/null && DLBIN="wget"

if [[ -z "${DLBIN}" ]]; then
	echo "Error: Both curl nor wget found."
	exit 1
fi

echo "OK."

echo "Checking whether the new CA certificate needs to be updated..."
if [[ -e "${TARGET_DIR}/${TARGET_FILE}" ]]; then
	echo "Error: The new CA certificate has already been downloaded."
	exit 5
fi

echo "OK."

echo "Downloading the new CA certificate."
cd "${TARGET_DIR}" || exit 3

case "${DLBIN}" in
	curl )
		if ! curl -s "${TARGET_URL}" > "${TARGET_FILE}"; then
			echo "Error: curl can't download the new CA certificate."
			exit 51
		fi
		;;
	wget )
		if ! wget -q -O "${TARGET_FILE}" "${TARGET_URL}"; then
			echo "Error: wget can't download the new CA certificate."
			exit 52
		fi
		;;
esac

echo "Download done. Updating system configuration."
if ! update-ca-certificates; then
	echo "Error: System configuration couldn't be updated."
	exit 6
fi

echo
echo "All done."

