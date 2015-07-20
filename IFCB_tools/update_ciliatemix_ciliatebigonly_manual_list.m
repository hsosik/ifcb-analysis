%case for removing "manual" ciliate_mix for 'big_ciliate' annotate mode,
%when those "annotations" came from cases of moving default results from
%original subdivide column 4 (convert manual to NaN if both auto and manual
%are ciliate_mix, indicating not an actual click by the user; keep any that
%differ between auto and manual)

resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';

filelist = get_filelist_manual([resultpath 'manual_list'],6,[2006:2015], 'only'); %manual_list, column to use, year to find

config = load('class2use_MVCOmanual5', 'class2use'); %USER load YOUR class2use list from a file; format class2use = {'classstr1', 'classstr2', ...};
iifix = strmatch('Ciliate_mix', config.class2use);

for filecount = 1:length(filelist),
    disp(filelist(filecount).name)
    %load([resultpath filelist(filecount).name], 'classlist');
    load(['\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass_backup_6.8.15\' filelist(filecount).name], 'classlist');
    ii = find(classlist(:,2) == iifix & classlist(:,3) == iifix);
    classlist(ii,2) = NaN;
    save([resultpath filelist(filecount).name], 'classlist', '-append');
end;
