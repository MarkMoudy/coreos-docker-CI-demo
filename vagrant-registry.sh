## Set up useful Docker alias commands - currently not working due to coreos readonly filesystem
# echo "alias dl='docker ps -l -q'" >> /home/core/.bashrc
# echo "alias cdel='docker rm $(docker ps -a -q)'" >> /home/core/.bashrc
# source /home/core/.bashrc

## build docker registry image
cd /home/core/share/Dockerfiles/Docker-Registry && /usr/bin/docker build --rm -t 192.168.2.90:5000/moudy/registry .
/usr/bin/docker run -d -p 5000:5000 -v /home/core/share/config/vendor/docker-registry:/registry-conf -e DOCKER_REGISTRY_CONFIG=/registry-conf/config.yml 192.168.2.90:5000/moudy/registry
# /usr/bin/docker push 192.168.2.90:5000/moudy/registry

