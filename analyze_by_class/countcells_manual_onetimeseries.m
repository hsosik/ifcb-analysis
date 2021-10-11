function [ classcount, bins, class2use ] = countcells_manual_onetimeseries( timeseries )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%[ classcount, binlist, class2use ] = countcells_manual_onetimeseries('mvco')
     conn = getDBConnection_readonly();

    if ~isopen(conn)
        fprintf('ERROR: No connection, are your credentials correct?\n');
        return;
    end
    
    query = fileread('query_timeseries_counts.sql');
    query = sprintf(query, timeseries);
    
    cursor = exec(conn, query);
    cursor = fetch(cursor);
    data = cursor.Data;
    bins_all = data(:,2);
    count_all = cell2mat(data(:,4));
    classnum_all = cell2mat(data(:,3));
    
    [classnum, ii] = unique(classnum_all);
    class2use = data(ii,5)';
    bins = unique(bins_all);
    
    count = zeros(length(bins), length(class2use));
    for jj = 1:length(bins)
        kk = strmatch(bins(jj), bins_all);
        [~,a,b] = intersect(classnum, classnum_all(kk));
        count(jj,a) = count_all(kk(b));
    end
    
   %get the complete list of bins
    query = fileread('queryBinList_onetimeseries.sql');
    query = sprintf(query, timeseries);
    cursor = exec(conn, query);
    cursor = fetch(cursor);
    binlist = cursor.Data;
    
    classcount = zeros(length(binlist),length(class2use));
    [~,ia,ib] = intersect(binlist, bins);
    classcount(ia,:) = count(ib,:);
%    bins = bins(ib);  
    bins = binlist;
   
   %fprintf('Query complete, results are available in %s\n', filename);
    disp('WARNING: These results to not yet reflect manual_list task completeness information!!')
keyboard
end

