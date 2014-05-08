# VERSION 				0.2.4.11
# DOCKER_VERSION	0.10.0
# DESCRIPTION			Docker etcd Register docker image
# TO_BUILD				docker build --rm -t 192.168.2.90:5000/moudy/docker-register .
# TO_RUN					docker run --link <ambassador_service_name>:etcd -v /var/run/docker.sock:/var/run/docker.sock --rm 192.168.2.90:5000/moudy/docker-register <service_name_to_watch> <port> <service_name>


FROM 192.168.2.90:5000/moudy/ubuntu:14.04
# FROM stackbrew/ubuntu:13.04
# FROM phusion/baseimage:0.9.9
MAINTAINER Mark Moudy "mark.moudy@ericsson.com"

# Import dependencies
ADD etcdctl /usr/bin/etcdctl
ADD docker /usr/bin/docker
ADD libdevmapper.so.1.02 /lib/libdevmapper.so.1.02
# ADD libudev.so.1 /lib/libudev.so.1

# RUN apt-get update
# RUN apt-get install -y curl build-essential
# RUN curl -s https://get.docker.io/ubuntu/ | sudo sh

# RUN apt-get install -y docker.io build-essential
# RUN ln -sf /usr/bin/docker.io /usr/bin/docker

# # Install Go dependency
# ENV CGO_ENABLED 0
# RUN curl -s https://go.googlecode.com/files/go1.2.src.tar.gz | tar -v -C /usr/local -xz
# RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
# ENV PATH /usr/local/go/bin:$PATH

# RUN cd /tmp; git clone https://github.com/coreos/etcdctl.git
# RUN cd /tmp/etcdctl; ./build; cp bin/etcdctl /usr/bin/etcdctl

ADD docker-reg.sh /usr/bin/docker-reg.sh

# Clean up APT and tmp when finished
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/usr/bin/docker-reg.sh"]