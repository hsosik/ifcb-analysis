select wc.bin || '_' || lpad(cast(wc.roi as text), 5, '0'), cl.name, cl.international_id
from classify_winning_class wc, classify_classlabel cl
where
wc.classification_id = cl.id
and wc.bin = '%s'
order by roi