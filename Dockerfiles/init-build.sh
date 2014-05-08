#!/bin/bash
# init-build.sh - Builds Docker images and pushes to Registry

# Build Jenkins
# cd /home/core/share/Dockerfiles/Jenkins && \
# /usr/bin/docker build --rm -t 192.168.2.90:5000/moudy/jenkins . && \
# /usr/bin/docker push 192.168.2.90:5000/moudy/jenkins

# Build Ubuntu Base image with dotcloud customizations
/usr/bin/docker build --rm -t="192.168.2.90:5000/moudy/ubuntu:14.04" github.com/dockerfile/ubuntu && \
/usr/bin/docker push 192.168.2.90:5000/moudy/ubuntu:14.04

# Build Redis
cd /home/core/share/Dockerfiles/redis && ./build-redis.sh

# Build redis-server
cd /home/core/share/Dockerfiles/redis-server && ./build-redis-server.sh

# Build redis-cli
cd /home/core/share/Dockerfiles/redis-cli && ./build-redis-cli.sh

# Build 
cd /home/core/share/Dockerfiles/docker-register && ./build-docker-register.sh
# cd /home/core/share/Dockerfiles/dynamic-amb-etcd && ./build-dynamic-amb-etcd.sh


# # Build Centurylink ambassador 
# ./home/core/share/Dockerfiles/ctlc-docker-ambassador/build-ctlc-docker-ambassador.sh

# # Build Centurylink etcd register 
# ./home/core/share/Dockerfiles/ctlc-docker-amb-etcd/build-ctlc-docker-amb-etcd.sh