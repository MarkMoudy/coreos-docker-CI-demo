# coreos-vagrant is configured through a series of configuration
# options (global ruby variables) which are detailed below. To modify
# these options, first copy this file to "config.rb". Then simply
# uncomment the necessary lines, leaving the $, and replace everything
# after the equals sign..

# Size of the CoreOS cluster created by Vagrant
$num_instances=3

# Log the serial consoles of CoreOS VMs to log/
# Enable by setting value to true, disable with false
$enable_serial_logging=false

# Enable port forwarding of Docker TCP socket
# Set to the TCP port you want exposed on the *host* machine, default is 4243
# If 4243 is used, Vagrant will auto-increment (e.g. in the case of $num_instances > 1)
# You can then use the docker tool locally by setting the folloing env var:
#   export DOCKER_HOST='tcp://127.0.0.1:4243'
$expose_docker_tcp=4243

# Setting for VirtualBox VMs
$vb_gui = false
$vb_memory = 1024
$vb_cpus = 1
