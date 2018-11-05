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

debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBRPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBRPASSWD"


# Installing packages
apt-get install -y mysql-server mysql-client   
# Allow External Connections on your MySQL Service
sudo sed -i -e 's/bind-addres/#bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i -e 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -u root -p$DBRPASSWD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY $DBRPASSWD; FLUSH privileges;"

echo -e "\n ************ Setting up our MySQL user and db ****************** \n"

# Import SQL data, if it is sitting in /vagrant dir
if [ ! -z `ls /vagrant/*.sql` ]; then	
	# Set variable to the basename of the file, minus '.sql'
	DBNAME=`ls /vagrant/*.sql | cut -d '/' -f 3 | sed s/.sql//`
	
	# Create a database with that name
	echo -e "Creating Database --- " $DBNAME
	mysqladmin -u root -p$DBRPASSWD create $DBNAME


	
	# Import the SQL into new database
	`mysql -u root -p$DBRPASSWD $DBNAME < /vagrant/$DBNAME.sql`

	echo -e "*************** Data Inserted Successfully !!! ********************"

	# Create a new user with same name as new db, with password 'pass'
	echo -e "**** Creating new db user *****"
	mysql -u root -p$DBRPASSWD -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSER'@'%' IDENTIFIED BY $DBPASSWD WITH GRANT OPTION; FLUSH PRIVILEGES;"
fi

sudo service mysql restart




#Install apache 2
echo Installing apache2
apt-get install -y apache2