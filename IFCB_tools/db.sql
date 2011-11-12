-- Table: bins

-- DROP TABLE bins;

CREATE TABLE bins
(
  lid text,
  sample_time timestamp with time zone
)
WITH (
  OIDS=FALSE
);
ALTER TABLE bins
  OWNER TO jfutrelle;

-- Index: ix_bins_lid

-- DROP INDEX ix_bins_lid;

CREATE INDEX ix_bins_lid
  ON bins
  USING hash
  (lid COLLATE pg_catalog."default" );

-- Index: ix_bins_sample_time

-- DROP INDEX ix_bins_sample_time;

CREATE INDEX ix_bins_sample_time
  ON bins
  USING btree
  (sample_time );
