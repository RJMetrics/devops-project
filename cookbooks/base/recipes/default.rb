execute 'base_setup' do
	command "add-apt-repository ppa:ondrej/php && apt-get update"
	not_if 'apt-cache policy | grep ondrej'
end

package 'python-pip' do
	action :install
end

execute 'python-requests' do
	command "pip install requests"
	not_if 'pip list | grep requests'
end

execute 'python-mysql-client' do
	command "pip install mysql-connector-python"
	not_if 'pip list | grep mysql-connector-python'
end

execute 'python-pexpect' do
	command "pip install pexpect"
	not_if 'pip list | grep pexpect'
end
