#filename: provision.sh
#!/bin/bash

#########################################
# by Pradeep Mandha for RJMetrics test  #
#                                       #
# Apache                                #
# PHP Latest                            #
# MySQL Latest                          #       
#########################################


APP_DATABASE_NAME='testdb'

echoTitle () {
    echo -e "\033[0;30m\033[42m -- $1 -- \033[0m"
}


# ---------------------------------------------------------------------------------------------------------------------
echoTitle 'Virtual Machine Setup'
# ---------------------------------------------------------------------------------------------------------------------
# Update the packages Initally
apt-get update -qq
apt-get -y install git curl vim



# ---------------------------------------------------------------------------------------------------------------------
echoTitle 'Installing and Setting: Apache'
# ---------------------------------------------------------------------------------------------------------------------
# Install packages
apt-get install -y apache2 libapache2-mod-fastcgi 


# Add ServerName to httpd.conf
echo "ServerName localhost" > /etc/apache2/httpd.conf

# Setup hosts file
VHOST=$(cat <<EOF
  <VirtualHost *:8001>
      DocumentRoot /var/www/html
         ServerName localhost
         ServerAlias localhost

      <Directory "/var/www/html">
        Options FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        Allow from all
        DirectoryIndex index.php index.html index.htm
      </Directory>
    
  </VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-enabled/000-default.conf

sudo a2dismod mpm_event
sudo a2enmod mpm_worker
a2enmod actions fastcgi rewrite
sudo service apache2 restart

echo "Apache Installation is Succesful and Listening on port 8001" > /var/www/html/index.html

# ---------------------------------------------------------------------------------------------------------------------
# echoTitle 'MYSQL-Database'
# ---------------------------------------------------------------------------------------------------------------------
# Setting MySQL (username: root) ~ (password: password)
sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password_again password password'

# Installing packages
#apt-get install -y mysql-server-5.6 mysql-client-5.6 mysql-common-5.6 mysql-server
apt-get install -y mysql-server

# Setup database
mysql -uroot -ppassword -e "CREATE DATABASE IF NOT EXISTS $APP_DATABASE_NAME;";
mysql -uroot -ppassword -e "CREATE USER 'testdb'@'localhost' IDENTIFIED BY 'testdb';"
mysql -uroot -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password';"
mysql -uroot -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO 'testdb'@'%' IDENTIFIED BY 'testdb';"
mysql -uroot -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'password';"
mysql -uroot -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO 'testdb'@'localhost' IDENTIFIED BY 'testdb';"
mysql -uroot -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY 'password';"
#mysql -uroot -ppassword -e "USE testdb; CREATE TABLE Users (FirstName varchar(50) DEFAULT NULL, LastName varchar(50) DEFAULT NULL, Age bigint NOT NULL, CreatedAtTimestamp DATE DEFAULT NULL);"
mysql -uroot -ppassword -e "USE testdb; CREATE TABLE Users (id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY, firstname varchar(50) NOT NULL, lastname varchar(50) NOT NULL, age INT(3) NOT NULL, date TIMESTAMP);"



MYCNF=$(cat <<EOF
[mysqld_safe]
socket          = /var/run/mysqld/mysqld.sock
nice            = 0
[mysqld]
user            = mysql
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
port            = 3301
basedir         = /usr
datadir         = /var/lib/mysql
tmpdir          = /tmp
lc-messages-dir = /usr/share/mysql
skip-external-locking
bind-address            = 127.0.0.1
key_buffer_size         = 16M
max_allowed_packet      = 16M
thread_stack            = 192K
thread_cache_size       = 8
myisam-recover-options  = BACKUP
query_cache_limit       = 1M
query_cache_size        = 16M
log_error = /var/log/mysql/error.log
expire_logs_days        = 10
max_binlog_size   = 100M
EOF
)
echo "${MYCNF}" > /etc/mysql/mysql.conf.d/mysqld.cnf

sudo service mysql restart


# ---------------------------------------------------------------------------------------------------------------------
echoTitle 'Installing: PHP'
# ---------------------------------------------------------------------------------------------------------------------
# Add repository
add-apt-repository -y ppa:ondrej/php
apt-get update
apt-get install -y python-software-properties software-properties-common

# Remove PHP5
# apt-get purge php5-fpm -y
# apt-get --purge autoremove -y

# Install packages
apt-get install -y php7.1 php7.1-fpm 2> /dev/null
apt-get install -y php7.1-mysql 2> /dev/null
apt-get install -y mcrypt php7.1-mcrypt 2> /dev/null
apt-get install -y php7.1-cli php7.1-curl php7.1-mbstring php7.1-xml php7.1-mysql 2> /dev/null
apt-get install -y php7.1-json php7.1-cgi php7.1-gd php-imagick php7.1-bz2 php7.1-zip 2> /dev/null



# ---------------------------------------------------------------------------------------------------------------------
echoTitle 'Setting: PHP with Apache'
# ---------------------------------------------------------------------------------------------------------------------
apt-get install -y libapache2-mod-php7.1 2> /dev/null



# Apache PHP changes below
a2enconf php7.1-fpm

PHPINFO=$(cat <<EOF
 <?php

// Show all information, defaults to INFO_ALL
phpinfo();

?>
EOF
)

echo "${PHPINFO}" > /var/www/html/phpinfo.php

sudo service apache2 reload



# Final Test
echoTitle "Your Test machine has been provisioned"
echo "-------------------------------------------"
echo "Please remember your MySQL is available on port 3301 on Host and on 3306 on Guest machine with username 'root' and password 'password'"
echo "(you have to use 127.0.0.1 as opposed to 'localhost')"
echo "Apache is available on port 80"
echo " Database Info below"
echoTitle "Testing Apache Installation below"
echo "-------------------------------------------"
curl --silent http://127.0.0.1
echo "-------------------------------------------"
mysql -uroot -ppassword -e "USE testdb; show COLUMNS from Users;"
echo "Go Here for http://localhost:8001/phpinfo.php PHP info page"
echo "Head over to http://192.168.100.100 to get started"

