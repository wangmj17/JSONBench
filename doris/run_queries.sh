#!/bin/bash

# Check if the required arguments are provided
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <DB_NAME>"
    exit 1
fi

# Arguments
DB_NAME="$1"

TRIES=3

mysql -P 9030 -h 127.0.0.1 -u root $DB_NAME -e "set global parallel_pipeline_task_num=32;"
mysql -P 9030 -h 127.0.0.1 -u root $DB_NAME -e "set global enable_parallel_scan=false;"

cat queries.sql | while read -r query; do

    # Clear the Linux file system cache
    echo "Clearing file system cache..."
    sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
    echo "File system cache cleared."

    # Print the query
    echo "Running query: $query"

    # Execute the query multiple times
    for i in $(seq 1 $TRIES); do
        RESP=$(mysql -vvv -h127.1 -P9030 -uroot "$DB_NAME" -e "$query" | perl -nle 'if (/\((?:(\d+) min )?(\d+\.\d+) sec\)/) { $t = ($1 || 0) * 60 + $2; print $t }' ||:)
        echo "Response time: ${RESP} s"
    done;
done;
