#!/usr/bin/env bash

for i in 1 2 3; do
    docker-machine start node-$i
done

eval $(docker-machine env node-1)
docker node ls

