#!/bin/bash
NAME=$1

if [ -z $NAME ]; then
  echo "Missing parameter: service name"
  exit 1
fi

docker service create \
  --name ${NAME} \
  --replicas 3 \
  --mount type=bind,source=${PWD}/frontend/${NAME}/,destination=/usr/share/nginx/html/ \
  --network demo-network \
  --endpoint-mode vip \
  nginx:alpine
