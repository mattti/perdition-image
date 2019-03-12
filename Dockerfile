FROM debian:7.11-slim

LABEL meteorIT GbR Marcus Kastner

EXPOSE 143

ENV DOMAIN_TARGET_HOST_PAIR=""

ADD entrypoint.sh /srv
ADD templates /srv/templates

RUN apt update && apt install -y \
	perdition \
	rsyslog

RUN chmod +x /srv/entrypoint.sh

ENTRYPOINT ["/srv/entrypoint.sh"]
