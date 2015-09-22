classcountTB = [];
classcountTB_above_adhocthresh = [];
classcountTB_above_optthresh = [];
ml_analyzedTB = [];
mdateTB = [];
filelistTB = [];

for yr = 2006:2013,
    temp = load(['summary_allTB' num2str(yr)]);
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
return


%load \\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_biovol_manual_13Sep2012_day
load C:\work\IFCB\ifcb_data_MVCO_jun06\Manual_fromClass\summary\count_biovol_manual_19Mar2013_day
%figure, set(gcf, 'paperposition', [.25 2.5 8 2.5], 'units', 'inches')
%set(gcf, 'position', [5 4 8 2.5])
figure, set(gcf, 'paperposition', [.25 2.5 11.5 2.45], 'units', 'inches')
set(gcf, 'position', [5 4 11.5 2.45])

%ind = strmatch('Ditylum', class2useTB);
ind = strmatch('Guinardia', class2useTB, 'exact');
%[xmat, ymat ] = timeseries2ydmat(mdateTBall, classcountTB_above_adhocthreshall(:,ind)./ml_analyzedTBall);
[xmat, ymat ] = timeseries2ydmat(mdateTB, classcountTB(:,ind)./ml_analyzedTB);
hold on, 
%ind2 = strmatch('Ditylum', class2use);
plot(matdate_bin, classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2), 'r*')
%ind2 = strmatch('Guinardia', class2use, 'exact');
gind = get_G_delicatula_ind(class2use);
ii = find(~isnan(ml_analyzed_mat_bin(:,gind(1)))); %cases with main Guinardia delicatula annotated
plot(matdate_bin(ii), nansum(classcount_bin(ii,gind)./ml_analyzed_mat_bin(ii,gind),2), 'r*')
plot(xmat(:), ymat(:), 'linewidth', 1.5)
%text(datenum(2007,1,1), 10, ['\it' class2useTB(ind)])
datetick, set(gca, 'xgrid', 'on', 'box', 'on')
%ylim([0 15])
ylim([0 80])
legend('manual', 'automated')
ylabel('Chains mL^{-1}', 'fontsize', 12)
%ylabel('Cells mL^{-1}', 'fontsize', 12)
set(gca, 'fontsize', 12)

%img = imread('http://ifcb-data.whoi.edu/mvco/IFCB5_2011_017_134444_01637.png'); %Ditylum
img = imread('http://ifcb-data.whoi.edu/mvco/IFCB5_2012_030_223923_03472.png'); %Guinardia
t = size(img,1)/1000*1.0; s = size(img,2)/1000*1.0;
i3 = axes('position', [-.05 .65 s t]);
imshow(img)
%title('\itDitylum brightwellii', 'fontsize', 12)
title('\itGuinardia delicatula', 'fontsize', 12)
%print Ditylum_timeseries -depsc
%print Ditylum_timeseries -dpng
