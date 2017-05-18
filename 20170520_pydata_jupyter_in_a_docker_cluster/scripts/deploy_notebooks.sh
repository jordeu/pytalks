#!/usr/bin/env bash

export REPO_HOME=`echo $( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd) | sed s#/home#/hosthome#g`

eval $(docker-machine env node-1)

# Start registry
docker stack deploy -c ../stack/notebooks.yml nb
