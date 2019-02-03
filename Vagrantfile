Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb|
    vb.memory = 2048
  end
  ####### Provision #######
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "provision/playbook.yml"
    ansible.verbose = true
  end
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "forwarded_port", guest: 80, host: 8001
  config.vm.synced_folder "src", "/var/website"
end
