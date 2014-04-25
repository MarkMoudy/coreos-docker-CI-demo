#!/bin/bash

#set up new etcd discovery token to prepare for new cluster
cp config/vendor/coreos-vagrant/user-data.sample config/vendor/coreos-vagrant/user-data && DISCOVERY_TOKEN=`curl -s https://discovery.etcd.io/new` && perl -p -e "s@#discovery: https://discovery.etcd.io/<token>@discovery: $DISCOVERY_TOKEN@g" config/vendor/coreos-vagrant/user-data.sample > config/vendor/coreos-vagrant/user-data
