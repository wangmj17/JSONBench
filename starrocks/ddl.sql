CREATE TABLE bluesky (
    `id` BIGINT AUTO_INCREMENT,
    `data` JSON NOT NULL COMMENT "Primary JSON object, optimized for field access using FlatJSON"
);