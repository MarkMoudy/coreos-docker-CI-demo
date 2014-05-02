# VERSION 				0.1
# DOCKER_VERSION	0.10.0
# DESCRIPTION			Docker container for Redis 2.8.9 for building
# TO_BUILD				docker build --rm -t 192.168.2.90:5000/moudy/redis .
# TO_RUN					docker run --name redis 192.168.2.90:5000/moudy/redis


FROM 192.168.2.90:5000/moudy/ubuntu:14.04
MAINTAINER Mark Moudy "mark.moudy@ericsson.com"

# Install Redis
RUN apt-get update
RUN apt-get install -y build-essential
RUN cd /tmp; wget http://download.redis.io/releases/redis-2.8.9.tar.gz; \
		tar xzf redis-2.8.9.tar.gz
RUN cd /tmp/redis-2.8.9; make
RUN cp /tmp/redis-2.8.9/src/redis-server /usr/local/bin/; cp /tmp/redis-2.8.9/src/redis-cli /usr/local/bin
RUN mkdir /etc/redis; cp /tmp/redis-2.8.9/redis.conf /etc/redis/redis.conf

# Clean up APT and tmp when finished
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


