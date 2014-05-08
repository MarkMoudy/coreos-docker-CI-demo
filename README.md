##CoreOS + Docker Continuous Integration Demo

This is a reference environment showing how CoreOS and Docker can be set up in a local environment.  

#### System Diagram and Components
tbd

### Environment Setup
1. Install [Vagrant 1.5.4+](https://www.vagrantup.com/downloads.html) and either [VirtualBox 4.3.10+](https://www.virtualbox.org) or [VMware Fusion 5.0.4+](http://www.vmware.com/products/fusion) - for VMware you must purchase a license for the [Vagrant Vmware provider plugin](http://www.vagrantup.com/vmware) ~$79.00
2. Install CoreOS host tools for Fleet and Etcd  
    		
    ```bash
    ## Install etcdctl
    $ brew install go etcdctl
    ## Build and install fleetctl
    $ git clone https://github.com/coreos/fleet.git
    $ cd fleet && ./build
    ## You may need to create the /usr/local/bin path on OSX Mavericks and 
    ## put it in your path if it doesn't exist already
    $ mv bin/fleetctl /usr/local/bin
    ## Test that etcdctl and fleetctl work
    $ etcdctl -v
    $ fleetctl -v
    ``` 
3. Clone repo and CD to directory: `git clone https://github.com/MarkMoudy/coreos-docker-CI-demo.git && cd coreos-docker-CI-demo`
4. Generate new etcd cluster discovery token(**IMPORTANT** You must do this everytime you bring up a fresh cluster):

    ```bash
    # Use the script
    $ ./preinstall.sh
    # or 
    $ cp config/vendor/coreos-vagrant/user-data.sample config/vendor/coreos-vagrant/user-data && \
    DISCOVERY_TOKEN=`curl -s https://discovery.etcd.io/new` && \
    perl -p -e "s@#discovery: https://discovery.etcd.io/<token>@discovery: $DISCOVERY_TOKEN@g" \
    config/vendor/coreos-vagrant/user-data.sample > config/vendor/coreos-vagrant/user-data
    ```
5. Bring up Cluster using Vagrant with either the VirtualBox or VmWare Fusion Provider:

    ```bash
    ## you will have to enter your password for the NFS Shared folders
    ## Using VirtualBox
    $ vagrant up
    ## Using VmWare Fusion(Must have paid license key and plugin installed)
    $ vagrant up --provider vmware_fusion
    ```
6. Set fleetctl tunnel environment variable to manage cluster: `FLEETCTL_TUNNEL=127.0.0.1:4001`
7. Use fleetctl to check for machines in cluster `fleetctl list-machines`

### Usage
There are several use cases represented with this demo using Fleetctl and systemd:
* Starting a container remotely
* Building and pushing a container to a private registry
* Creating a container using systemd


#### 1. Starting a container
Once you have the environment setup you can use the fleetctl client to push systemd .service files to the cluster. Fleet is a distributed init system that sits on top of etcd and systemd to make intraction with the cluster easier. There are several systemd unit files located in the [services/](https://github.com/MarkMoudy/coreos-docker-CI-demo/tree/master/services) directory. Start by using fleetctl to push `dillinger.service` to the cluster. 
```bash
$ fleetctl submit services/dillinger.service
# You can view the files sent to fleet with the fleetctl list-units command
$ fleetctl start dillinger.service
``` 
If you run the command `fleetctl journal dillinger.service` you can see the logs from the container and if you navigate in your browser to the ip address of the node that the service was started on at port 3000(`192.168.2.<replace>:3000`), you will see that dillinger is running. 

#### 2. Pushing a Container to private registry
I have set up a private docker registry running at 192.168.2.90 which should come up when you start the cluster. An important piece of pushing images to a private registry is that you have to tag the Docker image with the ip and port. If you look in the [init-build.sh](https://github.com/MarkMoudy/coreos-docker-CI-demo/blob/master/Dockerfiles/init-build.sh) script you can see the commands to build a jenkins container image from a Dockerfile. 

#### 3. Creating a container with systemd
Etcd uses [systemd unit files](https://coreos.com/docs/launching-containers/launching/getting-started-with-systemd) to define the service that you are launching. Below is an example of how this would work for the Jenkins container image: 
```
[Unit]
Description=Jenkins Docker Service
Requires=docker.service
After=docker.service
After=etcdctl.service

[Service]
ExecStart=/usr/bin/docker run -p 80:8080 192.168.2.90:5000/moudy/jenkins
ExecStartPost=/usr/bin/etcdctl set /cidemo/%p/%H:%i running
ExecStop=/usr/bin/docker stop 192.168.2.90:5000/moudy/jenkins
ExecStopPost=/usr/bin/etcdctl rm /cidemo/%p/%H:%i 
```

`ExecStartPost` - this sets the key/value of the service to etcd and is using modifiers to fill in the path. [More Info](https://coreos.com/docs/launching-containers/launching/getting-started-with-systemd/#advanced-unit-files)

### Ambassadors
Ambassadors are containers who's sole purpose is to help connect containers across multiple hosts. See Redis-demo service files for an example.

### etcd, systemd, and Fleet
You can use [sidekick systemd unit files](http://coreos.com/docs/launching-containers/launching/launching-containers-fleet/#run-a-simple-sidekick) to register and de-register services to etcd. Using the Jenkins service as an example, there are two files to inspect `jenkins@8080.1.service` and `jenkins-discovery.1.service`. jenkins-discovery.1.service announces the jenkins service to etcd and removes the key after stopping. Use fleet to start `jenkins@8080.1.service` and `jenkins-discovery.1.service`. Then check etcd with `etcdctl ls --recursive` and you should see something like: 
```bash
$ etcdctl ls --recursive
/services
/services/ci
/services/ci/jenkins1
```
Then get the contents of the key with `fleetctl ssh <machine_id> etcdctl get /services/ci/jenkins1` and you should see: 
```bash
# replace f49b7ee7 with any one of your <machine_ids> found with fleetctl list-machines(they should all return the same values)
etcdctl get f49b7ee7 /services/ci/jenkins1
{ "host": "core-02", "port": "80" }
```

#### Notes
* CoreOS has a [Chaos Monkey](https://twitter.com/spkane/status/364969488967401472) deal implemented so the nodes will randomly shut down and kick you out. Use vagrant to reload the node that crashed to get the shared folders back. [Fix](http://coreos.com/docs/cluster-management/debugging/prevent-reboot-after-update/)

#### Tips and Tricks

* Docker - list last used container by setting: `alias dl='docker ps -l -q'`.  Use in any command by replacing containerID with `` `dl` ``
* Docker - Delete all stopped containers: `alias cdel='docker rm $(docker ps -a -q)'`
* set both `alias dl='docker ps -l -q'; alias cdel='docker rm $(docker ps -a -q)'`


#### Useful Documentation
* [fleetctl - Remote Fleet Access configuration with Vagrant](https://github.com/coreos/fleet/blob/master/Documentation/remote-access.md)  
* [fleetctl - Using the client - good list of commands](https://github.com/coreos/fleet/blob/master/Documentation/using-the-client.md)
* [etcd - Strategies for dealing with stale data in etcd](http://stackoverflow.com/questions/21597039/how-to-deal-with-stale-data-when-doing-service-discovery-with-etcd-on-coreos#answer-21611128)
* [Customizing Docket - Docker Daemon Sockets systemd tips](http://coreos.com/docs/launching-containers/building/customizing-docker/)

