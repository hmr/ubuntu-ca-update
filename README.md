# Fix SSL certificate problem of curl/wget on Debian/Ubuntu

If you encounter errors below:

```log
❯ curl 'https://somewhere.net'
curl: (60) SSL certificate problem: unable to get local issuer certificate
More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.
```

or

```log
❯ wget 'https://somewhere.net'
--2022-02-09 06:56:32--  https://somewhere.net/
Resolving somewhere.net (somewhere.net)...
Connecting to somewhere.net (somewhere.net)... connected.
ERROR: cannot verify somewhere.net's certificate, issued by ‘CN=E6,O=Let's Encrypt,C=US’:
  Unable to locally verify the issuer's authority.
To connect to somewhere.net insecurely, use `--no-check-certificate'.
```

This may be caused by an outdated intermediate certificate of Let's Encrypt.

This utility downloads the new certificate from Let's Encrypt and updates system setting on Debian or Ubuntu.

## How to use

On your debian or ubuntu system, simply do `sudo ./ca-update.bash`.

### Mechanism

- Download cert from Let's Encrypt web site into /use/local/share/ca-certificates/
- Change the filename according to Subject of the cert
- Run update-ca-certicates to make symbolic links into /etc/ssl/certs/

### Prerequisites

- root privilege.
- `curl` or `wget` is available.
- `ca-certificates` package must be installed.

