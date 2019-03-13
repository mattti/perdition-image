# Perdition-Image

this docker image provides perdition, an imap-proxy service to proxy different imap hosts based on the given domain

## Quickstart

#### Build Image
```sh
git clone https://github.com/guitarmarx/perdition-image.git
cd perditon-image
docker build -t perdition .
```
#### Run Container

```sh
docker run -d \
        -p 143:143 \
        --name perdition \
        -e DOMAIN_TARGET_IMAPHOST_PAIR1='<your-domain>,<your-imap-host>:<imap-port>' \
        -v <path-to-certifcates>,destination=/srv/certs \
        perdition
```
# Configuration
#### Domain-Target-IMAPHost-Pair(s)
The parameter **DOMAIN_TARGET_HOST_PAIR1**="<your-domain>,<your-imap-host>:<imap-port>" can be incremented to define more than one Domain-Target-IMAPHost-Pair, e.g:
>DOMAIN_TARGET_HOST_PAIR1="<your-domai1n>,<your-imap-host1>:<imap-port>"
DOMAIN_TARGET_HOST_PAIR2="<your-domain2>,<your-imap-host2>:<imap-port>"
DOMAIN_TARGET_HOST_PAIR3="<your-domain3>,<your-imap-host3>:<imap-port>"

#### SSL Configurarion
You need to specify the path to your certs with the param **-v<path-to-certifcates>,destination=/srv/certs**
The following certificates are necessary:
- cert.pem
- privkey.pem
- chain.pem









