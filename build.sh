#!/bin/bash
mkdir build
cd build
git clone https://github.com/docker-library/mariadb.git
cd mariadb
sed -i '1s/.*/FROM resin\/rpi-raspbian:jessie/' Dockerfile
DOCKER_TAG='latest'
if [ -n "$TRAVIS_TAG" ]; then DOCKER_TAG=$TRAVIS_TAG; fi
docker build -t theopenbit/rpi-mariadb:$DOCKER_TAG .
docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
docker push theopenbit/rpi-mariadb:$DOCKER_TAG
