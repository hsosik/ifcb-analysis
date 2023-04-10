function class_roi_table = class_roi_list_one_timeseries(timeseries)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%conn = getDBConnection_readonly();
conn = getDBConnection();
query = fileread('class_by_roi_one_timeseries.sql'); 
query = sprintf(query, timeseries);

cursor = exec(conn, query); 
cursor = fetch(cursor);

class_roi_table = table;
class_roi_table.roi = cursor.Data(:,1);
class_roi_table.classname = cursor.Data(:,2);
class_roi_table.classID = cell2mat(cursor.Data(:,3));

temp = split(timeseries, '/');
temp = temp{end};
p = ['\\sosiknas1\IFCB_products\' temp filesep 'summary' filesep];
if ~exist(p, 'dir')
    mkdir(p)
end
p = [p 'manual_class_roi_table'];
save(p, 'class_roi_table')
disp('Results saved: ')
disp(p)

end

