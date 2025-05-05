/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */

SELECT
    '#' || tag AS hashtag,
    COUNT(*) AS usage_count
FROM (
    SELECT DISTINCT
        data->>'id' AS tweet_id,
        jsonb_array_elements_text(
            COALESCE(
                data->'extended_tweet'->'entities'->'hashtags',
                data->'entities'->'hashtags',
                '[]'::jsonb
            )
        )::jsonb ->> 'text' AS tag
    FROM tweets_jsonb
    WHERE
        data->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
        OR data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
) AS hashtags_data
GROUP BY tag
ORDER BY usage_count DESC, tag
LIMIT 1000;

