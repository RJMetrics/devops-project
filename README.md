# devops-project
Create a Vagrantfile which provisions a VM

# Introduction
Hi, thanks for your interest in our Devops Engineering position. As part of the interview process, we'd like you to setup a simple web application and database.

# Steps
1. Fork this repo to your personal GitHub profile
2. Clone this repo to your computer
3. Modify the initial Vagrantfile to setup the web application.
4. Add any code/scripts needed to provision the server.
5. Add to the bottom of this README.md file details on how to run you project locally.
6. Make a pull request for us to review your code.

### Your project should
1. Use the specified Ubuntu 16.04 box as the starting point
2. Install the following components
    1. The latest MySQL
    2. The latest Apache2
    3. The latest PHP 7.X
3. Configure the following components
    1. Create a "Users" table in the database with the following columns
        1. "FirstName"
        2. "LastName"
        3. "Age"
        4. "CreatedAtTimestamp"
    2. The database username and password should be "testdb"
    3. Run the http/application server on port 80 on the guest
    4. Create a "phpinfo.php" page which shows the PHP details
4. Expose the following to the host
    1. Your application server should be reachable on http://localhost:8001
    2. Your phpinfo.php page should be at http://localhost:8001/phpinfo.php
    3. Your database server on port 3001

### Bonus points
1. Create a webapp/single page that allows the following
    1. Include forms to allow user input of "FirstName" "LastName" and "Age" and to persist it to the database
    2. Include a way to view the full "Users" table
2. NOTE: This can be done in any language.

### You should
1. Use any form of provisioning you'd like (Ansible, Chef, Puppet, Salt, sh/csh/bash/ksh scripting)
2. Allow SSH access to the VM while it is running

### It's not reqiured, but your project can
1. Use open source libraries
2. Use multiple provisioners or bootstrap your own
3. Use multiple VMs to run the different components

### We will evaluate the project based on the following criteria
1. Meeting the project requirements listed above
2. Code quality
3. Bonus points section completion

Feel free to reach out to us for clarifications.

Thanks and good luck!

### !!!!!!!!!!!!!!!!!!!!INSTUCTIONS TO SETUP VM!!!!!!!!!!!!!!!!!!!!

### Host Pre Requisites
1. virtual box up and running
2. vagrant exe available from PATH
3. git command available
4. vagrant plugin install
```
#vagrant plugin install vagrant-omnibus
```
5. python is installed.
6. python modules 'mysql.connector', 'requests', 'socket' is available in HOST.
Note: step 5 and 6 are needed to run check setup in HOST


### Start the setup
1. clone the devops-project from git repo
```
#git clone https://github.com/usunnapu/devops-project
```
2. change directory to devops-project 
```
#cd devops-project 
```
3. bring the vm up using vagrant command
```
#vagrant up
```
Note: Time to bring the VM up depends on network connectivity. Give it few minutes to start ~5-7 min 

### Test the setup from VM

4. ssh to the vm
```
#vagrant ssh
```
5. Run validation script (this will check the testdb user, tcp port and url connectivity)
```
#python /vagrant/check_setup.py --env vm
```

### Test the setup from HOST

6. Run validation script from host (Ensure requests, socket modules are available in python)
```
#python /vagrant/check_setup.py --env host
```
Note: requests and socket modules should be available in python

7. check the application server URL
```
a) open a browser
b) type in the url `http://localhost:8001`
   Note: a simple text message is displayed as below
   `this is http/php default page from /var/www/html`
```
8. check the phpinfo page
```
a) open a browser
b) type in the url `http://localhost:8001/phpinfo.php`
   Note: all details regarding php is defined here
```
9. check users added/listed (to/from) Users table 
```
a) open a browser
b) type in the url `http://localhost:8001/update_get_db_users.php
   Note: Enter any choice of 'FirstName', 'LastName', 'Age (Only Integers allowed)'
c) click on 'AddToDB' button. This will add the details provided to the `Users` table
d) click on 'GetUser' buttom. This will display all the users in `Users` table.
```

### Common Issues noticed were related to not having below items checked
```
1. Ensure ports 8001 and 3001 are free in the host. 
2. Ensure python is available 'mysql.connector', 'requests' and 'socket' modules are available in host.
Note: socket module should be built in for python. 
Note: if pip is available, run 'pip install requests'
3. To test sql connection, host needs mysql connector downloaded and installed
Note: run 'pip install mysql-connector-python' to install mysql connector
```

### Sample Results 

Setup checked from Host

```
Note: below command is run from the in host. Script location should be in the cloned directory of devops-project

DESKTOP-JA4JMV1 MINGW64 ~/Desktop/devops-project (vagrant)
$ python check_setup.py --env host
host: localhost port: 8001 status:  OK
host: localhost port: 3001 status:  OK
URL: http://localhost:8001 status:  OK
URL: http://localhost:8001/phpinfo.php status:  OK
URL: http://localhost:8001/update_get_db_users.php status:  OK
user: testdb database: mysql status:  OK
```

setup checked from vm

```
vagrant@lamp-stack:~$ python /vagrant/check_setup.py --env vm
host: localhost port: 80 status:  OK
host: localhost port: 3306 status:  OK
URL: http://localhost:80 status:  OK
URL: http://localhost:80/phpinfo.php status:  OK
URL: http://localhost:80/update_get_db_users.php status:  OK
user: testdb database: mysql status:  OK
```
