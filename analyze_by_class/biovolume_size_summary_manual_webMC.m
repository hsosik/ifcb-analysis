function [ ] = biovolume_size_summary_manual_webMC( timeseries_name, dashboard_url, feapath, resultpath)
%function [ ] = countcells_manual_webMC( timeseries_name, dashboard_url )
%For example:
%countcells_manual_user_training('C:\work\IFCB\user_training_test_data\manual\' , 'C:\work\IFCB\user_training_test_data\data\')
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2012 / August 2015
%
%Example inputs:
%   resultpath = 'C:\work\IFCB\user_training_test_data\class\classxxxx_v1\'; %USER manual file location
%   dashboard_url = 'C:\work\IFCB\user_training_test_data\data\'; %USER where to access data (hdr files) (url for web services, full path for local)
%
% configured for IFCB007 and higher (except IFCB008)
% summarizes class results for a series of manual annotation files (as saved by startMC)
% summary file will be located in subdir \summary\ at the top level of the
% location of the manual result files

%resultpath = 'C:\work\IFCB\user_training_test_data\manual_temp\'; %USER
%in_dir = 'C:\work\IFCB\user_training_test_data\data\'; %USER

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

ml_analyzed = IFCB_volume_analyzed([repmat([dashboard_url '/'],length(filelist),1) char(filelist) repmat('.hdr', length(filelist),1)]);
classes = fields(summary.count);

if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;

datestr = date; datestr = regexprep(datestr,'-','');
%save([resultpath 'summary\count_biovol_size_manual_' datestr], 'matdate', 'ml_analyzed', 'classcount', 'biovol', 'filelist', 'eqdiam', 'perim', 'roiID')
save([resultpath 'summary\count_biovol_size_manual_' datestr], 'matdate', 'ml_analyzed', 'filelist', 'summary', 'classes')

disp('Summary count_biovolume_size file stored here:')
disp([resultpath 'summary\count_biovol_size_manual_' datestr])

return

figure %example
classnum = 3;
plot(matdate, classcount(:,classnum)./ml_analyzed, '.-')
datetick('x')
ylabel([class2use{classnum} ' (mL^{-1})'])

