SELECT bin FROM classify_classification
where cast(timeseries_id as uuid)=(select id from classify_timeseries where url like '%%%s/')
GROUP BY bin ORDER BY bin;