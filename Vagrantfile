# -*- mode: ruby -*-
# # vi: set ft=ruby :

require 'fileutils'
# require_relative './config/vendor/coreos-vagrant/override-plugin.rb'
VAGRANTFILE_API_VERSION = "2"
CLOUD_CONFIG_PATH = "./config/vendor/coreos-vagrant/user-data"
CONFIG= "./config/vendor/coreos-vagrant/config.rb"

# Defaults for config options defined in CONFIG
$num_instances = 1
$enable_serial_logging = false
$vb_gui = false
$vb_memory = 1024
$vb_cpus = 1

# Attempt to apply the deprecated environment variable NUM_INSTANCES to
# $num_instances while allowing config.rb to override it
if ENV["NUM_INSTANCES"].to_i > 0 && ENV["NUM_INSTANCES"]
  $num_instances = ENV["NUM_INSTANCES"].to_i
end

if File.exist?(CONFIG)
	require_relative CONFIG
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "coreos-alpha"
  config.vm.box_version = ">= 308.0.1"
  config.vm.box_url = "http://storage.core-os.net/coreos/amd64-usr/alpha/coreos_production_vagrant.json"

  config.vm.provider :vmware_fusion do |vb, override|
    override.vm.box_url = "http://storage.core-os.net/coreos/amd64-usr/alpha/coreos_production_vagrant_vmware_fusion.json"
  end

  # Fix docker not being able to resolve private registry in VirtualBox
  # config.vm.provider :virtualbox do |vb, override|
  #   vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  #   vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  # end

  # plugin conflict
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  (1..$num_instances).each do |i|
    config.vm.define vm_name = "core-%02d" % i do |config|
      config.vm.hostname = vm_name

      if $enable_serial_logging
        logdir = File.join(File.dirname(__FILE__), "log")
        FileUtils.mkdir_p(logdir)

        serialFile = File.join(logdir, "%s-serial.txt" % vm_name)
        FileUtils.touch(serialFile)

        config.vm.provider :vmware_fusion do |v, override|
          v.vmx["serial0.present"] = "TRUE"
          v.vmx["serial0.fileType"] = "file"
          v.vmx["serial0.fileName"] = serialFile
          v.vmx["serial0.tryNoRxLoss"] = "FALSE"
        end

        config.vm.provider :virtualbox do |vb, override|
          vb.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
          vb.customize ["modifyvm", :id, "--uartmode1", serialFile]
        end
      end

      config.vm.provider :virtualbox do |vb|
        vb.gui = $vb_gui
        vb.memory = $vb_memory
        vb.cpus = $vb_cpus
      end
      # Forward Ports for etcd
      config.vm.network "forwarded_port", guest: 4001, host: "400#{i}".to_i
      # Expose Port for Docker on local host
      if $expose_docker_tcp
        config.vm.network "forwarded_port", guest: 4243, host: $expose_docker_tcp, auto_correct: true
      end
      ip = "192.168.2.#{i+100}"
      config.vm.network :private_network, ip: ip

      # Uncomment below to enable NFS for sharing the host machine into the coreos-vagrant VM.
      config.vm.synced_folder ".", "/home/core/share", id: "core", :nfs => true, :mount_options => ['nolock,vers=3,udp']

      if File.exist?(CLOUD_CONFIG_PATH)
        config.vm.provision :file, :source => "#{CLOUD_CONFIG_PATH}", :destination => "/tmp/vagrantfile-user-data"
        config.vm.provision :shell, :inline => "mv /tmp/vagrantfile-user-data /var/lib/coreos-vagrant/", :privileged => true
      end

    end
  end
    ## Setup Docker Registry VM
  config.vm.define "docker_registry" do |docker_registry|
    docker_registry.vm.hostname = "docker-registry"
    docker_registry.vm.network :private_network, ip: "192.168.2.90"
    docker_registry.vm.synced_folder ".", "/home/core/share", id: "core", :nfs => true, :mount_options => ['nolock,vers=3,udp']
    docker_registry.vm.provision "shell",
     path: "vagrant-registry.sh"
  end
end
