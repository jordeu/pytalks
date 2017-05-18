#!/usr/bin/env bash

for i in 1 2 3; do
    docker-machine rm node-$i
done
