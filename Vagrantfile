Vagrant.configure("2") do |config|

  config.vm.define "control" do |control|
    control.vm.box  = "ubuntu/trusty64"
    control.vm.network "private_network", ip: "192.168.33.10"
    control.vm.hostname = "control"
    control.vm.synced_folder ".", "/vagrant", type: "nfs"
    control.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--name", "control"]
      vb.memory = "1024"
    end
    control.vm.provision "shell", inline: <<-SHELL
      sudo apt-get install software-properties-common -y
      sudo add-apt-repository ppa:ansible/ansible-2.3 -y
      sudo apt-get update -y
      sudo apt-get install ansible -y
    SHELL
  end

    config.vm.define "web01" do |web01|
      web01.vm.box  = "ubuntu/trusty64"
      web01.vm.network "forwarded_port", guest: 80, host: 8001
      web01.vm.network "forwarded_port", guest: 3306, host: 3001
      web01.vm.network "private_network", ip: "192.168.33.11"
      web01.vm.hostname = "web01"
      web01.vm.synced_folder ".", "/vagrant", type: "nfs"
      web01.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--name", "web01"]
        vb.memory = "1024"
      end
    end

end
  
  

