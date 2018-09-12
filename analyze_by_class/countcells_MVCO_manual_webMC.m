resultpath = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\';
outpath = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\summary_webMC\';
load \\sosiknas1\IFCB_products\MVCO\ml_analyzed\ml_analyzed_all %load the milliliters analyzed for all sample files

[ classcount_sql, filelist_sql, class2use ] = countcells_manual_onetimeseries('mvco');

%%
%get metadata according to filelist in manual_list
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
load \\sosiknas1\IFCB_products\MVCO\ml_analyzed\ml_analyzed_all %load the milliliters analyzed for all sample files

[ classes_byfile, classes_bymode ] = get_annotated_classesMVCO_sql( class2use, manual_list);

filelist = classes_byfile.filelist;

[~,ia, ib] = intersect(filelist, filelist_all);
if length(ia) ~= length(filelist),
    disp('missing some ml_analyzed values; need to make updated ml_analyzed all.mat?')
    pause
end;
temp = NaN(size(filelist));
temp(ia) = ml_analyzed(ib);
ml_analyzed = temp;
%clean up from ml_analyzed_all
clear filelist_all looktime matdate minproctime runtime ia ib

%mark NaNs in ml_analyzed for classify not complete in manual annotation
analyzed_flag = classes_byfile.classes_checked; analyzed_flag(analyzed_flag == 0) = NaN;
ml_analyzed_mat = repmat(ml_analyzed,1,length(class2use)).*analyzed_flag;
%%
%now make sure the count info from the sql query has the same filelist order
[~,ia, ib] = intersect(filelist, filelist_sql);
classcount = nan(length(filelist), length(class2use));
classcount(ia,:) = classcount_sql(ib,:); 

%calculate date
matdate = IFCB_file2date(filelist);

if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
save([outpath 'count_manual_' datestr], 'matdate', 'ml_analyzed_mat', 'classcount', 'filelist', 'class2use')
save([outpath 'count_manual_current'], 'matdate', 'ml_analyzed_mat', 'classcount', 'filelist', 'class2use')

%create and save daily binned results
[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classcount, ml_analyzed_mat);
save([outpath 'count_manual_' datestr '_day'], 'matdate_bin', 'classcount_bin', 'ml_analyzed_mat_bin', 'class2use')
save([outpath 'count_manual_current_day'], 'matdate_bin', 'classcount_bin', 'ml_analyzed_mat_bin', 'class2use')
