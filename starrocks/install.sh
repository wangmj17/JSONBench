#!/bin/bash

sudo snap install docker
sudo apt-get update
sudo apt-get install -y mysql-client
sudo docker run -p 9030:9030 -p 8030:8030 -p 8040:8040 -itd --name quickstart starrocks/allin1-ubuntu
