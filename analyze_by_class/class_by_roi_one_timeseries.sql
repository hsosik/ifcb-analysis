select wc.bin || '_' || lpad(cast(wc.roi as text), 5, '0'), cl.name, cl.international_id
from classify_winning_class2 wc, classify_classlabel cl
where
wc.classification_id = cl.id
and cast(wc.timeseries_id as uuid)=(select id from classify_timeseries where url like '%%%s/')
order by bin, roi
