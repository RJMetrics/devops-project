Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb|
    vb.memory = 2048
  end
    
  #Ubuntu 16.04 box
  config.vm.box = "ubuntu/xenial64"
    
  #Expose MySQL default port to 3001 on Host
  config.vm.network "forwarded_port", guest: 3306, host: 3001
  #Expose Apache port 80 to 8001 on Host
  config.vm.network "forwarded_port", guest: 80, host: 8001
    
  # Run Ansible Provisioner from Vagrant VM
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
  end
    
end
