# VERSION 				0.1
# DOCKER_VERSION	0.10.0
# DESCRIPTION			Redis 2.8.9 CLI Docker Container
# TO_BUILD				docker build --rm -t 192.168.2.90:5000/moudy/redis-cli .
# TO_RUN					docker run -i -t --link redis-dyn-amb.service:redis 192.168.2.90:5000/moudy/redis-cli
# or locally			docker run --name=redis_cli --link redis_server:redis_server -i -t 192.168.2.90:5000/moudy/redis-cli /bin/bash

FROM 192.168.2.90:5000/moudy/redis
MAINTAINER Mark Moudy "mark.moudy@ericsson.com"

EXPOSE 6380
CMD /usr/local/bin/redis-cli -h $REDIS_SERVER_PORT_6379_TCP_ADDR