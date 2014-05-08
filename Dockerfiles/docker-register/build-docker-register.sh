#!/bin/bash
# build-docker-register.sh - Builds Docker-register image 

cd /home/core/share/Dockerfiles/docker-register
cp /usr/bin/etcdctl .
cp /usr/bin/docker .
cp /lib64/libdevmapper.so.1.02 .
cp /lib64/libudev.so.1 .

/usr/bin/docker build --rm -t 192.168.2.90:5000/moudy/docker-register . && \
/usr/bin/docker push 192.168.2.90:5000/moudy/docker-register

rm -f etcdctl docker libdevmapper.so.1.02 libudev.so.1

