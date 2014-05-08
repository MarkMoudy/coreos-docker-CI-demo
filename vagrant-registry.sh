## Vagrant shell provisioner to build the Docker Private Registry image and start the registry 
## Set up useful Docker alias commands 
alias dl='docker ps -l -q'
alias cdel='docker rm $(docker ps -a -q)'

## build docker registry image
cd /home/core/share/Dockerfiles/Docker-Registry && \
/usr/bin/docker build --rm -t 192.168.2.90:5000/moudy/registry . && \
/usr/bin/docker run -d -p 5000:5000 -v /home/core/share/config/vendor/docker-registry:/registry-conf -v /tmp/registry:/tmp/registry -e DOCKER_REGISTRY_CONFIG=/registry-conf/config.yml 192.168.2.90:5000/moudy/registry && \
echo "Waiting 5 seconds for the Registry to come up";sleep 5s;/usr/bin/docker push 192.168.2.90:5000/moudy/registry
