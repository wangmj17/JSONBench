#!/bin/bash

# Check if the required arguments are provided
if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <DB_NAME> <TABLE_NAME>"
    exit 1
fi

DB_NAME="$1"
TABLE_NAME="$2"

echo "Dropping table: $DB_NAME.$TABLE_NAME"

mysql -P 9030 -h 127.0.0.1 -u root -e "DROP TABLE IF EXISTS $DB_NAME.$TABLE_NAME"
