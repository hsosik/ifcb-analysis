function [ binlist, summary ] = biovolume_size_manual_onetimeseries( timeseries, feapath_base )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%[ classcount, binlist, class2use ] = countcells_manual_onetimeseries('mvco')
conn = getDBConnection_readonly();

if ~isopen(conn)
    fprintf('ERROR: No connection, are your credentials correct?\n');
    return;
end

%get the complete list of bins
query = fileread('queryBinList_onetimeseries.sql');
query = sprintf(query, timeseries);
cursor = exec(conn, query);
cursor = fetch(cursor);
binlist = cursor.Data;


for filecount = 1:length(binlist)
    filename = binlist{filecount};
    disp(filename)
    if filename(1) =='I'
        feapath = regexprep(feapath_base, 'XXXX', filename(7:10));
    else
        feapath = regexprep(feapath_base, 'XXXX', filename(2:5));
    end
    %get the annotations from SQL query
    [ data ] = bin_classifications( filename );
    %get the features
    target = get_bin_features([feapath filename '_fea_v2.csv'], {'Biovolume' 'EquivDiameter' 'Perimeter'});
    %match up the annotations and the features
    [~,ia, ib] = intersect(target.pid, data(:,1));
    
    data_match(:,1) = target.pid;
    data_match(:,2) = {'unclassified'}; %initialize as unclassified
    data_match(:,3) = {NaN}; %initialize WoRMS aphiaID
    data_match(ia,:) = data(ib,:);
    
    class_here = unique(data_match(:,2));
    class_here_fields = regexprep(class_here,' ', '_');
    class_here_fields = regexprep(class_here_fields,'-', '__');
    for classnum = 1:length(class_here)
        cind = strmatch(class_here(classnum), data_match(:,2));
        %temp.roiID = 
        summary.roiID.(class_here_fields{classnum}){filecount} = [char(data_match(cind,1))];% {char(targets.pid(cind))};
        summary.biovol.(class_here_fields{classnum}){filecount} = target.Biovolume(cind);
        summary.eqdiam.(class_here_fields{classnum}){filecount} = target.EquivDiameter(cind);
        summary.perim.(class_here_fields{classnum}){filecount} = target.Perimeter(cind);
        summary.count.(class_here_fields{classnum}){filecount} = length(cind);
    end;
    clear data_match
end
%fill out all entries to match number of files
class_here = fields(summary.count);
f = fields(summary);
for classnum = 1:length(class_here)
    for ii = 1:length(f)
        if length(summary.(f{ii}).(class_here{classnum})) < length(binlist)
            summary.(f{ii}).(class_here{classnum})(end+1:length(binlist)) = {[]};
        end
    end
end

%fprintf('Query complete, results are available in %s\n', filename);
disp('WARNING: These results to not yet reflect manual_list task completeness information!!')

end

