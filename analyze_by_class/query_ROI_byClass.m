function [binlist, roinum] =  query_ROI_byClass(class, timeseries)
%[binlist, roinum] =  query_ROI_byClass('Balanion', 'http://ifcb-data.whoi.edu/IFCB014_PiscesNov2014');
    conn = getDBConnection_readonly();

    if ~isopen(conn)
        fprintf('ERROR: No connection, are your credentials correct?\n');
        return;
    end

    query = fileread('timeseries_roi_list_one_class.sql');
    query = sprintf(query, class, timeseries);
    cursor = exec(conn, query);
    cursor = fetch(cursor);

    class_data = cursor.Data;

    binlist = class_data(:,1);
    roinum = cell2mat(class_data(:,2));
       
end