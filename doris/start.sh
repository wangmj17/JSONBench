#!/bin/bash
./${DORIS_PACKAGE}/be/bin/start_be.sh --daemon
./${DORIS_PACKAGE}/fe/bin/start_fe.sh --daemon

sleep 30s

mysql -P 9030 -h 127.0.0.1 -u root -e "ALTER SYSTEM ADD BACKEND \"127.0.0.1:9050\";"

sleep 10s
