import pexpect
from pexpect import TIMEOUT

def send_expect(child, pattern):
    """
    Expects and waits for pattern after every command is run
    :param child: pexpect process
    :type: object
    :param pattern: expected pattern 
    :type: str
    :raise TIMEOUT: raises timeout waiting for pattern 
    """
    try:
        child.expect(pattern)
    except TIMEOUT:
        print('timed out waiting for pattern {}'.format(pattern))
        raise

def main():
    child = pexpect.spawn('mysql -u root --skip-password mysql')
    send_expect(child, 'mysql>')
    child.sendline('update user set plugin="mysql_native_password" where user="root";')
    send_expect(child, 'mysql>')
    child.sendline('update user set authentication_string=PASSWORD("newpassword") where User="root";')
    send_expect(child, 'mysql>')
    child.sendline('flush privileges;')
    send_expect(child, 'mysql>')
    child.sendline('quit')


if __name__ == "__main__":
    main()
