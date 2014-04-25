##CoreOS + Docker Continuous Integration Demo

This is a reference environment showing how CoreOS and Docker can be set up in a local environment.  

#### System Diagram and Components
tbd

### Environment Setup
=====================
1. Install [Vagrant](https://www.vagrantup.com/downloads.html) and either [VirtualBox](https://www.virtualbox.org) or [VmWare Fusion](http://www.vmware.com/products/fusion)
2. Install CoreOS tools for Fleet and Etcd  
    		
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
==========
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
#### 3. Creating a container with systemd

#### Notes
* CoreOS has a [Chaos Monkey](https://twitter.com/spkane/status/364969488967401472) deal implemented so the nodes will randomly shut down and kick you out. Use vagrant to reload the node that crashed to get the shared folders back. [Fix](http://coreos.com/docs/cluster-management/debugging/prevent-reboot-after-update/)

#### Tips and Tricks

* Docker - list last used container by setting: `alias dl='docker ps -l -q'`.  Use in any command by replacing containerID with `` `dl` ``
* Docker - Delete all stopped containers: `alias cdel='docker rm $(docker ps -a -q)'`

#### Useful Documentation
* [fleetctl - Remote Fleet Access configuration with Vagrant](https://github.com/coreos/fleet/blob/master/Documentation/remote-access.md)  
* [fleetctl - Using the client](https://github.com/coreos/fleet/blob/master/Documentation/using-the-client.md)

