# VERSION 				0.1
# DOCKER_VERSION	0.10.0
# DESCRIPTION			Docker container for Jenkins
# TO_BUILD				docker build -rm -t 192.168.2.90:5000/moudy/jenkins .
# TO_RUN					docker run -p 80:8080 192.168.2.90:5000/moudy/jenkins


FROM ubuntu:13.10
MAINTAINER Mark Moudy "mark.moudy@ericsson.com"

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


