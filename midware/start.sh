#!/bin/bash

pip install -r requirements.txt

# export FLASK_APP=expapp
# flask run

# TODO: 为了调试Python到Mariadb数据库连接，而暂时注释此行
uwsgi --http 0.0.0.0:5000 --module expapp:app

# python expapp.py