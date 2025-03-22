#!/bin/bash

# https://docs.ferretdb.io/installation/ferretdb/deb/

sudo snap install docker

# Run postgresql with documentdb as storage extension
docker run -d --name postgres \
  --platform linux/amd64 \
  --restart on-failure \
  -e POSTGRES_USER=username \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=postgres \
  -v pgdata:/var/lib/postgresql/data \
  ghcr.io/ferretdb/postgres-documentdb:17-0.102.0-ferretdb-2.0.0

# Run ferretdb
docker run -d --name ferretdb \
  --restart on-failure \
  --link postgres \
  -p 27017:27017 \
  -e FERRETDB_POSTGRESQL_URL=postgres://username:password@postgres:5432/postgres \
  ghcr.io/ferretdb/ferretdb:2.0.0

