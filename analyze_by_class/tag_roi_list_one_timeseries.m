function tag_roi_table = tag_roi_list_one_timeseries(timeseries)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%conn = getDBConnection_readonly();
conn = getDBConnection();
query = fileread('tag_by_roi_one_timeseries2.sql'); 
query = sprintf(query, timeseries, timeseries);

cursor = exec(conn, query); 
cursor = fetch(cursor);

tag_roi_table = table;
tag_roi_table.roi = cursor.Data(:,1);
tag_roi_table.taglabel = cursor.Data(:,2);
tag_roi_table.tagID = cell2mat(cursor.Data(:,3));
tag_roi_table.classlabel = cursor.Data(:,4);
tag_roi_table.classID = cell2mat(cursor.Data(:,5));

temp = split(timeseries, '/');
temp = temp{end};
p = ['\\sosiknas1\IFCB_products\' temp filesep 'summary' filesep];
if ~exist(p, 'dir')
    mkdir(p)
end
p = [p 'manual_tag_roi_table'];
save(p, 'tag_roi_table')
disp('Results saved: ')
disp(p)

end

