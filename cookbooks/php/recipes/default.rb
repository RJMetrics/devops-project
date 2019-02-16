package "php" do
	action :install
end

directory '/var/www/php' do
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

file '/var/www/php/phpinfo.php' do
	content '<?php 
//show all information, defaults to INFO_ALL
phpinfo();

?>'
        mode '0755'
	owner 'root'
	group 'root'
end

file '/var/www/php/index.html' do
	content '<html> this is php default page from /var/www/php.</html>'
	mode '0755'
	owner 'root'
	group 'root'
end

execute "start php" do
	command "nohup php -S 0.0.0.0:8000 -t /var/www/php &"
end
