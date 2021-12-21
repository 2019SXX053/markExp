#!/bin/bash

sudo apt install -y mysql-client

IMAGE="markexp-mariadb"
CONTAINER="markexp-mariadb"

MY_MARIADB_USER="markexp"
MY_MARIADB_PASSWORD="laksdjfienilakdjlkajdsfaljeilie"
MY_MARIADB_ROOT_PASSWORD="ldkajiejdkakjhtvcy6882h2ny"
MY_HOST="127.0.0.1"
MY_PORT="3306"

MY_DB_NAME="markexp"
MY_DB_TABLE_NAME="conversation"


# docker build -t ${IMAGE} .

docker container stop ${CONTAINER}
docker container rm ${CONTAINER}

# docker run --name ${CONTAINER} -p 3306:3306 -d ${IMAGE}

docker run \
   --detach \
   --name ${CONTAINER} \
   --env MARIADB_USER=${MY_MARIADB_USER} \
   --env MARIADB_PASSWORD=${MY_MARIADB_PASSWORD} \
   --env MARIADB_ROOT_PASSWORD=${MY_MARIADB_ROOT_PASSWORD} \
   --network velcom-network \
   -p 3306:3306  \
   mariadb:latest

# docker exec -ti ${CONTAINER} /bin/bash


# MY_MARIADB_USER="markexp"
# MY_MARIADB_PASSWORD="laksdjfienilakdjlkajdsfaljeilie"
# MY_MARIADB_ROOT_PASSWORD="ldkajiejdkakjhtvcy6882h2ny"
# MY_HOST="127.0.0.1"
# MY_PORT="3306"

sleep 7

echo "mysql -u root -h ${MY_HOST} -P ${MY_PORT} -p${MY_MARIADB_ROOT_PASSWORD} -e \"show databases;\""

mysql -u root -h ${MY_HOST} -P ${MY_PORT} -p${MY_MARIADB_ROOT_PASSWORD} -e "
create database ${MY_DB_NAME};
use ${MY_DB_NAME};

CREATE TABLE IF NOT EXISTS ${MY_DB_TABLE_NAME}(
   msg_id INT UNSIGNED AUTO_INCREMENT,
   msg VARCHAR(100) NOT NULL,
   PRIMARY KEY (msg_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO ${MY_DB_TABLE_NAME} (msg) VALUES ('请开始你的表演');
GRANT ALL PRIVILEGES ON ${MY_DB_NAME}.* TO '${MY_MARIADB_USER}'@'%' IDENTIFIED BY '${MY_MARIADB_PASSWORD}';
select * from ${MY_DB_TABLE_NAME};
show databases;
"



