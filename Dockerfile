FROM debian:10.1-slim

LABEL meteorIT GbR Marcus Kastner
EXPOSE 143
VOLUME /srv/certs

ENV DOMAIN_TARGET_IMAPHOST_PAIR1=""

ADD entrypoint.sh /srv
ADD templates /srv/templates

RUN apt-get update && apt-get install -y --no-install-recommends perdition
RUN chmod +x /srv/entrypoint.sh

ENTRYPOINT ["/srv/entrypoint.sh"]
