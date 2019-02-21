execute 'base_setup' do
	command "add-apt-repository ppa:ondrej/php && apt-get update"
end

package 'python-pip' do
	action :install
end

execute 'python_packages' do
	command "pip install mysql-connector-python && pip install pexpect && pip install requests"
end
