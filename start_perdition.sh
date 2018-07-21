container=meteorit_perditon


docker stop $container 2>/dev/null
docker rm $container 2> /dev/null


docker run  -d \
	--name $container \
	-v /etc/localtime:/etc/localtime:ro \
	-e DOMAIN_1=meteor-qs.de \
        -e DOMAIN_2=v22016063665135548.powersrv.de\
        -e KOPANO_CONTAINER_1=meteorit_kopano \
        -e KOPANO_CONTAINER_2=meteorit_kopano2 \
	perdition:1 

