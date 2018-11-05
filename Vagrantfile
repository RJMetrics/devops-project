Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb|
    vb.memory = 2048
  end
  config.vm.box = "ubuntu/trusty64"

  #Network
  config.ssh.forward_agent = true
  config.vm.network "forwarded_port", guest: 80, host: 8001
  config.vm.network "forwarded_port", guest: 3306, host: 3001

  #Mount
  config.vm.synced_folder "./js/", "/var/www/html"

  #Provision
  config.vm.provision "shell", path: "bootstrap.sh"
  
end
