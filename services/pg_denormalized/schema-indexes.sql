SET max_parallel_maintenance_workers TO 80;
SET maintenance_work_mem TO '16 GB';

CREATE INDEX idx_hashtags_entities ON tweets_jsonb
USING GIN((data->'entities'->'hashtags'));

CREATE INDEX idx_hashtags_extended ON tweets_jsonb
USING GIN((data->'extended_tweet'->'entities'->'hashtags'));

CREATE INDEX idx_fts_text_en ON tweets_jsonb
USING GIN(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')));
