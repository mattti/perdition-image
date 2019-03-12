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

#Starten von perdition
echo "Start Perdition"
#perdition.imap4 -l 143 -M /usr/lib/libperditiondb_posix_regex.so.0 -m /etc/perdition/popmap.re -P IMAP4 -b 0.0.0.0 -f "" --log_facility /var/log/perdition.log



/usr/sbin/perdition.imap4 --listen_port 143 \
						--map_library /usr/lib/libperditiondb_posix_regex.so.0 \
						--map_library_opt /etc/perdition/popmap.re \
						--protocol IMAP4  \
						--bind_address 0.0.0.0 \
						--config_file "" \
						--connection_logging \
						--log_facility=- \
						--no_daemon \
						--ssl_mode=none

#tail -f /var/log/mail.log