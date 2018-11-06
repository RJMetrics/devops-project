#! /usr/bin/env bash

echo -e "\n ************ Updating and upgrading packages...  ******************\n"
apt-get update
apt-get upgrade

# Variables
DBHOST=localhost
DBNAME=Customers
DBUSER=testdb
DBPASSWD=testdb
DBRPASSWD=test123
DBTABL=Users


# ---------------------------------------
#          Setting up MySql
# ---------------------------------------
echo -e "\n ****************** Install MySQL specific packages and settings... ************** \n"
# Setting MySQL root user password root/root

debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password password $DBRPASSWD"
debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password_again password $DBRPASSWD"


#Installing packages
apt-get install -y mysql-server-5.6 mysql-client-5.6 mysql-common-5.6  
#Allow External Connections on your MySQL Service
sudo sed -i -e 's/bind-address/#bind-address/g' /etc/mysql/my.cnf
sudo sed -i -e 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/my.cnf
mysql -u root -p$DBRPASSWD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY $DBRPASSWD; FLUSH privileges;"

echo -e "\n ************ Setting up our MySQL user and db ****************** \n"

	
#Create a database with that name
echo -e "Creating Database --- " $DBNAME
mysql -u root -p$DBRPASSWD -e "CREATE DATABASE $DBNAME"
	
#Import the SQL into new database
`mysql -u root -p$DBRPASSWD $DBNAME < /vagrant/$DBNAME.sql`

echo -e "*************** Data Inserted Successfully !!! ********************"

#Create a new user with same name as new db, with password 'pass'
echo -e "**** Creating new db user *****"
mysql -u root -p$DBRPASSWD -e "CREATE USER $DBUSER identified by DBPASSWD"
`mysql -u root -p$DBRPASSWD < /vagrant/usr_access.sql`

#Restart mysql
service mysql restart



#Install apache 2
echo -e  "****** Installing apache2 ******"
apt-get install -y apache2

# Enable Apache mods
a2enmod rewrite



# Add Ondrej PPA Repo, required for php7
apt-add-repository ppa:ondrej/php
apt-get update


#Install PHP
echo -e "******** Installing PHP7.2 ***************"
apt-get install -y php7.2

#PHP Apache Mod
apt-get install -y libapache2-mod-php7.2

#Restart Apache
service apache2 restart

#Installing PHP Mods and mysql lib
apt-get install -y php7.2-common php7.2-mcrypt php7.2-zip php7.2-mysql



#Restart Apache
service apache2 restart
