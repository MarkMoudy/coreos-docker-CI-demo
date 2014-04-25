# VERSION 				0.1
# DOCKER_VERSION	0.10.0
# DESCRIPTION			Docker container for Jenkins
# TO_BUILD				docker build -rm -t 192.168.2.101:5000/moudy/jenkins .
# TO_RUN					docker run -p 80:8080 192.168.2.101:5000/moudy/jenkins


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

RUN echo deb http://archive.ubuntu.com/ubuntu precise universe >> /etc/apt/sources.list
RUN apt-get update && apt-get clean
RUN apt-get install -q -y openjdk-7-jre-headless && apt-get clean
ADD http://mirrors.jenkins-ci.org/war/1.560/jenkins.war /opt/jenkins.war
RUN ln -sf /jenkins /root/.jenkins
# RUN usermod -a -G docker jenkins

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]
EXPOSE 8080
VOLUME ["/jenkins"]
CMD [""]


