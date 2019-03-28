#!/usr/bin/env bash

sudo apt-get update 
sudo apt-get upgrade -y

# Installing latest verison for apache
sudo apt-get install apache2 -y

sudo bash -c 'cat <<EOT >> /etc/apache2/apache2.conf
ServerName localhost
EOT'

sudo service apache2 restart
sudo apache2ctl configtest
sudo apt-add-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get install php7.1 -y


# Updating Mysql User and password
debconf-set-selections <<< 'mysql-server mysql-server/root_password password testdb'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password testdb'
apt-get update
apt-get install -y mysql-server  php7.1-mysql


# Import the SQL into new database - Creating a db called register
echo "--> Creating a fresh database..."
mysql -uroot  -ptestdb --execute "DROP DATABASE IF EXISTS register; CREATE DATABASE register CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
echo "<-- Complete."
mysql -u root -ptestdb register < /var/www/html/register.sql

echo "-->  create a new user and password..."
mysql -uroot  -ptestdb --execute "CREATE USER 'testdb'@'%' IDENTIFIED BY 'testdb'; GRANT ALL PRIVILEGES ON *.* TO 'testdb'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"
echo "<-- Complete."

sudo touch /var/www/html/phpinfo.php
sudo bash -c 'cat <<EOT >> /var/www/html/phpinfo.php
<?php

//Show all information, defaults to INFO_ALL
phpinfo();

?>
EOT'
sudo sed -i 's/^port.*/port = 3001/' /etc/mysql/my.cnf 
sudo rm -rf /var/www/html/index.html
sudo service apache2 restart
sudo /etc/init.d/mysql restart 