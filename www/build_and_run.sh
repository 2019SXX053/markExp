#!/bin/bash

IMAGE="markexp-nginx"
CONTAINER="markexp-nginx"

docker build -t ${IMAGE} .

docker container stop ${CONTAINER}
docker container rm ${CONTAINER}

docker run --name ${CONTAINER} -p 10801:80 -d ${IMAGE}
docker exec -ti ${CONTAINER} /bin/bash


