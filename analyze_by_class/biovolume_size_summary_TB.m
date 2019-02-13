function [ ] = biovolume_size_summary_TB( classpath, feapath, dashboard_url ) %, v, feapath, resultpath)
%function [ ] = biovolume_size_summary_manual_webMC( timeseries_name, dashboard_url, feapath, resultpath)
%
%For example:
% biovolume_size_summary_TB( '\\sosiknas1\IFCB_products\SPIROPA\class\class2018_v1\', '\\sosiknas1\IFCB_products\SPIROPA\features\2018\', 'https://ifcb-data.whoi.edu/SPIROPA/' ) %, v, feapath, resultpath)
% Heidi M. Sosik, Woods Hole Oceanographic Institution, November 2018
%
%Example inputs:
%   classpath  = '\\sosiknas1\IFCB_products\SPIROPA\class\class2018_v1\'; %USER where are your class files
%   feapath = '\\sosiknas1\IFCB_products\SPIROPA\features\2018\'; %USER where are your feature files
%   dashboard_url = 'https://ifcb-data.whoi.edu/SPIROPA/'; %USER url on IFCB Dashboard
%
% summarizes results for a series of classification results 
% summary file will be located in subdir \summary\ at the top level of the location of the result path

micron_factor = 1/3.4; %USER PUT YOUR OWN microns per pixel conversion
disp('getting list of files...')
classfilelist = dir([classpath '*.mat']);
classfilelist = {classfilelist.name}';
filelist = regexprep(classfilelist, '_class_v1.mat', '');
feafilelist = regexprep(classfilelist, '_class_v1.mat', '_fea_v2.csv');

%calculate date
matdate = IFCB_file2date(filelist);

%make sure input paths end with filesep
if ~isequal(classpath(end), filesep)
    classpath = [classpath filesep];
end
if ~isequal(dashboard_url(end), '/')
    dashboard_url = [in_dir '/'];
end

disp('getting ml_analyzed...')
ml_analyzed = IFCB_volume_analyzed(strcat(dashboard_url, char(filelist), '.hdr'));

load([classpath classfilelist{1}], 'class2useTB');

diam_edges = [(0:300) inf]';
classbiovoldist = zeros(length(filelist), length(class2useTB), length(diam_edges)-1);
classcountdist = classbiovoldist;
for fcount = 1:length(filelist)
    disp(filelist{fcount})
    c = load([classpath classfilelist{fcount}]);
    f = get_bin_features([feapath feafilelist{fcount}], {'Biovolume', 'EquivDiameter'});
    for classcount = 1:length(class2useTB)
        ind = strmatch( class2useTB{classcount}, c.TBclass_above_threshold);
        if ~isempty(ind)
            diamlist = f.EquivDiameter(ind).*micron_factor;
            bvlist = f.Biovolume(ind).*(micron_factor^3);
            classcountdist(fcount,classcount,:) = histcounts(diamlist,diam_edges);
            diam_bin_ind = discretize(diamlist,diam_edges);
            unqbin = unique(diam_bin_ind);
            for bincount = 1:length(unqbin) %compute the biovol sums for diam bins with entries
                classbiovoldist(fcount,classcount,unqbin(bincount)) = sum(bvlist(diam_bin_ind==unqbin(bincount)));
            end
        end
    end
end

if ~exist([classpath 'summary\'], 'dir')
    mkdir([classpath 'summary\'])
end;

datestr = date; datestr = regexprep(datestr,'-','');
%save([resultpath 'summary\count_biovol_size_manual_' datestr], 'matdate', 'ml_analyzed', 'classcount', 'biovol', 'filelist', 'eqdiam', 'perim', 'roiID')
save([classpath 'summary\count_biovol_size_TB_' datestr], 'matdate', 'ml_analyzed', 'filelist', 'classbiovoldist', 'classcountdist', 'class2useTB', 'diam_edges')

disp('Summary count_biovolume_size file stored here:')
disp([classpath 'summary\count_biovol_size_TB_' datestr])


