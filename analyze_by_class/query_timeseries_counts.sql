select timeseries_url, bin, classification_id, count,
(select name from classify_classlabel cl where cl.id=classification_id) as name
from classify_counts_by_bin
where
timeseries_url like '%%%s/'
-- remove the following line to get all bins for the timeseries
and bin='D20170530T201609_IFCB010'
order by bin, classification_id