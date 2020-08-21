function [ ] = biovolume_size_summary_manual_webMC( datasetName, feapath)
%function [ ] = biovolume_size_summary_manual_webMC( datasetName, feapath)
%
%For example:
%biovolume_size_summary_manual_webMC( 'NESLTER_transect', 'https://ifcb-data.whoi.edu/NESLTER_transect', '\\sosiknas1\IFCB_products\NESLTER_transect\features\featuresXXXX_v2\', '\\sosiknas1\IFCB_products\NESLTER_transect\')
%biovolume_size_summary_manual_webMC( 'SPIROPA', '\\sosiknas1\IFCB_products\SPIROPA\features\')
% Heidi M. Sosik, Woods Hole Oceanographic Institution, August 2018
%
%Example inputs:
%   timeseries_name = 'NESLTER_transect'; %USER time series name on IFCB Dashboard
%   dashboard_url = 'https://ifcb-data.whoi.edu/NESLTER_transect'; %USER url on IFCB Dashboard
%   feapath = '\\sosiknas1\IFCB_products\NESLTER_transect\features\featuresXXXX_v2\'; %USER where are your feature files
%   resultpath = '\\sosiknas1\IFCB_products\NESLTER_transect\'; USER where to save results
%
% summarizes class results for a series of manual annotation results (as queried from the Manual Annotate database)
% summary file will be located in subdir \summary\ at the top level of the location of the result path

disp('Note: This function only runs on oneeyedjack.')

resultpath = ['\\sosiknas1\IFCB_products\' datasetName '\summary\'];
if ~exist(resultpath)
    mkdir(resultpath)
end
url_metadata = ['https://ifcb-data.whoi.edu/api/export_metadata/' datasetName];

%get total class2use
disp('checking for full class list...')
[ ~, ~, classes ] = countcells_manual_onetimeseries(datasetName);
classes = [classes {'unclassified'}];

disp('checking all samples...')
[ filelist, summary ] = biovolume_size_manual_onetimeseries(datasetName, feapath, classes);
disp('getting metadata...')
metaT = webread(url_metadata, weboptions('Timeout', 60));

disp('saving results...')
[~,a,b] = intersect(filelist, metaT.pid);
meta_data(a,:) = metaT(b,:);
ml_analyzed = meta_data.ml_analyzed;
iso8601format = 'yyyy-mm-dd hh:MM:ss+00:00';
matdate = datenum(meta_data.sample_time, iso8601format);

%classes = fields(summary.count);

if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;

datestr = date; datestr = regexprep(datestr,'-','');
%save([resultpath 'summary\count_biovol_size_manual_' datestr], 'matdate', 'ml_analyzed', 'classcount', 'biovol', 'filelist', 'eqdiam', 'perim', 'roiID')
save([resultpath '\count_biovol_size_manual_' datestr], 'matdate', 'ml_analyzed', 'filelist', 'summary', 'classes', 'meta_data', '-v7.3')

disp('Summary count_biovolume_size file stored here:')
disp([resultpath 'count_biovol_size_manual_' datestr])


