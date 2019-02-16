import logging
from mysql import connector
from mysql.connector import Error

logging.basicConfig(filename='/tmp/base_mysql_setup.log', level=logging.INFO)


def connect_to_sql_db(user='root', database='mysql', host='localhost'):
    try:
        sql_connect = connector.connect(user=user, database=database, host=host)
        logging.info('sql connection established to database: {}'.format(database))
    except Error:
        logging.critical('could not connect to sql DB')
        logging.exception('exception raised is as displayed below')

    return sql_connect


def get_sql_cursor(sql_connect):
    if sql_connect:
        logging.info('establishing cursor connect')

        return sql_connect.cursor()

    else:
        logging.critical('sql connect failed to establish connection')


def create_user_and_grant_priv(sql_cursor, user='testdb', passord='testdb', database='mysql'):
    if sql_cursor:
        logging.info('creating user {} in database {}'.format(user, database))
        create_user_statement = "CREATE USER 'testdb' IDENTIFIED BY 'testdb'"
        grant_priv_statement = "GRANT ALL PRIVILEGES ON mysql.* TO 'testdb' \
                                IDENTIFIED BY 'testdb'"
        try:
            sql_cursor.execute(create_user_statement)
            sql_cursor.execute(grant_priv_statement)
        except Error:
            logging.exception('could not complete create user and grant priv function')


def create_table(sql_cursor, table_name='Users'):
    
    sql_cursor.execute('show tables')
    all_tables = sql_cursor.fetchall()
    check_users_table = [table for table in all_tables if table[0] == table_name]
    logging.info(all_tables)
    if check_users_table:
        logging.error('table name {} already exists'.format(table_name))
    else:
        create_table_statement = "CREATE TABLE {} ( FirstName varchar(255), LastName varchar(255), \
                                  Age int, CreatedAtTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP \
                                  ON UPDATE CURRENT_TIMESTAMP)".format(table_name)
        sql_cursor.execute(create_table_statement)


def close_sql_db_connection(sql_connect):
    if sql_connect:
        sql_connect.close()
        logging.info('sql connection closed to database')


def main():
    sql_connect = connect_to_sql_db()
    sql_cursor = get_sql_cursor(sql_connect)
    create_user_and_grant_priv(sql_cursor)
    create_table(sql_cursor)
    close_sql_db_connection(sql_connect)


if __name__ == "__main__":
    main()

