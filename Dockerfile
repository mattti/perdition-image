FROM alpine:3.9.2

LABEL meteorIT GbR Marcus Kastner

EXPOSE 143

ENV DOMAIN_TARGET_HOST_PAIR=""

ADD entrypoint.sh /srv
ADD templates /srv/templates

RUN apt-get update \
	&& apt-get install -y vim perdition rsyslog\
	&& apt-get --purge -y remove 'exim4*'


RUN chmod +x /srv/entrypoint.sh

ENTRYPOINT ["/srv/entrypoint.sh"]
