FROM debian:9

MAINTAINER meteorIT GbR Marcus Kastner

EXPOSE 143

ENV DOMAIN_1=localhost.local\
	KOPANO_HOST_1=localhost
#DOMAIN_1 bis DOMAIN_10 sind möglich (inkl. KOPANO_HOST_1)


ADD entrypoint.sh /tmp
ADD template /tmp/template
RUN apt-get update \
    && apt-get install -y vim perdition rsyslog\ 
	&& apt-get --purge -y remove 'exim4*'


RUN chmod 755 /tmp/entrypoint.sh

ENTRYPOINT ["/tmp/entrypoint.sh"] 
