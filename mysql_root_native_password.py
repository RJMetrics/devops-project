import pexpect

child = pexpect.spawn('mysql -u root --skip-password mysql')
child.expect('mysql>')
child.sendline('update user set plugin="mysql_native_password" where user="root";')
child.expect('mysql>')
child.sendline('flush privileges;')
child.expect('mysql>')
child.sendline('exit;')
