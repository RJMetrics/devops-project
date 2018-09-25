## This Vagrantfile deploys LAMP application using Ansible Playbook 

Vagrant.require_version ">= 2.0.0"

Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb|
    vb.memory = 2048
  config.vm.network "forwarded_port", guest: 80, host: 8001
  config.vm.network "forwarded_port", guest: 3306, host: 3001
  end
  
  config.vm.box = "ubuntu/xenial64"
 
  config.vm.provision "ansible_local" do |lamp|
   lamp.playbook = "playbook.yml"
  end

  config.vm.define 'saikiran-webapp' do |lamp|
    lamp.vm.hostname = 'saikiran-webapp.vagrant.local'
    lamp.vm.network "private_network", type: "dhcp"
  end
end
