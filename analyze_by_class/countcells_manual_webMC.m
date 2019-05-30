outpath = '\\sosiknas1\IFCB_products\NESLTER_transect\summary\';
urlpath = 'https://ifcb-data.whoi.edu/NESLTER_transect/';
%load \\sosiknas1\IFCB_products\MVCO\ml_analyzed\ml_analyzed_all %load the milliliters analyzed for all sample files

[ classcount, filelist, class2use ] = countcells_manual_onetimeseries('NESLTER_transect');

%calculate date
matdate = IFCB_file2date(filelist);
%get volume imaged
ml_analyzed = IFCB_volume_analyzed(strcat(urlpath, filelist, '.hdr'));

datestr = date; datestr = regexprep(datestr,'-','');
save([outpath 'count_manual_' datestr], 'matdate', 'ml_analyzed', 'classcount', 'filelist', 'class2use')
save([outpath 'count_manual_current'], 'matdate', 'ml_analyzed', 'classcount', 'filelist', 'class2use')

