
%close all;
clear all;

load('\\sosiknas1\Lab_data\VPR\NBP1201\manual\summary\count_manual_13Sep2017');
%load('\\sosiknas1\Lab_data\VPR\NBP1201\manual\summary\count_manual_12Nov2015');
load('\\sosiknas1\Lab_data\VPR\NBP1201\class_RossSea_Trees_test26May2017\classpath_div\summary\summary_allTB');
%load('\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_30Oct2015_six_classes\classpath_div\summary\summary_allTB');
%load('\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_24Sep2015_combineAllPheao24Sep2015\classpath_div\summary\summary_allTB');
%adhocing here to accomodate a different scenario where not all of the
%files in the class directory have results. The only problem is you have to
%list each hour to include and list it in the concatenation as well. 
temp = cellstr(filelistTB);
hours = [{'d013h04', 'd013h05', 'd013h06', 'd013h07', 'd013h08', 'd013h09',...
    'd013h10', 'd013h11', 'd013h12', 'd013h13','d014h00', 'd014h01'}]; 
for i = 1:length(hours);
    list= strmatch(hours(i), temp);
    if ~exist('included_files')
        included_files = list;
    else
        included_files = [included_files;list];
    end
end

decimal = filelistTB(:,17:18);
decimal = str2num(decimal);
ind = find(decimal(included_files) ==1);
main_ind = included_files(ind); ind= main_ind;

% for i = 1:length(class2useTB);
%    x = classcount;
%    classcount_optimized = classcountTB_above_optthresh(:,1);
%     Rsq(ii) = lin_fit{ii}.Rsquared.ordinary;
%     
% 
% 

for i = 6%1:(length(class2useTB)-1);
    class2plot = class2useTB(i);
    if strmatch(class2plot, 'blurry,marSnow', 'exact')
        continue
    elseif strmatch(class2plot, 'phaeIndiv2,phaeMany23', 'exact')
        continue
    elseif strmatch(class2plot, 'phaeIndivAll', 'exact')
        continue
    elseif strmatch(class2plot, 'phaeMany', 'exact')
        continue
    elseif strmatch(class2plot, 'phaeAll', 'exact')
        continue
    elseif strmatch(class2plot, 'squashed', 'exact')
        continue
    else
ind_man = strmatch(class2plot, class2use, 'exact');
ind_auto = strmatch(class2plot, class2useTB, 'exact');
    end
figure
plot(ind, classcount(:,ind_man), 'r.', 'markerSize', 16)
hold on
plot(classcountTB(:,ind_auto), '.')
plot(ind, classcountTB(ind,ind_auto), 'mo', 'markerSize', 7)
plot(classcountTB_above_optthresh(:,ind_auto), 'g.')
plot(ind, classcountTB_above_optthresh(ind ,ind_auto), 'mo', 'markerSize', 7)
plot(classcountTB_above_adhocthresh(:,ind_auto), 'k.')
        plot(ind, classcountTB_above_adhocthresh(ind ,ind_auto), 'mo', 'markerSize', 7)
legend('manual', 'auto',  'auto', 'opt thre', 'opt thre', 'adhoc thre');
ylim([0 2500]);
title(class2plot);
clear ind_man ind_auto class2plot
end

% figure
% class2plot = 'phaeIndivAll';
% ind_auto = strmatch(class2plot, class2useTB, 'exact');
%         phaeIndivAll_manual = (classcount(:,4) + classcount(:,12));
%    
%         plot(ind, phaeIndivAll_manual, 'r.', 'markerSize', 16)
%         hold on
%         plot(classcountTB(:,ind_auto), '.')
%         plot(ind, classcountTB(ind,ind_auto), 'mo', 'markerSize', 7)
%         plot(classcountTB_above_optthresh(:,ind_auto), 'g.')
%         plot(ind, classcountTB_above_optthresh(ind ,ind_auto), 'mo', 'markerSize', 7)
%         plot(classcountTB_above_adhocthresh(:,ind_auto), 'k.')
%         plot(ind, classcountTB_above_adhocthresh(ind ,ind_auto), 'mo', 'markerSize', 7)
%         legend('manual', 'auto',  'auto', 'auto thre', 'auto thre');
%         title(class2plot);
%         clear ind_man ind_auto class2plot phaeMany_manual
        
figure
class2plot = 'phaeMany';
ind_auto = strmatch(class2plot, class2useTB, 'exact');
        phaeMany_manual = (classcount(:,5)+ classcount(:,13));
   %phaeMany_manual = (classcount(:,5));
        plot(ind, phaeMany_manual, 'r.', 'markerSize', 16)
        hold on
        plot(classcountTB(:,ind_auto), '.')
        plot(ind, classcountTB(ind,ind_auto), 'mo', 'markerSize', 7)
        plot(classcountTB_above_optthresh(:,ind_auto), 'g.')
        plot(ind, classcountTB_above_optthresh(ind ,ind_auto), 'mo', 'markerSize', 7)
        plot(classcountTB_above_adhocthresh(:,ind_auto), 'k.')
        plot(ind, classcountTB_above_adhocthresh(ind ,ind_auto), 'mo', 'markerSize', 7)
        legend('manual', 'auto',  'auto', 'auto thre', 'auto thre');
        title(class2plot);
        clear ind_man ind_auto class2plot phaeMany_manual
ylim([0 2500]);
        
figure
class2plot = 'phae2all';
ind_auto = strmatch(class2plot, class2useTB, 'exact');
        %phaeMany_manual = (classcount(:,5)) %+ classcount(:,13));
   phae2all_manual = (classcount(:,6) + classcount(:,12)+classcount(:,14));
        plot(ind, phae2all_manual, 'r.', 'markerSize', 16)
        hold on
        plot(classcountTB(:,ind_auto), '.')
        plot(ind, classcountTB(ind,ind_auto), 'mo', 'markerSize', 7)
        plot(classcountTB_above_optthresh(:,ind_auto), 'g.')
        plot(ind, classcountTB_above_optthresh(ind ,ind_auto), 'mo', 'markerSize', 7)
        plot(classcountTB_above_adhocthresh(:,ind_auto), 'k.')
        plot(ind, classcountTB_above_adhocthresh(ind ,ind_auto), 'mo', 'markerSize', 7)
        legend('manual', 'auto',  'auto', 'auto thre', 'auto thre');
        title(class2plot);
        clear ind_man ind_auto class2plot phaeMany_manual
        ylim([0 4000]);
        
        figure
class2plot = 'squashed';
ind_auto = strmatch(class2plot, class2useTB, 'exact');
        %phaeMany_manual = (classcount(:,5)) %+ classcount(:,13));
   phae2all_manual = (classcount(:,7) + classcount(:,15));
        plot(ind, phae2all_manual, 'r.', 'markerSize', 16)
        hold on
        plot(classcountTB(:,ind_auto), '.')
        plot(ind, classcountTB(ind,ind_auto), 'mo', 'markerSize', 7)
        plot(classcountTB_above_optthresh(:,ind_auto), 'g.')
        plot(ind, classcountTB_above_optthresh(ind ,ind_auto), 'mo', 'markerSize', 7)
        plot(classcountTB_above_adhocthresh(:,ind_auto), 'k.')
        plot(ind, classcountTB_above_adhocthresh(ind ,ind_auto), 'mo', 'markerSize', 7)
        legend('manual', 'auto',  'auto', 'auto thre', 'auto thre');
        title(class2plot);
        clear ind_man ind_auto class2plot phaeMany_manual
        ylim([0 2500]);
% figure
% class2plot = 'phaeAll';
% ind_auto = strmatch(class2plot, class2useTB, 'exact');
%         phaeMany_manual = (classcount(:,4) + classcount(:,5) + classcount(:,6) + classcount(:,12) + classcount(:,13));
%    
%         plot(ind, phaeMany_manual, 'r.', 'markerSize', 16)
%         hold on
%         plot(classcountTB(:,ind_auto), '.')
%         plot(ind, classcountTB(ind,ind_auto), 'mo', 'markerSize', 7)
%         plot(classcountTB_above_optthresh(:,ind_auto), 'g.')
%         plot(ind, classcountTB_above_optthresh(ind ,ind_auto), 'mo', 'markerSize', 7)
%         plot(classcountTB_above_adhocthresh(:,ind_auto), 'k.')
%         plot(ind, classcountTB_above_adhocthresh(ind ,ind_auto), 'mo', 'markerSize', 7)
%         legend('manual', 'auto',  'auto', 'auto thre', 'auto thre');
%         title(class2plot);
%         clear ind_man ind_auto class2plot phaeMany_manual
