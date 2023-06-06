with tag_roi_list as 
(
select wt.bin || '_' || lpad(cast(wt.roi as text), 5, '0') as binroi, tl.name, tl.id
from classify_nonnegated_tags wt, classify_taglabel tl
where
wt.tag_id = tl.id
and cast(wt.timeseries_id as uuid)=(select id from classify_timeseries where url like '%%%s/')
order by bin, roi
),
class_roi_list as 
(
select wc.bin || '_' || lpad(cast(wc.roi as text), 5, '0') as binroi, cl.name, cl.international_id
from classify_winning_class2 wc, classify_classlabel cl
where
wc.classification_id = cl.id
and cast(wc.timeseries_id as uuid)=(select id from classify_timeseries where url like '%%%s/')
order by bin, roi
)
select tag_roi_list.binroi, tag_roi_list.name, tag_roi_list.id, class_roi_list.name, class_roi_list.international_id  
from tag_roi_list left join class_roi_list
on
tag_roi_list.binroi = class_roi_list.binroi
order by tag_roi_list.binroi
