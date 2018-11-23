function [ ] = biovolume_size_summary_manual_webMC( timeseries_name, dashboard_url, feapath, resultpath)
%function [ ] = biovolume_size_summary_manual_webMC( timeseries_name, dashboard_url, feapath, resultpath)
%
%For example:
%biovolume_size_summary_manual_webMC( 'NESLTER_transect', 'https://ifcb-data.whoi.edu/NESLTER_transect', '\\sosiknas1\IFCB_products\NESLTER_transect\features\featuresXXXX_v2\', '\\sosiknas1\IFCB_products\NESLTER_transect\')
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

[ filelist, summary ] = biovolume_size_manual_onetimeseries(timeseries_name, feapath);

%calculate date
matdate = IFCB_file2date(filelist);

%make sure input paths end with filesep
if ~isequal(resultpath(end), filesep)
    resultpath = [resultpath filesep];
end
%if ~isequal(dashboard_url(end), filesep)
%    dashboard_url = [in_dir filesep];
%end
if strmatch(timeseries_name, 'mvco')
    temp = load('\\sosiknas1\IFCB_products\MVCO\ml_analyzed\ml_analyzed_all'); %load the milliliters analyzed for all sample files
    ml_analyzed = NaN(size(filelist));
    [~,ia,ib] = intersect(filelist, temp.filelist_all);
    if length(ia) ~= length(filelist)
        disp('some ml_analyzed are missing')
    end
    ml_analyzed(ia) = temp.ml_analyzed(ib); 
else
    ml_analyzed = IFCB_volume_analyzed(strcat(repmat([dashboard_url '/'],length(filelist),1), filelist, repmat('.hdr', length(filelist),1)));
end
classes = fields(summary.count);

if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;

datestr = date; datestr = regexprep(datestr,'-','');
%save([resultpath 'summary\count_biovol_size_manual_' datestr], 'matdate', 'ml_analyzed', 'classcount', 'biovol', 'filelist', 'eqdiam', 'perim', 'roiID')
save([resultpath 'summary\count_biovol_size_manual_' datestr], 'matdate', 'ml_analyzed', 'filelist', 'summary', 'classes', '-v7.3')

disp('Summary count_biovolume_size file stored here:')
disp([resultpath 'summary\count_biovol_size_manual_' datestr])


