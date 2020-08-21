classcountTB = [];
classcountTB_above_adhocthresh = [];
classcountTB_above_optthresh = [];
ml_analyzedTB = [];
mdateTB = [];
filelistTB = [];

for yr = 2006:2018
    %temp = load(['\\sosiknas1\IFCB_products\MVCO\class\summary\' 'summary_allTB' num2str(yr)]);
    temp = load(['C:\work\IFCB\class\summary\' 'summary_allTB' num2str(yr)]);
    classcountTB = [ classcountTB; temp.classcountTB];
    classcountTB_above_adhocthresh = [ classcountTB_above_adhocthresh; temp.classcountTB_above_adhocthresh];
    classcountTB_above_optthresh = [ classcountTB_above_optthresh; temp.classcountTB_above_optthresh];
    ml_analyzedTB = [ ml_analyzedTB; temp.ml_analyzedTB];
    mdateTB = [ mdateTB; temp.mdateTB];
    filelistTB = [ filelistTB; temp.filelistTB];
    class2useTB = temp.class2useTB;
    clear temp
end;

clear yr

load \\sosiknas1\IFCB_products\MVCO\Manual_fromClass\summary_webMC\count_manual_current_day
%load C:\work\IFCB\Manual_fromClass\summary_webMC\count_manual_current_day

%%
figure, set(gcf, 'paperposition', [.25 2.5 11.5 2.45], 'units', 'inches')
%set(gcf, 'position', [5 4 11.5 2.45])
set(gcf, 'position', [5 4 11.5 2])
%set(gcf, 'position', [5 4 8.1 1.5]) %ICES 2018

ind = strmatch('Guinardia', class2useTB, 'exact');
%[xmat, ymat ] = timeseries2ydmat(mdateTB, classcountTB_above_adhocthresh(:,ind)./ml_analyzedTB);
[xmat, ymat ] = timeseries2ydmat(mdateTB, classcountTB(:,ind)./ml_analyzedTB);
hold on, 
%gind = get_G_delicatula_ind(class2use);
gind = strmatch('Guinardia delicatula', class2use, 'exact');
ii = find(~isnan(ml_analyzed_mat_bin(:,gind(1)))); %cases with main Guinardia delicatula annotated
plot(matdate_bin(ii), nansum(classcount_bin(ii,gind)./ml_analyzed_mat_bin(ii,gind),2), 'r*', 'markersize', 4)
plot(xmat(:), ymat(:), 'b', 'linewidth', 1)
datetick, %set(gca, 'xgrid', 'on', 'box', 'on')
ylim([0 150])
legend('manual', 'automated')
ylabel('Chains mL^{-1}', 'fontsize', 14)
set(gca, 'xlim', datenum([2006,1,1; 2019,1,1]), 'fontsize', 11, 'xgrid', 'on', 'box', 'on')
%title('\itGuinardia delicatula', 'fontsize', 12)

img = imread('https://ifcb-data.whoi.edu/mvco/IFCB5_2012_030_223923_03472.png'); %Guinardia
%img = ones(100,10000);
t = size(img,1)/1000*1.0; s = size(img,2)/1000*1.0;
%i3 = axes('position', [-.09 .68 s t]);
i3 = axes('position', [.06 .65 s t]);
%i3 = axes('position', [.0 .65 s t]);
imshow(img)
title('\itGuinardia delicatula', 'fontsize', 12)
%%
figure, set(gcf, 'paperposition', [.25 2.5 11.5 2.45], 'units', 'inches')
%set(gcf, 'position', [5 4 11.5 2.45])
set(gcf, 'position', [5 4 11.5 2])
%set(gcf, 'position', [5 4 8.1 1.5]) %ICES 2018

ind = strmatch('Ditylum', class2useTB);
[xmat, ymat ] = timeseries2ydmat(mdateTB, classcountTB_above_adhocthresh(:,ind)./ml_analyzedTB);
%[xmat, ymat ] = timeseries2ydmat(mdateTB, classcountTB(:,ind)./ml_analyzedTB);
hold on, 
%ind2 = strmatch('Ditylum', class2use);
ind2 = strmatch('Ditylum brightwellii', class2use);
plot(matdate_bin, nansum(classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2),2), 'r*', 'markersize', 4)
plot(xmat(:), ymat(:), 'b', 'linewidth', 1)
datetick, %set(gca, 'xgrid', 'on', 'box', 'on')
ylim([0 15])
legend('manual', 'automated')
ylabel('Cells mL^{-1}', 'fontsize', 14)
set(gca, 'xlim', datenum([2006,1,1; 2019,1,1]), 'fontsize', 11, 'xgrid', 'on', 'box', 'on')
%title('\itDitylum brightwellii', 'fontsize', 12)

img = imread('https://ifcb-data.whoi.edu/mvco/IFCB5_2011_017_134444_01637.png'); %Ditylum
%img = ones(1000,10);
t = size(img,1)/1000*1.0; s = size(img,2)/1000*1.0;
i3 = axes('position', [-.13 .68 s t]);
imshow(img)
title('\itDitylum brightwellii', 'fontsize', 12)


figure, set(gcf, 'paperposition', [.25 2.5 11.5 2.45], 'units', 'inches')
%set(gcf, 'position', [5 4 11.5 2.45])
set(gcf, 'position', [5 4 11.5 2])

%ind = strmatch('Corethron', class2useTB, 'exact');
ind = strmatch('Laboea', class2useTB, 'exact');
[xmat, ymat ] = timeseries2ydmat(mdateTB, classcountTB_above_adhocthresh(:,ind)./ml_analyzedTB);
%[xmat, ymat ] = timeseries2ydmat(mdateTB, classcountTB_above_optthresh(:,ind)./ml_analyzedTB);
hold on, 
%ind2 = strmatch('Corethron', class2use);
ind2 = strmatch('Laboea strobila', class2use);
plot(matdate_bin, nansum(classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2),2), 'r*')
plot(xmat(:), ymat(:), 'linewidth', 1.5)
datetick, %set(gca, 'xgrid', 'on', 'box', 'on')
ylim([0 25])
legend('manual', 'automated')
ylabel('Cells mL^{-1}', 'fontsize', 14)
set(gca, 'xlim', datenum([2006,1,1; 2019,1,1]), 'fontsize', 14, 'xgrid', 'on', 'box', 'on')


return

%all_manual = load('c:\work\ifcb\ifcb_data_MVCO_jun06\manual_fromClass\summary\count_biovol_manual_2%Dec2012');
manual = load('c:\work\ifcb\ifcb_data_MVCO_jun06\manual_fromClass\summary\count_biovol_manual_current_day');
%all = load('c:\work\ifcb\ifcb_data_MVCO_jun06\summary\compiledTB');
all = load('C:\work\IFCB\code_svn\classification\compiledTBnew');

ind = strmatch('Ditylum', all.class2useTB);
[xmat, ymat ] = timeseries2ydmat_sum(all.mdateTB, all.classcountTB_above_adhocthresh(:,ind));
[xmat, ymat_ml ] = timeseries2ydmat_sum(all.mdateTB, all.ml_analyzedTB);
figure
set(gcf, 'position', [550 500 1000 275]) 
plot(xmat(:), ymat(:)./ymat_ml(:), 'k', 'linewidth', 2)
hold on
icat_manual = strmatch('Ditylum', manual.class2use);
plot(manual.matdate_bin, manual.classcount_bin(:,icat_manual)./manual.ml_analyzed_mat_bin(:,icat_manual), 'r*', 'markersize', 6, 'markerfacecolor', 'r')
set(gca, 'xlim', datenum([2006,6,1; 2013,1,1]), 'fontsize', 14, 'xgrid', 'on')
ylabel('\itDitylum\rm (mL^{-1})')
lh = legend('Automated', 'Manual');
set(lh, 'box', 'off')
datetick keeplimits
plot(xmat(:), ymat(:)./ymat_ml(:), 'k', 'linewidth', 2)



figure
ind = strmatch('Gyrodinium', class2useTB);
[xmat, ymat ] = timeseries2ydmat(mdateTB, classcountTB_above_adhocthresh(:,ind)./ml_analyzedTB);
%[xmat, ymat ] = timeseries2ydmat(mdateTB, classcountTB(:,ind)./ml_analyzedTB);
hold on, 
ind2 = strmatch('Gyrodinium', class2use);
plot(matdate_bin, classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2), 'r*')
plot(xmat(:), ymat(:), 'linewidth', 1.5)
datetick, %set(gca, 'xgrid', 'on', 'box', 'on')
ylim([0 5])
legend('manual', 'automated')
ylabel('Cells mL^{-1}', 'fontsize', 14)
set(gca, 'xlim', datenum([2001,6,1; 2014,1,1]), 'fontsize', 14, 'xgrid', 'on', 'box', 'on')


%%
%%
figure, set(gcf, 'paperposition', [.25 2.5 11.5 2.45], 'units', 'inches')
set(gcf, 'position', [5 4 11.5 2])

ind = strmatch('Phaeocystis', class2useTB);
[xmat, ymat ] = timeseries2ydmat(mdateTB, classcountTB_above_adhocthresh(:,ind)./ml_analyzedTB);
%[xmat, ymat ] = timeseries2ydmat(mdateTB, classcountTB(:,ind)./ml_analyzedTB);
hold on
ind2 = strmatch('Phaeocystis', class2use);
plot(matdate_bin, nansum(classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2),2), 'r*', 'markersize', 4)
plot(xmat(:), ymat(:), 'b', 'linewidth', 1)
datetick, %set(gca, 'xgrid', 'on', 'box', 'on')
ylim([0 15])
legend('manual', 'automated')
ylabel('Colonies mL^{-1}', 'fontsize', 14)
set(gca, 'xlim', datenum([2006,1,1; 2020,1,1]), 'fontsize', 11, 'xgrid', 'on', 'box', 'on')
title('\itPhaeocystis sp.', 'fontsize', 12)
