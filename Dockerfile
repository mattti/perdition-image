FROM debian:stable-slim

LABEL meteorIT GbR Marcus Kastner
EXPOSE 143 993
VOLUME /srv/certs

ENV DOMAIN_TARGET_IMAPHOST_PAIR1="" \
    CERT_PATH="/srv/certs" \
    CERT_FILE="cert.pem" \
    KEY_FILE="privkey.pem"

ADD entrypoint.sh /srv
ADD templates /srv/templates

RUN apt-get update && apt-get install -y --no-install-recommends perdition openssl
RUN chmod +x /srv/entrypoint.sh

ENTRYPOINT ["/srv/entrypoint.sh"]
