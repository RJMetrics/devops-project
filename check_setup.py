import argparse
import requests
import socket

from mysql_setup import connect_to_sql_db, close_sql_db_connection

OKGREEN = '\033[92m'
FAIL = '\033[91m'
RESET = '\033[0m'

def check_open_connections(host, port):
    """
    checks connectivity using socket module 
    Parameters:
    host (string): hostname
    port (int): port number

    Exception: 
    socket.error: could not connect to host and port
    socket.timeout: timeout connecting to host and port
    """
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        socket_timeout = 10
        sock.settimeout(socket_timeout)
        sock.connect((host, port))
        print('host: {} port: {} status: {} OK {}'.format(host, port, OKGREEN, RESET))
        sock.close()
    except socket.error:
        print('host: {} port: {} status: {} FAIL {}'.format(host, port, FAIL, RESET))
    except socket.timeout:
        print('host: {} port: {} status: {} TIMEOUT {}'.format(host, port, FAIL, RESET))


def check_url(httpurl):
    """
    checks for url status code
    Parameters:
    httpurl (string): http url to test connectivity

    Exception:
    requests.exceptions.ConnectionError: connectivity error to the defined URL
    Exception: generic exception 
    """
    status_code=None
    try:
        response = requests.head(httpurl)
        status_code = response.status_code
    except requests.exceptions.ConnectionError:
        print('URL: {} status: {} FAIL {}'.format(httpurl, FAIL, RESET))
    except Exception as e:
        print('Excetion raised: {} {} {}'.format(FAIL, e, RESET))
        print('URL: {} status: {} FAIL {}'.format(httpurl, FAIL, RESET))

    if status_code == 200:
        print('URL: {} status: {} OK {}'.format(httpurl, OKGREEN, RESET))


def check_testdb_connectivity_to_db(env):
    """
    checks db connectivity using testdb user and password

    Parameters:
    env (string): host or vm 
    """
    port = 3001 if env == 'host' else 3306
    testdb_connect = connect_to_sql_db(user='testdb', password='testdb', port=port)
    if testdb_connect:
        print('user: testdb database: mysql status: {} OK {}'.format(OKGREEN, RESET))
        close_sql_db_connection(testdb_connect)
    else:
        print('user: testdb database: mysql status: {} FAIL {}'.format(FAIL, RESET))



def main():
    parser = argparse.ArgumentParser("check connectivity and urls from host and vm")
    parser.add_argument("--env", required=True, choices={"host", "vm"}, help="checks connectivity at host or vm level")
    args = parser.parse_args()
    host_vm_ports = {'php': {'host': 8001, 'vm': 80},
                     'mysql': {'host': 3001, 'vm': 3306}}

    env_value = args.env
    php_port = host_vm_ports['php'][env_value]
    mysql_port = host_vm_ports['mysql'][env_value]
    check_open_connections('localhost', php_port)
    check_open_connections('localhost', mysql_port)
    check_url('http://localhost:{}'.format(php_port))
    check_url('http://localhost:{}/phpinfo.php'.format(php_port))
    check_url('http://localhost:{}/update_get_db_users.php'.format(php_port))
    check_testdb_connectivity_to_db(args.env)


if __name__ == "__main__":
    main()
