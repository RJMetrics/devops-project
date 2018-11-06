Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb|
    vb.memory = 1024
  config.vm.network "forwarded_port", guest: 80, host: 8001
  config.vm.network "forwarded_port", guest: 3306, host: 3001
  end
  
  config.vm.box = "ubuntu/xenial64"
 
  config.vm.provision "ansible_local" do |ans|
   ans.playbook = "playbook.yml"
  end

  config.vm.define 'dinesh94g-proj' do |ans|
    ans.vm.hostname = 'dinesh94g-proj.vagrant.local'
    ans.vm.network "private_network", type: "dhcp"
  end
end
