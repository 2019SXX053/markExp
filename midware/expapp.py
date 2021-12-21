from flask import Flask
from flask import render_template
from flask import request

message_list = []


def process_input(msg):
    message_list.append(msg)
    pass


def get_output():
    return message_list


app = Flask(__name__)


@app.route("/")
def index():
    return render_template('conversation.jinja2')


@app.route("/input", methods=['GET', 'PoSt'])
def input():

    msg = request.form['message']

    process_input(msg)
    conversation = get_output()

    return render_template('conversation.jinja2', conversation=conversation)


if __name__ == '__main__':
    app.run()

# MY_MARIADB_USER="markexp"
# MY_MARIADB_PASSWORD="laksdjfienilakdjlkajdsfaljeilie"
# MY_MARIADB_ROOT_PASSWORD="ldkajiejdkakjhtvcy6882h2ny"
# MY_HOST="127.0.0.1"
# MY_PORT="3306"

# MY_DATABASE="markexp"
