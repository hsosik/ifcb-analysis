function [ binlist, summary ] = biovolume_size_manual_onetimeseries( timeseries, feapath_base, classes)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%[ classcount, binlist, class2use ] = countcells_manual_onetimeseries('mvco')
conn = getDBConnection_readonly();

micron_factor = 1/2.77; %microns per pixel
summary.micron_factor = micron_factor;
summary.classes = classes;

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

lbstr = num2str(length(binlist));
summary.count = NaN( length(binlist), length(classes) );
summary.count_gt10 = summary.count;
for filecount = 1:length(binlist)
    filename = binlist{filecount};
    disp([filename ': ' num2str(filecount) ' of ' lbstr])
    if filename(1) =='I'
        feapath = regexprep(feapath_base, 'XXXX', filename(7:10));
    else
       % feapath = regexprep(feapath_base, 'XXXX', filename(2:5));
        feapath = [feapath_base filesep filename(1:5) filesep filename(1:9) filesep];
    end
    %get the annotations from SQL query
    [ data ] = bin_classifications( filename );
    %get the features
    target = get_bin_features([feapath filename '_fea_v4.csv'], {'Biovolume' 'EquivDiameter' 'Perimeter' 'summedBiovolume' 'maxFeretDiameter' 'minFeretDiameter'});
    %match up the annotations and the features
    [~,ia, ib] = intersect(target.pid, data(:,1));
    
    data_match(:,1) = target.pid;
    data_match(:,2) = {'unclassified'}; %initialize as unclassified
    data_match(:,3) = {NaN}; %initialize WoRMS aphiaID
    data_match(ia,:) = data(ib,:);
    class_here = unique(data_match(:,2));
    for classnum = 1:length(class_here)
        ccol = strmatch(class_here(classnum), classes, 'exact');
        cind = strmatch(class_here(classnum), data_match(:,2));
        summary.roiID{filecount,ccol} = [(char(data_match(cind,1)))];% {char(targets.pid(cind))};
        summary.biovol{filecount,ccol} = target.summedBiovolume(cind)*micron_factor.^3;
        summary.esd{filecount,ccol} = biovol2esd(summary.biovol{filecount,ccol});
        summary.ecd{filecount,ccol} = target.EquivDiameter(cind)*micron_factor;
        summary.perim{filecount,ccol} = target.Perimeter(cind)*micron_factor;
        summary.maxFd{filecount,ccol} = target.maxFeretDiameter(cind)*micron_factor;
        summary.minFd{filecount,ccol} = target.minFeretDiameter(cind)*micron_factor;
        summary.count(filecount,ccol) = length(cind);
        summary.count_gt10(filecount,ccol) = sum(summary.esd{filecount,ccol}>10);
    end;
    clear data_match
end

%fprintf('Query complete, results are available in %s\n', filename);
disp('WARNING: These results to not yet reflect manual_list task completeness information!!')

end

