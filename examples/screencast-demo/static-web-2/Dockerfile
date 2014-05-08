# VERSION 				0.1
# DOCKER_VERSION	0.10.0
# DESCRIPTION			Static Web 2 for Screencast demo
# TO_BUILD				docker build --rm -t 192.168.2.90:5000/demo/static-web-2 .
# TO_RUN					docker run --rm -p 80:8080 192.168.2.90:5000/demo/static-web-2


FROM 192.168.2.90:5000/moudy/ubuntu:14.04
MAINTAINER Mark Moudy "mark.moudy@ericsson.com"

# Install dependencies
RUN curl https://raw.githubusercontent.com/isaacs/nave/master/nave.sh > /bin/nave && chmod a+x /bin/nave
RUN nave usemain stable
RUN npm install harp -g

# Add required files to container
RUN mkdir -p /opt/services/static-web-2
ADD static-web-2.html /opt/services/static-web-2/index.html

EXPOSE 8080

CMD harp server --port 8080 /opt/services/static-web-2
