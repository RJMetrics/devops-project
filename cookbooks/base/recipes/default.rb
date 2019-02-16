execute 'base_setup' do
	command "bash -c 'add-apt-repository ppa:ondrej/php && 
	                  apt-get update'"
end

package 'python-pip' do
	action :install
end

execute 'python_mysql_connector' do
	command "pip install mysql-connector-python"
end
