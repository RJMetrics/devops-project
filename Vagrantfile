Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb|
    vb.memory = 2048
  end
  config.vm.box = "ubuntu/xenial64"
  config.omnibus.chef_version = :latest
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "base"
    chef.add_recipe "apache"
    chef.add_recipe "mysql"
    chef.add_recipe "php"
  end
  config.vm.define 'lamp-stack' do |set|
    set.vm.hostname = 'lamp-stack.vagrant.local'
    set.vm.network "private_network", type: "dhcp"
  end
  config.vm.network "forwarded_port", guest: 80, host: 8001
  config.vm.network "forwarded_port", guest: 3306, host: 3001
end
