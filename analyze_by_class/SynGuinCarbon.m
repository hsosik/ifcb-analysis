%load c:\work\mvco\carbon\IFCB_carbon_manual_Jan2014.mat %from summary_size_classes.m
load \\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\IFCB_carbon_manual_27Jan2016 %IFCB_carbon_manual_12Jun2015 %from summary_size_classes.m
load c:\work\mvco\carbon\carbon_summary_fcb.mat

c = strmatch('Guinardia_delicatula', classes, 'exact');
ii = find(~isnan(C_day_mat(:,c)));
figure
plot(mdate(:), synCperml(:), 'linewidth', 2)
hold on
plot(Cmdate_day(ii), C_day_mat(ii,c), 'r', 'linewidth', 2)
set(gca, 'xlim', datenum(['1-0-2003'; '7-0-2016']), 'xtick', [datenum(2003:2016,1,1)], 'fontsize', 12, 'ylim', [0 60])
datetick('x', 'keepticks')
ylabel('Carbon ( \mug mL^{-1})', 'fontsize', 14)
lh = legend('\itSynechococcus\rm', '\itGuinardia delicatula\rm', 'location', 'northwest'); set(lh, 'fontsize', 14, 'box', 'off')
set(gcf, 'position', [ 520   560   700   230])
set(gca, 'xgrid', 'on')

img = imread('http://ifcb-data.whoi.edu/mvco/IFCB5_2012_030_223923_03472.png'); %Guinardia
t = size(img,1)/1000*1.0; s = size(img,2)/1000*1.0;
i3 = axes('position', [.05 .55 s t]);
imshow(img)
set(i3, 'visible', 'on', 'box', 'on', 'ycolor', 'r', 'xcolor', 'r', 'ytick', [], 'xtick', [], 'linewidth', 2)

%edits for grazer proposal 2014
%lh = legend('\itSynechococcus\rm', '\itGuinardia delicatula\rm', 'location', 'north'); set(lh, 'fontsize', 14, 'box', 'off')
%xlim([datenum(2006,1,1), datenum(2014,1,1)])
%set(i3, 'position', [-0.03 .65 s t])


figure
plot(mdate(:), synCperml(:), 'linewidth', 2)
hold on
%plot(Cmdate_day(ii), C_day_mat(ii,c), 'r', 'linewidth', 2)
set(gca, 'xlim', datenum(['1-0-2003'; '7-0-2016']), 'xtick', [datenum(2003:2016,1,1)], 'fontsize', 12, 'ylim', [0 60])
datetick('x', 'keepticks')
ylabel('Carbon ( \mug mL^{-1})', 'fontsize', 14)
lh = legend('\itSynechococcus\rm', 'location', 'northwest'); set(lh, 'fontsize', 14, 'box', 'off')
set(gcf, 'position', [ 520   560   700   230])
set(gca, 'xgrid', 'on')

