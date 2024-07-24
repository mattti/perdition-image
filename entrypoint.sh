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

#generate dh-param file
openssl dhparam -out /tmp/dhparam.pem 1024
chmod 777  /tmp/dhparam.pem

echo "start perdition...."
perdition.imap4 --listen_port 143 \
			--map_library /usr/lib/x86_64-linux-gnu/libperditiondb_posix_regex.so.0 \
			--map_library_opt /etc/perdition/popmap.re \
			--protocol IMAP4  \
			--bind_address 0.0.0.0 \
			--config_file "" \
			--connection_logging \
			--log_facility=- \
			--no_daemon \
			--ssl_mode=tls_listen \
			--ssl_listen_ciphers="kEECDH:+kEECDH+SHA:kEDH:+kEDH+SHA:+kEDH+CAMELLIA:kECDH:+kECDH+SHA:kRSA:+kRSA+SHA:+kRSA+CAMELLIA:!aNULL:!eNULL:!SSLv2:!RC4:!MD5:!DES:!EXP:!SEED:!IDEA:!3DES" \
			--ssl_cert_file=${CERT_PATH}/${CERT_FILE} \
			--ssl_key_file=${CERT_PATH}/${KEY_FILE} \
			--ssl_dh_params_file=/tmp/dhparam.pem   2>&1 |  tee /var/log/perdition.log
