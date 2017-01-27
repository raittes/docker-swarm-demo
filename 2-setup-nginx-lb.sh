#!/bin/bash
NAME=nginx-lb

docker service create \
  --name ${NAME} \
  --replicas 1 \
  --mount type=bind,source=${PWD}/nginx-conf/demo-vhost.conf,destination=/etc/nginx/conf.d/default.conf \
  --network demo-network \
  --endpoint-mode vip \
  -p 80 \
  nginx:alpine
