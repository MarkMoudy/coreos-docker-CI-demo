#!/bin/bash
# build-redis-cli.sh - Builds redis cli docker image and pushes to registry

cd /home/core/share/Dockerfiles/redis-cli && \
/usr/bin/docker build --rm -t 192.168.2.90:5000/moudy/redis-cli . && \
/usr/bin/docker push 192.168.2.90:5000/moudy/redis-cli