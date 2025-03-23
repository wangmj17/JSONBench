#!/bin/bash

docker stop ferretdb
docker rm ferretdb

docker stop postgres
docker rm postgres
docker volume rm pgdata

sudo snap remove --purge docker
sudo apt-get remove -y mongodb-org