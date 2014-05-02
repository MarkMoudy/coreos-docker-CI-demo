#!/bin/bash
# Build Redis docker image container

cd /home/core/share/Dockerfiles/redis && \
/usr/bin/docker build --rm -t 192.168.2.90:5000/moudy/redis . && \
/usr/bin/docker push 192.168.2.90:5000/moudy/redis