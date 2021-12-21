#!/bin/bash

IMAGE="markexp-midware"
CONTAINER="markexp-midware"

docker build -t ${IMAGE} .

docker container stop ${CONTAINER}
docker container rm ${CONTAINER}

docker run -t --name ${CONTAINER} -p 5000:5000 -d ${IMAGE}
docker exec -ti ${CONTAINER} /bin/bash


