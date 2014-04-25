#CoreOS + Docker Continuous Integration Demo

### Objective
Create a reference demo showing how Continuous Integration can be done using CoreOS and Docker.  

### Tools Used
* Docker
* CoreOS
* Phusion baseimage - Container base ubuntu image
* fig?
* Jenkins or Apache Continuum for CI build server 
* Vagrant - for Dev Environment

### System Diagram and Components
tbd

### Environment Setup
1. Install [Vagrant][https://www.vagrantup.com/downloads.html] and either [VirtualBox][https://www.virtualbox.org] or VmWare Fusion  
2. Install CoreOS tools for Fleet and Etcd  
```BASH
# Install etcdctl
$ brew install go etcdctl
# Build and install fleetctl
$ git clone https://github.com/coreos/fleet.git
$ cd fleet && ./build
## You may need to create the /usr/local/bin path on OSX Mavericks and 
## put it in your path if it doesn't exist already
$ mv bin/fleetctl /usr/local/bin
## Test that etcdctl and fleetctl work
$ etcdctl -v
$ fleetctl -v

```
3. Clone repo and CD to directory  
4. Generate new etcd cluster discovery token: 
```Bash
$ cp config/vendor/coreos-vagrant/user-data.sample config/vendor/coreos-vagrant/user-data && DISCOVERY_TOKEN=`curl -s https://discovery.etcd.io/new` && perl -p -e "s@#discovery: https://discovery.etcd.io/<token>@discovery: $DISCOVERY_TOKEN@g" config/vendor/coreos-vagrant/user-data.sample > config/vendor/coreos-vagrant/user-data
```
5. Bring up Cluster using Vagrant with either the VirtualBox or VmWare Fusion Provider:

```Bash
## Using VirtualBox
$ vagrant up
## Using VmWare Fusion(Must have paid license key and plugin installed)
$ vagrant up --provider vmware_fusion
```

6. Set fleetctl tunnel environment variable to manage cluster: 
```bash
$ `FLEETCTL_TUNNEL=127.0.0.1:4001`
```  
7. Use fleetctl to check for machines in cluster `fleetctl list-machines`

###Links to Documentation
[fleetctl - Remote Fleet Access configuration with Vagrant][https://github.com/coreos/fleet/blob/master/Documentation/remote-access.md]  
[fleetctl - Using the client][https://github.com/coreos/fleet/blob/master/Documentation/using-the-client.md]

must generate a new etcd token before each vagrant up: 
```

```
then after bring up the boxes, you need to set the env variable `FLEETCTL_TUNNEL=127.0.0.1:4001`  
`fleetctl list-machines`

list last used container: `alias dl='docker ps -l -q'`

##Fleet
Installing Fleetctl client command line tool on your machine: 
1. 

[]


