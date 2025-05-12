CREATE TABLE bluesky (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `data` variant NOT NULL,
    INDEX idx_var (`data`) USING INVERTED
)
DISTRIBUTED BY HASH(id) BUCKETS 32
PROPERTIES (
    "replication_num"="1"
);
