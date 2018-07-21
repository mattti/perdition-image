#!/bin/bash

#Erstellen der Domänenabhängigen Konfigurationen
if [ ! -z $DOMAIN_1 ] && [ ! -z $KOPANO_HOST_1 ]; then
		echo "^(.*)@'"${DOMAIN_1}"': ${KOPANO_HOST_1}" >> /etc/perdition/popmap.re
		echo "$DOMAIN_1 registriert"
fi
if [ ! -z $DOMAIN_2 ] && [ ! -z $KOPANO_HOST_2 ]; then
		echo "^(.*)@'"${DOMAIN_2}"': ${KOPANO_HOST_2}" >> /etc/perdition/popmap.re
		echo "$DOMAIN_2 registriert"
fi
if [ ! -z $DOMAIN_3 ] && [ ! -z $KOPANO_HOST_3 ]; then
        echo $DOMAIN_3 "lmtp:["${KOPANO_HOST_3}"]:2003" >> /etc/postfix/transport
		echo "$DOMAIN_3 registriert"
fi
if [ ! -z $DOMAIN_4 ] && [ ! -z $KOPANO_HOST_4 ]; then
		echo "^(.*)@'"${DOMAIN_4}"': ${KOPANO_HOST_4}" >> /etc/perdition/popmap.re
		echo "$DOMAIN_4 registriert"
fi
if [ ! -z $DOMAIN_5 ] && [ ! -z $KOPANO_HOST_5 ]; then
		echo "^(.*)@'"${DOMAIN_5}"': ${KOPANO_HOST_5}" >> /etc/perdition/popmap.re
		echo "$DOMAIN_5 registriert"
fi
if [ ! -z $DOMAIN_6 ] && [ ! -z $KOPANO_HOST_6 ]; then
		echo "^(.*)@'"${DOMAIN_6}"': ${KOPANO_HOST_6}" >> /etc/perdition/popmap.re
		echo "$DOMAIN_6 registriert"
fi
if [ ! -z $DOMAIN_7 ] && [ ! -z $KOPANO_HOST_7 ]; then
		echo "^(.*)@'"${DOMAIN_7}"': ${KOPANO_HOST_7}" >> /etc/perdition/popmap.re
		echo "$DOMAIN_7 registriert"
fi
if [ ! -z $DOMAIN_8 ] && [ ! -z $KOPANO_HOST_8 ]; then
		echo "^(.*)@'"${DOMAIN_8}"': ${KOPANO_HOST_8}" >> /etc/perdition/popmap.re
		echo "$DOMAIN_8 registriert"
fi
if [ ! -z $DOMAIN_9 ] && [ ! -z $KOPANO_HOST_9 ]; then
		echo "^(.*)@'"${DOMAIN_9}"': ${KOPANO_HOST_9}" >> /etc/perdition/popmap.re
		echo "$DOMAIN_9 registriert"
fi
echo "" /etc/perdition/popmap.re
mv /tmp/template/perdition/perdition.conf /etc/perdition/perdition.conf

#Starten von perdition
echo "Starte Perdition"
service rsyslog start
service perdition start
#perdition.imap4 -l 143 -M /usr/lib/libperditiondb_posix_regex.so.0 -m /etc/perdition/popmap.re -P IMAP4 -b 0.0.0.0 -f "" --log_facility /var/log/perdition.log

tail -f /var/log/mail.log