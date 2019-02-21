package "mysql-server" do
	action :install
end

package "mysql-client" do
	action :install
end

execute "bind-address" do
	command 'sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf && service mysql restart'
	only_if 'grep 127.0.0.1 /etc/mysql/mysql.conf.d/mysqld.cnf'
end

service "mysql" do
	action [:enable, :start]
end

execute "mysql_db_initial_setup" do
	command 'python /vagrant/mysql_root_native_password.py && python /vagrant/mysql_setup.py --setup'
	not_if { ::File.exist?('/tmp/base_mysql_setup.log')}
end
