#!/bin/bash
# init-build.sh - Builds Docker images and pushes to Registry

cd /home/core/share/Dockerfiles/Jenkins && \
/usr/bin/docker build -rm -t 192.168.2.90:5000/moudy/jenkins . && \
/usr/bin/docker push 192.168.2.90:5000/moudy/jenkins



