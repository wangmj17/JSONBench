#!/bin/bash


# install docker
sudo snap install docker

sudo sudo apt-get install gnupg curl
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg --dearmor --yes -o /usr/share/keyrings/mongodb-server-8.0.gpg
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org


# Run postgresql with documentdb as storage extension
docker run -d --name postgres \
  --platform linux/amd64 \
  --restart on-failure \
  -e POSTGRES_USER=username \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=postgres \
  -v pgdata:/var/lib/postgresql/data \
  ghcr.io/ferretdb/postgres-documentdb:17-0.102.0-ferretdb-2.0.0 \
  -c enable_indexscan=on -c enable_indexonlyscan=on

# Run ferretdb
docker run -d --name ferretdb \
  --restart on-failure \
  --link postgres \
  -p 27017:27017 \
  -e FERRETDB_POSTGRESQL_URL=postgres://username:password@postgres:5432/postgres \
  -e FERRETDB_AUTH=false \
  ghcr.io/ferretdb/ferretdb:2.0.0

