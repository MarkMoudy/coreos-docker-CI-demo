#!/bin/bash
# init-build ubuntu:14.04 base docker image and push to private registry

# Build Ubuntu Base image from dotcloud customizations
/usr/bin/docker build --rm -t="192.168.2.90:5000/moudy/ubuntu:14.04" github.com/dockerfile/ubuntu && \
/usr/bin/docker push 192.168.2.90:5000/moudy/ubuntu:14.04