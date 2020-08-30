function [ classcount, binlist, class2use ] = countcells_manual_oneclass_onetimeseries(class, timeseries)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%[ classcount, binlist, class2use ] = countcells_manual_oneclass_onetimeseries('Ceratium', 'mvco')
     conn = getDBConnection_readonly();

    if ~isopen(conn)
        fprintf('ERROR: No connection, are your credentials correct?\n');
        return;
    end
    
    query = fileread('query_classcount_timeseries.sql');
    query = sprintf(query, class, timeseries);
    
    cursor = exec(conn, query);
    cursor = fetch(cursor);
    data = cursor.Data;
    filelist_short = data(:,1);
    count = data(:,2);
    
   %get the complete list of bins
    query = fileread('queryBinList_onetimeseries.sql');
    query = sprintf(query, timeseries);

    cursor = exec(conn, query);
    cursor = fetch(cursor);
    binlist = cursor.Data;
    classcount = zeros(length(binlist),1);
    [~,ia,ib] = intersect(binlist, filelist_short);
    classcount(ia) = cell2mat(count(ib));
      
    %matdate = IFCB_file2date(filelist);
    class2use = class;
    %[matdate, ii] = sort(matdate);
    %filelist = filelist(ii);
    %classcount = classcount(ii);
    %ml_analyzed = ml_analyzed(ii);
        
    %filename = ['\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\summary_webMC\count_manual_current_' class];
    %save(filename, 'classcount', 'matdate', 'filelist', 'ml_analyzed', 'class2use');
    
   %fprintf('Query complete, results are available in %s\n', filename);
    disp('WARNING: These results to not yet reflect manual_list task completeness information!!')

end

