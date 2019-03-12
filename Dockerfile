FROM alpine:3.9.2

LABEL meteorIT GbR Marcus Kastner

EXPOSE 143

ENV DOMAIN_TARGET_HOST_PAIR=""

ADD entrypoint.sh /srv
ADD templates /srv/templates

RUN apk add --update --no-cache \
	perdition \
	rsyslog

RUN chmod +x /srv/entrypoint.sh

ENTRYPOINT ["/srv/entrypoint.sh"]
