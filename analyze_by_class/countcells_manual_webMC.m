function [] = countcells_manual_webMC(datasetName)
% function [] = countcells_manual_webMC(datasetName)
% For example:
%      countcells_manual_webMC('NESLTER_transect')
% 
% Heidi M. Sosik, Woods Hole Oceanographic Institution, April 2020
% 
disp('Note: This function only runs on oneeyedjack.')

outpath = ['\\sosiknas1\IFCB_products\' datasetName '\summary\'];
if ~exist(outpath)
    mkdir(outpath)
end
url_metadata = ['https://ifcb-data.whoi.edu/api/export_metadata/' datasetName];

[ classcount, filelist, class2use ] = countcells_manual_onetimeseries(datasetName);
metaT = webread(url_metadata, weboptions('TimeOut', 30));
%calculate date
%matdate = IFCB_file2date(filelist);
%get volume imaged
%ml_analyzed = IFCB_volume_analyzed(strcat(urlpath, filelist, '.hdr'));
[~,a,b] = intersect(filelist, metaT.pid);
meta_data(a,:) = metaT(b,:);
ml_analyzed = meta_data.ml_analyzed;
iso8601format = 'yyyy-mm-dd hh:MM:ss+00:00';
matdate = datenum(meta_data.sample_time, iso8601format);

datestr2 = date; datestr2 = regexprep(datestr2,'-','');
save([outpath 'count_manual_' datestr2], 'matdate', 'ml_analyzed', 'classcount', 'filelist', 'class2use', 'meta_data')
save([outpath 'count_manual_current'], 'matdate', 'ml_analyzed', 'classcount', 'filelist', 'class2use', 'meta_data')

disp(['Results saved: '  outpath 'count_manual_' datestr2])
disp(['Results saved: '  outpath 'count_manual_current'])

end
