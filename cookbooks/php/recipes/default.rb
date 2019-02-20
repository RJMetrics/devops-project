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

file '/var/www/php/update_get_db_users.php' do
	content "<body>
<FORM NAME ='form1' METHOD ='POST' ACTION = 'update_get_db_users.php'>
     FirstName: <INPUT TYPE = 'TEXT' VALUE ='' Name='firstname'>
     LastName: <INPUT TYPE = 'TEXT' VALUE ='' Name='lastname'>
     Age(Only Integer): <INPUT TYPE = 'TEXT' VALUE ='' Name='age'>
<INPUT TYPE = 'Submit' Name = 'Submit1' VALUE = 'AddToDB'>
</FORM>
</body>

<html>
<body>
    <form method='post'>
    <p>
        <button name='button'>Get Users</button>
    </p>
    </form>
</body>

<?php
    if (isset($_POST['button']))
     {
       $script_execute = 'python /vagrant/mysql_setup.py --su';
       echo '<pre>';
       passthru($script_execute);
       echo '</pre>';
     }
?>


<html>
<head>
<title>Add or View users in Users Table</title>
<?PHP
    $cmd_prefix = 'python /vagrant/mysql_setup.py --fn ';
    $fname = $_POST['firstname'];
    $lname = $_POST['lastname'];
    $age = $_POST['age'];
    $cmd = $cmd_prefix . $fname . ' --ln ' . $lname . ' --age ' . $age;
    exec($cmd);
?>
</head>
"
end

execute "start php" do
	command "nohup php -S 0.0.0.0:8000 -t /var/www/php &"
	not_if 'ps -ef | grep -i php | grep -v grep'
end
