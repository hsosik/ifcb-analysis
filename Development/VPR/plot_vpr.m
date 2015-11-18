
%close all;
clear all;

load('\\sosiknas1\Lab_data\VPR\NBP1201\manual\summary\count_manual_30Oct2015');
load('\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_30Oct2015_six_classes\classpath_div\summary\summary_allTB');
%load('\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_24Sep2015_combineAllPheao24Sep2015\classpath_div\summary\summary_allTB');
decimal = filelistTB(:,17:18);
decimal = str2num(decimal);
ind = find(decimal ==1);



for i = 1:(length(class2useTB)-1);
    class2plot = class2useTB(i);
    if strmatch(class2plot, 'blurry_marSnow', 'exact')
        continue
    elseif strmatch(class2plot, 'phae2all', 'exact')
        continue
    elseif strmatch(class2plot, 'phaeIndivAll', 'exact')
        continue
    elseif strmatch(class2plot, 'phaeMany', 'exact')
        continue
    elseif strmatch(class2plot, 'phaeAll', 'exact')
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
        %phaeMany_manual = (classcount(:,5)) %+ classcount(:,13));
   phae2all_manual = (classcount(:,5));
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
        figure
class2plot = 'phae2all';
ind_auto = strmatch(class2plot, class2useTB, 'exact');
        %phaeMany_manual = (classcount(:,5)) %+ classcount(:,13));
   phae2all_manual = (classcount(:,6) + classcount(:,12));
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
