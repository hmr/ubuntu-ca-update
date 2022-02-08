# Fix "curl: (60) SSL certificate" problem

If you encount

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
ERROR: The certificate of 'somewhere.net' is not trusted.
ERROR: The certificate of 'somewhere.net' doesn't have a known issuer.
```

This may be caused by an outdated intermediate certificate of Let's Encrypt.

This utility downloads the new certificate from Let's Encrypt and updates system setting on Debian or Ubuntu.

## How to use

On your debian or ubuntu system, simply do `sudo ./ca-update.bash`.

### Prerequisites

- root privilege.
- `curl` or `wget` is available.
- `ca-certificates` package must be installed.

