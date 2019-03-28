Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.define "ubuntu" do |vb|
    vb.vm.box = "ubuntu/trusty64"
    vb.vm.hostname = "app-server"
    vb.vm.provision :shell, path: "bootstrap.sh"
    vb.vm.network "forwarded_port", guest: 80, host: 8001
    vb.vm.network "private_network", ip: "50.27.47.6" 
    vb.vm.synced_folder "www/", "/var/www/html"
  end
end
