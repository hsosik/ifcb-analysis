%redmine issue #3091, associated with update from ciliates classes as a
%subdivide (classlist column 4) to ciliates as part of main list (column 2)
%in cases where ciliates were not manually corrected this resulted in
%annotations from the classifier only appearing in the manual column
%This script finds those cases and moves the associated annotations to the
%auto column in classlist and sets manual as NaN
roipath = 'http://ifcb-data.whoi.edu/mvco/';
manualpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';

%col 8 = 'parasites', col 9 = 'chaetoceros', col 10 = 'guinardia' 
%checking in manual_list as of 9/17/14, 'guinardia' should be 'only' since
%a few cases have 'ciliates' & 'big ciliates' also; this misses a few but
%those will be caught by 'parasites' with 'all'
%'parasites' on 'all' is fine and will cover all the 'chaetoceros' cases(it overlaps completely)

%filelist = get_filelist_manual([manualpath 'manual_list'],8,[2006:2014], 'all'); %parasites, all
%filelist = get_filelist_manual([manualpath 'manual_list'],9,[2006:2014],'all'); %chaetoceros, all
filelist = get_filelist_manual([manualpath 'manual_list'],10,[2006:2014],'only'); %guinardia, only

ciliates2move = {'Ciliate_mix' 'Laboea_strobila' 'Mesodinium_sp' 'Tintinnid'};

for ii = 1:length(filelist),
    disp(filelist(ii).name)
    clist = load([manualpath filelist(ii).name], 'classlist', 'class2use_manual');
    [~,classind] = ismember(ciliates2move,clist.class2use_manual);
    ciliate2move_ind = find(ismember(clist.classlist(:,2), classind));
    if ~isempty(ciliate2move_ind)
        %disp(filelist(ii).name)
        %keyboard
        %disp(clist.classlist(ciliate2move_ind,:))
        clist.classlist(ciliate2move_ind,3) = clist.classlist(ciliate2move_ind,2);
        clist.classlist(ciliate2move_ind,2) = NaN;
        %disp(clist.classlist(ciliate2move_ind,:))
        %keyboard
        classlist = clist.classlist;
        save([manualpath filelist(ii).name], 'classlist', '-append')
    end;
end;

