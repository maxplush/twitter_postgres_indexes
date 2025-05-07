/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */

SELECT
    hashtag AS tag,
    COUNT(*) AS total_count
FROM (
    SELECT DISTINCT
        data->>'id' AS tweet_id,
        '#' || (
            jsonb_array_elements(
                COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]') ||
                COALESCE(data->'entities'->'hashtags', '[]')
            )->>'text'
        ) AS hashtag
    FROM tweets_jsonb
    WHERE to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')) @@ to_tsquery('english', 'coronavirus')
    AND data->>'lang' = 'en'
) AS distinct_hashtags
GROUP BY hashtag
ORDER BY total_count DESC, hashtag
LIMIT 1000;

