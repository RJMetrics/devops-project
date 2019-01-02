Chef LAMP Recipe 
===================
A reusable and extensible collection for provisioning a LAMP server using Chef and Vagrant.

## Installation
Follow the installation instructions for [Chef](https://downloads.chef.io/) and [Vagrant](https://www.vagrantup.com/downloads.html) before following the setup instructions to tailor your server.
Once you have cloned the repository, be sure to fetch and install the required dependencies below.<br>
vagrant plugin install vagrant-omnibus  &&<br> 
vagrant plugin install vagrant-berkshelf <br>

## Setup
In order to get quickly started, you can just clone this repository and run `vagrant up` from root of this repo.

##Details
For following to the host<br>
    1. Your Web server should be reachable on http://localhost:8001 <br>
    2. Your phpinfo.php info page is at http://localhost:8001/phpinfo.php <br>
    3. Your database server on port 3001 <br>
