#!/bin/bash

IMAGE="markexp-midware"
CONTAINER="markexp-midware"

DB_CONTAINER="markexp-mariadb"

docker build -t ${IMAGE} .

docker container stop ${CONTAINER}
docker container rm ${CONTAINER}

docker run \
    -t \
    --name ${CONTAINER} \
    -p 5000:5000 \
    -d \
    --network velcom-network \
    --env MY_HOST=${DB_CONTAINER} \
    ${IMAGE}


# docker exec -ti ${CONTAINER} /bin/bash

docker logs ${CONTAINER}


