# VERSION 0.1
# DOCKER_VERSION	0.10.0
# DESCRIPTION			Docker Registry for hosting Docker images
# OTHER_INFO			See https://github.com/dotcloud/docker-registry/
# TO_BUILD				docker build --rm -t 192.168.2.90:5000/moudy/registry .
# TO_RUN					docker run -p 5000:5000 -v /home/core/share/config/vendor/docker-registry:/registry-conf -e DOCKER_REGISTRY_CONFIG=/registry-conf/config.yml 192.168.2.90:5000/moudy/registry


FROM ubuntu:13.10
MAINTAINER Mark Moudy "mark.moudy@ericsson.com"

RUN apt-get update; \
		apt-get install -y git-core build-essential python-dev \
    libevent1-dev python-openssl liblzma-dev wget; \
    rm /var/lib/apt/lists/*_*
RUN cd /tmp; wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
RUN cd /tmp; python ez_setup.py; easy_install pip; \
    rm ez_setup.py

RUN git clone --depth=50 git://github.com/dotcloud/docker-registry.git /docker-registry;  \
		cd /docker-registry; cp ./config/boto.cfg /etc/boto.cfg

RUN pip install /docker-registry/

ENV DOCKER_REGISTRY_CONFIG /docker-registry/config/config_sample.yml

EXPOSE 5000

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD cd /docker-registry && ./setup-configs.sh && exec docker-registry



