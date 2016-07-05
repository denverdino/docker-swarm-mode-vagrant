# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$num_worker = 2
$num_nodes = $num_worker + 1
$vm_cpus = 2
$vm_mem = 2048
$manager_ip = "192.168.100.2"
$worker_ip_base = "192.168.100."
$node_ips = $num_nodes.times.collect { |n| $worker_ip_base + "#{n+2}" }


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  def customize_vm(config)
    config.vm.box = "ubuntu/trusty64"

    config.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", $vm_mem]
      v.customize ["modifyvm", :id, "--cpus", $vm_cpus]

      # Use faster paravirtualized networking
      v.customize ["modifyvm", :id, "--nictype1", "virtio"]
      v.customize ["modifyvm", :id, "--nictype2", "virtio"]
	    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
  end

  config.vm.define "node-1" do |node|
    customize_vm node
    manager_ip = $manager_ip
    node.vm.provision "shell", inline: "/vagrant/provision-manager.sh #{manager_ip}"
    node.vm.network "private_network", ip: "#{manager_ip}"
    node.vm.hostname = "node-1"
  end

  $num_worker.times do |n|
    config.vm.define "node-#{n+2}" do |node|
      customize_vm node
      node_index = n+2
      node_ip = $node_ips[n + 1]
      manager_ip = $manager_ip
      node.vm.provision "shell", inline: "/vagrant/provision-worker.sh #{manager_ip} #{node_ip}"
      node.vm.network "private_network", ip: "#{node_ip}"
      node.vm.hostname = "node-#{node_index}"
    end
  end

end
