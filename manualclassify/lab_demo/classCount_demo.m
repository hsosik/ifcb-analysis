close all
resultpath = '\\queenrose\g_work_ifcb1\Demo_28Apr2012\ManualClassify\';

filelist = dir([resultpath '*.mat']);
filelist = {filelist.name};
matdate = IFCB_file2date(filelist);
load([resultpath filelist{1}])
class2use = class2use_manual;
ml = NaN(1,length(filelist));
classcount = NaN(length(class2use), length(filelist));
[class2use_plot, ind] = setdiff(class2use, {'other_small', 'other_large'});
for ii = 1:length(filelist),
    fname = filelist{ii};
    load([resultpath fname])
    ml(ii) = ml_analyzed;
    for classnum = 1:length(class2use),
        classcount(classnum,ii) = size(find(classlist(:,2) == classnum),1); %manual only
    end;
    figure(ii)
    classcount_plot = classcount(ind,:);
    [classcount_sort,sind] = sort(classcount_plot(:,ii), 'descend');
    sind = sind(classcount_sort > 0);
    bar(classcount(sind,ii)./ml(ii),.5);
    %set(gca, 'xtick', 1:length(sind), 'xticklabel', class2use_plot(sind))
    set(gca, 'xtick',  1:length(sind), 'xticklabel', [])
    axpos = get(gca, 'position'); axpos([2,4]) = axpos([2,4]).*[3 .7]; set(gca, 'position', axpos)
    xl = xlim; text_offset = xl(2)*.02;
    th = text(1:length(sind), -text_offset.*ones(size(sind)), class2use_plot(sind), 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45);
    ylabel('Counts per mL')
    if fname(1) == 'D',
        title(['Salt Pond ' datestr(matdate(ii))])
    else
        title(['MVCO ' datestr(matdate(ii))])
    end  
end;
clear ii ml_analyzed classnum list_titles classlist class2use_auto class2use_sub class2use_manual resultpath


