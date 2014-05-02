# VERSION 				0.1
# DOCKER_VERSION	0.10.0
# DESCRIPTION			Docker container for Redis 2.8.9 Server
# TO_BUILD				docker build --rm -t 192.168.2.90:5000/moudy/redis-server .
# TO_RUN					docker run -p 6379:6379 --name redis_server 192.168.2.90:5000/moudy/redis-server
# to run with persistent data directory
#									docker run -p 6379:6379 -v <REPLACEME data-dir>:/data --name redis_server 192.168.2.90:5000/moudy/redis-server

FROM 192.168.2.90:5000/moudy/redis
MAINTAINER Mark Moudy "mark.moudy@ericsson.com"

# Configure redis in place
RUN sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf
RUN sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf
RUN sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf
RUN sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf
RUN echo 'vm.overcommit_memory = 1' >> /etc/sysctl.conf
RUN sysctl vm.overcommit_memory=1


# Define mountable directories
VOLUME ["/data"]

# Define working directory
WORKDIR /data

# Define Default command
CMD ["redis-server", "/etc/redis/redis.conf"]

# Expose port for redis
EXPOSE 6379
