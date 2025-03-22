#!/bin/bash

docker stop ferretdb
docker rm ferretdb

docker stop postgres
docker rm postgres
docker volume rm pgdata