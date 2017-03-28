#!/bin/bash
mkdir build
cd build
git clone https://github.com/docker-library/mariadb.git
cd mariadb/10.0
sed -i '2s/.*/FROM resin\/rpi-raspbian:jessie/' Dockerfile
sed -i '59 i\RUN rm \/etc\/apt\/preferences.d\/percona' Dockerfile
sed -i '61 i\RUN rm \/etc\/apt\/sources.list.d\/percona.list' Dockerfile
sed -i '71 i\RUN rm \/etc\/apt\/preferences.d\/mariadb' Dockerfile
sed -i '73 i\RUN rm \/etc\/apt\/sources.list.d\/mariadb.list' Dockerfile
sed -i 's/mariadb-server=$MARIADB_VERSION /mariadb-server/g' Dockerfile
DOCKER_TAG='latest'
if [ -n "$TRAVIS_TAG" ]; then DOCKER_TAG=$TRAVIS_TAG; fi
docker build -t theopenbit/rpi-mariadb:$DOCKER_TAG .
docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
docker push theopenbit/rpi-mariadb:$DOCKER_TAG
