include example.env
export

create:
	docker build -t ${IMAGE_NAME} .

run:
	docker run -d -p ${TOR_ENTRY_PORT}:8118 -p ${HAPROXY_PORT}:2090 -e tors=${TOR_INSTANCES} -e privoxy=1 --name ${CONTAINER_NAME} ${IMAGE_NAME}

run-socks5:
	docker run -d -p ${TOR_ENTRY_PORT}:5566 -p ${HAPROXY_PORT}:2090 -e tors=${TOR_INSTANCES} --name ${CONTAINER_NAME} ${IMAGE_NAME}

ps:
	docker ps -a | grep "${CONTAINER_NAME}"

log:
	docker logs ${CONTAINER_NAME}

flog:
	docker logs --follow ${CONTAINER_NAME}

stop:
	docker stop ${CONTAINER_NAME}
rm:
	docker rm ${CONTAINER_NAME}

clean:
	make stop
	make rm
