VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "bento/ubuntu-16.04"

  config.vm.hostname = 'mpr.vagrant.local'
  config.vm.network "forwarded_port", guest: 80, host: 8001
  config.vm.network "forwarded_port", guest: 3006, host: 3001


  config.vm.network :forwarded_port, guest: 80, host: 8001

  #chef
 config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "my_cookbooks"
    chef.add_recipe   "webapp"

    chef.json = {
      :webapp => {
        
      }
    }
  end

  
  config.omnibus.chef_version = :latest

# berkshelf
#  config.berkshelf.enabled = true
end

