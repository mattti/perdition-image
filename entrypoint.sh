#!/bin/bash

setDomainAndTargetIMAPHost (){
	values=(${1//,/ })
	DOMAIN="$(echo -e "${values[0]}" | tr -d '[:space:]')"
	TARGET_IMAP_HOST="$(echo -e "${values[1]}" | tr -d '[:space:]')"
}

#Erstellen der Domänenabhängigen Konfigurationen
##############################

param=DOMAIN_TARGET_IMAPHOST_PAIR
counter=1
pair="$param$counter"

# get all defined pairs
while [ ! -z ${!pair} ]; do

		# parse DOMAIN and TARGET_IMAP_HOST
		setDomainAndTargetIMAPHost ${!pair}
		echo "^(.*)@'"${DOMAIN}"': ${TARGET_IMAP_HOST}" >> /etc/perdition/popmap.re
		echo "Registered:" $DOMAIN "-->" $TARGET_IMAP_HOST

		# generate next pair
        counter=$((counter+1))
        pair="$param$counter"
done

# add empty line at the end of the file
echo "" /etc/perdition/popmap.re

cp /srv/templates/perdition.conf /etc/perdition/perdition.conf

#Starten von perdition
echo "Start Perdition"
service rsyslog start
service perdition start
#perdition.imap4 -l 143 -M /usr/lib/libperditiondb_posix_regex.so.0 -m /etc/perdition/popmap.re -P IMAP4 -b 0.0.0.0 -f "" --log_facility /var/log/perdition.log

#perdition.imap4 -l 143 -M /usr/lib/libperditiondb_posix_regex.so.0 -m /etc/perdition/popmap.re -P IMAP4 -b 0.0.0.0 -f "" --log_facility /var/log/perdition.log -C --ssl_mode=none


tail -f /var/log/mail.log