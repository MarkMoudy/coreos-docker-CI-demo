#!/bin/bash

cd /home/core/share/examples/screencast-demo/static-web-1 && \
docker build --rm -t 192.168.2.90:5000/demo/static-web-1 . && \
docker push 192.168.2.90:5000/demo/static-web-1

cd /home/core/share/examples/screencast-demo/static-web-2 && \
docker build --rm -t 192.168.2.90:5000/demo/static-web-2 . && \
docker push 192.168.2.90:5000/demo/static-web-2

cd /home/core/share/examples/screencast-demo/static-web-3 && \
docker build --rm -t 192.168.2.90:5000/demo/static-web-3 . && \
docker push 192.168.2.90:5000/demo/static-web-3