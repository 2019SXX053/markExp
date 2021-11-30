#!/bin/bash

pip install -r requirements.txt

# export FLASK_APP=expapp
# flask run
uwsgi --http 0.0.0.0:5000 --module expapp:app