package "mysql-server" do
	action :install
end

package "mysql-client" do
	action :install
end

execute "bind-address" do
	command 'sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf && service mysql restart'
	only_if 'grep 127.0.0.1 /etc/mysql/mysql.conf.d/mysqld.cnf'
end

service "mysql" do
	action [:enable, :start]
end
