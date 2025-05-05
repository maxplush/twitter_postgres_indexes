/*
 * Calculates the languages that use the hashtag #coronavirus
 */

SELECT
    data->>'lang' AS language,
    COUNT(DISTINCT data->>'id') AS tweet_count
FROM tweets_jsonb
WHERE
    data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
    OR data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
GROUP BY language
ORDER BY tweet_count DESC, language;

