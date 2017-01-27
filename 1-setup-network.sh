#!/bin/bash

docker network create \
  --driver overlay \
  --subnet 10.0.0.0/24 \
  --opt encrypted \
  demo-network
