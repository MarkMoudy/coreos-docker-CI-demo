## Static Web Service CoreOS cluster Demo

### Overview
This is a reference demo for the CoreOS development environment showing off some key features of the stack. The main idea is that you are pushing three services running static web servers to your cluster. The three static web services cannot run on the same host so we use the `[X-Fleet]` specifications to eliminate conflicts in the cluster. The demo also shows off how you can kill a host in the cluster and fleet will move the service to another available host if it is available. 

### Walkthrough
This is coming


### Resources
This demo was heavily influnced by a set of blog posts by [Luke Bond](https://twitter.com/lukeb0nd) which can be found on his blog [Luke Nodes Best](http://lukebond.ghost.io/).
* [Deploying Docker Containers on a Vagrant CoreOS Cluster with fleet](http://lukebond.ghost.io/deploying-docker-containers-on-a-coreos-cluster-with-fleet/) 