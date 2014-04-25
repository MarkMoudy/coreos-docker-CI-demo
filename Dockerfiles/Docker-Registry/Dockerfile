# VERSION 0.1
# DOCKER_VERSION	0.10.0
# DESCRIPTION			Docker Registry for hosting Docker images
# OTHER_INFO			See https://github.com/dotcloud/docker-registry/
# TO_BUILD				docker build -rm -t registry .
# TO_RUN					docker run -p 5000:5000 registry


FROM phusion/baseimage:0.9.9
MAINTAINER Mark Moudy "mark.moudy@ericsson.com"

# Set correct environment variables
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update; \
		apt-get install -y git-core build-essential python-dev \
    libevent1-dev python-openssl liblzma-dev wget; \
    rm /var/lib/apt/lists/*_*
RUN cd /tmp; wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
RUN cd /tmp; python ez_setup.py; easy_install pip; \
    rm ez_setup.py

RUN git clone https://github.com/dotcloud/docker-registry.git
#ADD . /docker-registry
ADD /docker-registry/config/boto.cfg /etc/boto.cfg

RUN pip install /docker-registry/

ENV DOCKER_REGISTRY_CONFIG /docker-registry/config/config_sample.yml

EXPOSE 5000

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD cd /docker-registry && ./setup-configs.sh && exec docker-registry



