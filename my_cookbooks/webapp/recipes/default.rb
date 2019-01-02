
cookbook_file "/tmp/provison.sh" do
  source "provison.sh"
  mode 0755
end

execute "install my LAMP" do
  command "bash /tmp/provison.sh"
end

#Dir.foreach("#{node[:chef][:cache_path]}/cookbooks/webapp/templates/default/") do | file |
#  template "/var/www/html/#{file}" do
#    source "#{file}"
#    owner 'root'
#    group 'root'
#    mode '0755'
#  end
#end

template '/var/www/html/common.php' do
  source 'common.php.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/var/www/html/config.php' do
  source 'config.php.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/var/www/html/create.php' do
  source 'create.php.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/var/www/html/display.css' do
  source 'display.css.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/var/www/html/index.php' do
  source 'index.php.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/var/www/html/list.php' do
  source 'list.php.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/var/www/html/phpinfo.php' do
  source 'phpinfo.php.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/var/www/html/style.css' do
  source 'style.css.erb'
  owner 'root'
  group 'root'
  mode '0755'
end