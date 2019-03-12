#!/bin/bash

setDomainAndTargetIMAPHost (){
	values=(${1//,/ })
	DOMAIN="$(echo -e "${values[0]}" | tr -d '[:space:]')"
	TARGET_IMAP_HOST="$(echo -e "${values[1]}" | tr -d '[:space:]')"
}


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

echo "start perdition...."
perdition.imap4 --listen_port 143 \
			--map_library /usr/lib/libperditiondb_posix_regex.so.0 \
			--map_library_opt /etc/perdition/popmap.re \
			--protocol IMAP4  \
			--bind_address 0.0.0.0 \
			--config_file "" \
			--connection_logging \
			--log_facility=- \
			--no_daemon \
			--ssl_mode=tls_listen_force \
			-ssl_cert_file=/srv/certs/cert.pem \
			--ssl_key_file=/srv/certs/privkey.pem \
			--ssl_listen_ciphers="kEECDH:+kEECDH+SHA:kEDH:+kEDH+SHA:+kEDH+CAMELLIA:kECDH:+kECDH+SHA:kRSA:+kRSA+SHA:+kRSA+CAMELLIA:!aNULL:!eNULL:!SSLv2:!RC4:!MD5:!DES:!EXP:!SEED:!IDEA:!3DES" 2>&1 |  tee /var/log/perdition.log