#!/usr/bin/env bash

export REPO_HOME=`echo $( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd) | sed s#/home#/hosthome#g`

eval $(docker-machine env node-1)

# Create proxy network
docker network create --driver overlay proxy

# Create notebooks network
docker network create --driver overlay notebooks

# Start proxy
docker stack deploy -c ../stack/proxy.yml proxy

# Start guacamole
docker stack deploy -c ../stack/guacamole.yml guacamole

# Start registry
docker stack deploy -c ../stack/registry.yml registry


# Open browser
xdg-open http://$(docker-machine ip node-1)/guacamole/

