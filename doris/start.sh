#!/bin/bash

${DORIS_FULL_NAME}/be/bin/start_be.sh --daemon
${DORIS_FULL_NAME}/fe/bin/start_fe.sh --daemon

echo "Sleep 30 sec"
sleep 30s

mysql -P 9030 -h 127.0.0.1 -u root -e "ALTER SYSTEM ADD BACKEND \"127.0.0.1:9050\";"

echo "Sleep 10 sec"
sleep 10s
