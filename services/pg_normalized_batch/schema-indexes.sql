CREATE INDEX idx_tweet_tags_tag_id ON tweet_tags(tag, id_tweets);

CREATE INDEX idx_tweet_tags_id_tweets ON tweet_tags(id_tweets);

CREATE INDEX idx_tweets_id_tweets ON tweets(id_tweets);

CREATE INDEX idx_tweets_fts ON tweets USING GIN (to_tsvector('english', text));
