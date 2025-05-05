/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */

SELECT
    '#' || (jsonb_array_elements(
        COALESCE(data->'entities'->'hashtags', '[]') ||
        COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]')
    )->>'text') AS tag,
    COUNT(DISTINCT data->>'id') AS count
FROM tweets_jsonb
WHERE COALESCE(data->'entities'->'hashtags', '[]') ||
      COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]')
      @> '[{"text": "coronavirus"}]'
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;

