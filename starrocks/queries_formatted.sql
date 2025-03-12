------------------------------------------------------------------------------------------------------------------------
-- Q1 - Top event types
------------------------------------------------------------------------------------------------------------------------

SELECT cast(data->'commit.collection' AS VARCHAR) AS event,
       count() AS count 
FROM bluesky 
GROUP BY event 
ORDER BY count DESC;

------------------------------------------------------------------------------------------------------------------------
-- Q2 - Top event types together with unique users per event type
------------------------------------------------------------------------------------------------------------------------
SELECT
    cast(data->'commit.collection' AS VARCHAR) AS event,
    count() AS count,
	  count(DISTINCT cast(data->'did' AS VARCHAR)) AS users
FROM bluesky
WHERE (data->'kind' = 'commit')
  AND (data->'commit.operation' = 'create') 
GROUP BY event
ORDER BY count DESC;

------------------------------------------------------------------------------------------------------------------------
-- Q3 - When do people use BlueSky
------------------------------------------------------------------------------------------------------------------------
SELECT
    cast(data->'commit.collection' AS VARCHAR) AS event, 
    hour(from_unixtime(round(divide(cast(data->'time_us' AS BIGINT), 1000000)))) as hour_of_day,
    count() AS count
FROM bluesky
WHERE (data->'kind' = 'commit') 
AND (data->'commit.operation' = 'create') 
AND (array_contains(['app.bsky.feed.post', 'app.bsky.feed.repost', 'app.bsky.feed.like'], cast(data->'commit.collection' AS VARCHAR))) 
GROUP BY event, hour_of_day
ORDER BY hour_of_day, event;

------------------------------------------------------------------------------------------------------------------------
-- Q4 - top 3 post veterans
------------------------------------------------------------------------------------------------------------------------
SELECT
      cast(data->'$.did' as VARCHAR) as user_id, 
      min(from_unixtime(round(divide(cast(data->'time_us' AS BIGINT), 1000000)))) AS first_post_date 
FROM bluesky
WHERE (data->'kind' = 'commit') 
  AND (data->'commit.operation' = 'create') 
  AND (data->'commit.collection' = 'app.bsky.feed.post')
GROUP BY user_id
ORDER BY first_post_ts ASC
LIMIT 3;

------------------------------------------------------------------------------------------------------------------------
-- Q5 - top 3 users with longest activity
------------------------------------------------------------------------------------------------------------------------
SELECT
      cast(data->'$.did' as VARCHAR) as user_id, 
      date_diff('millisecond', 
      min(from_unixtime(round(divide(cast(data->'time_us' AS BIGINT), 1000000)))),
      max(from_unixtime(round(divide(cast(data->'time_us' AS BIGINT), 1000000))))) AS activity_span 
FROM bluesky
WHERE (data->'kind' = 'commit') 
    AND (data->'commit.operation' = 'create') 
    AND (data->'commit.collection' = 'app.bsky.feed.post')
GROUP BY user_id
ORDER BY activity_span DESC
LIMIT 3;
