CREATE TABLE bluesky (
    `id` BIGINT AUTO_INCREMENT,
    -- Main JSON column (comes after key columns)
    `data` JSON NULL COMMENT "Main JSON object",
    -- Key columns (must come first in the schema and in the same order as DUPLICATE KEY)
    `kind` VARCHAR(255) AS get_json_string(data, '$.kind'),
    `operation` VARCHAR(255) AS get_json_string(data, '$.commit.operation'),
    `collection` VARCHAR(255) AS get_json_string(data, '$.commit.collection'),
    `did` VARCHAR(255) AS get_json_string(data, '$.did'),
    `time_us` BIGINT AS get_json_int(data, '$.time_us')
) ENGINE=OLAP
ORDER BY(`kind`, `operation`, `collection`, `did`, `time_us`);
