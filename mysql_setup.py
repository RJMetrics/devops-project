import argparse
import logging
from mysql import connector
from mysql.connector import Error


def set_log_file():
    """
    Sets log file
    """

    logging.basicConfig(filename='/tmp/base_mysql_setup.log', level=logging.INFO)


def connect_to_sql_db(user='root', password='',database='mysql', host='localhost', port=3306):
    """
    Established connection to mysql DB.
    Parameters:
    user (string): username for database
    password (string): password for database
    database (string): database name
    host (string): hostname or ip address
    port (int): port number of mysql

    Returns:
    sql_connect (object): sql connect object

    Exception:
    Error: Error connecting to SQL DB
    """
    try:
        sql_connect = connector.connect(user=user, password=password, database=database, host=host, port=port)
        logging.info('sql connection established to database: {}'.format(database))
        
        return sql_connect
    except Error:
        logging.critical('could not connect to sql DB')
        logging.exception('exception raised is as displayed below')


def get_sql_cursor(sql_connect):
    """
    Provides sql cursor to execute statements
    Parameters:
    sql_connect (object): sql connect object

    Returns:
    sql_connect.cursor (object): sql cursor object
    """
    if sql_connect:
        logging.info('establishing cursor connect')

        return sql_connect.cursor()

    else:
        logging.critical('sql connect failed to establish connection')


def execute_sql_statement(sql_cursor, statement):
    """
    Executes sql statements
    Parameters:
    sql_cursor (object): sql cursor
    statement (str): sql statement to be executed


    Exception:
    connector.Error: SQL cursor execute error

    Returns:
    output (str): sql command output
    """
    try:
        sql_cursor.execute(statement)
        logging.info('executed statement: {} successfully'.format(statement))
    except Error:
        logging.error('Error executing statement: {}'.format(statement))
        logging.exception('error in command')

    try:
        output = sql_cursor.fetchall()
        return output 
    except Error:
        logging.info('no output to return for statement: {}'.format(statement))


def create_user_and_grant_priv(sql_cursor, user='testdb', password='testdb', database='mysql'):
    """
    Creates user and grant privileges
    Parameters:
    sql_cursor (object): sql cursor
    user (string): username 
    password (string): password
    database (string): database name
    """

    if sql_cursor:
        logging.info('creating user {} in database {}'.format(user, database))
        create_user_statement = "CREATE USER '{}' IDENTIFIED BY '{}'".format(user, password)
        grant_priv_statement = "GRANT ALL PRIVILEGES ON mysql.* TO '{}' IDENTIFIED BY '{}'".format(user, password)
        execute_sql_statement(sql_cursor, create_user_statement)
        execute_sql_statement(sql_cursor, grant_priv_statement)


def create_table(sql_cursor, table_name='Users'):
    """
    Creates table 
    Parameters:
    sql_cursor (object): sql cursor
    table_name (string): table name to create
    """

    if sql_cursor:
        all_tables = execute_sql_statement(sql_cursor, 'show tables')
        check_users_table = [table for table in all_tables if table[0] == table_name]
        if check_users_table:
            logging.error('table name {} already exists'.format(table_name))
        else:
            create_table_statement = "CREATE TABLE {} (id int(11) AUTO_INCREMENT PRIMARY KEY not null, \
                                      FirstName varchar(255), LastName varchar(255), \
                                      Age int, CreatedAtTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP \
                                      ON UPDATE CURRENT_TIMESTAMP)".format(table_name)
            execute_sql_statement(sql_cursor, create_table_statement)


def close_sql_db_connection(sql_connect):
    """
    Closes out any active sql sessions
    Parameters:
    sql_connect (object): sql_connect object
    """
    if sql_connect:
        sql_connect.close()
        logging.info('sql connection closed to database')


def update_db_data(sql_cursor, FirstName=None, LastName=None, Age=None, table_name='Users'):
    """
    Updates DB with the information passed
    Parameters:
    sql_cursor (object): sql cursor
    FirstName (string): firstname 
    LastName (string): lastname
    Age (int): age
    table_name (string): table name
    """
    insert_data_statement = "INSERT INTO {} (FirstName, LastName, Age) VALUES ('{}', '{}', {})".format(table_name, FirstName, LastName, Age)
    execute_sql_statement(sql_cursor, insert_data_statement)


def display_db_data(sql_cursor, table_name='Users'):
    """
    Displays the users in User table
    Parameters:
    sql_cursor (object): sql cursor
    table_name (string): table name
    """
    display_db_data_statement = 'SELECT * from {}'.format(table_name)
    all_users_info = execute_sql_statement(sql_cursor, display_db_data_statement)
    logging.info(all_users_info)
    print('FirstName\tLastName\tAge')
    for user_info in all_users_info:
        if len(user_info) >= 4:
            print('{}\t\t{}\t\t{}'.format(user_info[1], user_info[2], user_info[3]))
    

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--fn', help='provide first name', required=False)
    parser.add_argument('--ln', help='provide last name', required=False)
    parser.add_argument('--age', help='provide age', required=False)
    parser.add_argument('--su', help='displays all users', action='store_true', required=False)
    parser.add_argument('--setup', help='setup database with new tables', action='store_true', required=False)
    args = parser.parse_args()

    set_log_file()

    # Initial Connection
    sql_connect = connect_to_sql_db(password='newpassword')
    sql_cursor = get_sql_cursor(sql_connect)

    # Update DB Table (Users) with FirstName, LastName, Age
    if args.fn and args.ln and args.age:
        update_db_data(sql_cursor, FirstName=args.fn, LastName=args.ln, Age=args.age)
        sql_connect.commit()

    # Display all users in Users table
    elif args.su:
        display_db_data(sql_cursor)
        close_sql_db_connection(sql_connect)

    # Creates table, user and grant privileges
    elif args.setup:
        create_user_and_grant_priv(sql_cursor)
        create_table(sql_cursor)
        sql_connect.commit()

    # Closes the connection
    close_sql_db_connection(sql_connect)


if __name__ == "__main__":
    main()

