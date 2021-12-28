from flask import Flask
from flask import render_template
from flask import request

import pymysql
import os

CONTAINER = "markexp-mariadb"

MARIADB_USER = "velcom"
MARIADB_PASSWORD = "velcom_alksdjflkakjei"
MY_MARIADB_ROOT_PASSWORD = "velcom_rootlkdjalienfklae"
MY_HOST = "127.0.0.1"
MY_PORT = "3306"

MY_DB_NAME = "velcom"
MY_DB_TABLE_NAME = "conversation"

# 从环境变量当中读取 `MY_HOST`, 如果存在这个环境变量，那么就覆盖本地的 `MY_HOST`
my_host_hame = os.getenv('MY_HOST')
if my_host_hame:
    MY_HOST = my_host_hame
    print('############################################')
    print(f'get MY_HOST from env: {MY_HOST}')
    print('############################################')


message_list = []


first_time = True


def create_table():
    print('############################################')
    print(f'creating table {MY_DB_TABLE_NAME}')
    print('############################################')

    global first_time

    if first_time:
        db = pymysql.connect(host=MY_HOST,
                             user='root',
                             password=MY_MARIADB_ROOT_PASSWORD,
                             database=MY_DB_NAME)
        cursor = db.cursor()
        cursor.execute('use velcom')
        cursor.execute(
            'CREATE TABLE IF NOT EXISTS conversation(msg_id INT UNSIGNED AUTO_INCREMENT,msg VARCHAR(100) NOT NULL,PRIMARY KEY (msg_id))ENGINE=InnoDB DEFAULT CHARSET=utf8;')
        cursor.execute('INSERT INTO conversation (msg) VALUES ("请开始你的表演")')
        db.commit()
        db.close()

        first_time = False

        print('############################################')
        print(f'table {MY_DB_TABLE_NAME} created')
        print('############################################')
    else:
        pass


def process_input(msg):
    # message_list.append(msg)

    db = pymysql.connect(host=MY_HOST,
                         user='root',
                         password=MY_MARIADB_ROOT_PASSWORD,
                         database=MY_DB_NAME)

    cursor = db.cursor()
    cursor.execute(f'INSERT INTO {MY_DB_TABLE_NAME} (msg) VALUES ("{msg}")')
    db.commit()
    db.close()

    pass


def get_output():

    db = pymysql.connect(host=MY_HOST,
                         user='root',
                         password=MY_MARIADB_ROOT_PASSWORD,
                         database=MY_DB_NAME)

    cursor = db.cursor()
    cursor.execute(f'select * from {MY_DB_TABLE_NAME}')
    results = cursor.fetchall()

    message_list.clear()

    for one_message in results:
        msg = one_message[1]
        message_list.append(msg)

    return message_list


app = Flask(__name__)


@app.route("/")
def index():
    conversation = get_output()

    return render_template('conversation.jinja2', conversation=conversation)


@app.route("/input", methods=['GET', 'PoSt'])
def input():

    msg = request.form['message']

    process_input(msg)
    conversation = get_output()

    return render_template('conversation.jinja2', conversation=conversation)


# init
create_table()


if __name__ == '__main__':
    app.run()
