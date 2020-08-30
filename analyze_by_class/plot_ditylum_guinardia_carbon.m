load \\sosiknas1\IFCB_products\MVCO\Manual_fromClass\summary\IFCB_carbon_manual_08Feb2018 %IFCB_carbon_manual_12Jun2015 %from summary_size_classes.m

c = strmatch('Guinardia_delicatula', classes, 'exact');
ii = find(~isnan(C_day_mat(:,c)));

figure, set(gcf, 'paperposition', [.25 2.5 11.5 2.45], 'units', 'inches')
set(gcf, 'position', [5 4 11.5 2.45])
%set(gcf, 'position', [5 4 11.5 2])

plot(Cmdate_day(ii), C_day_mat(ii,c), 'b', 'linewidth', 2)
set(gca, 'xlim', datenum(['6-1-2006'; '1-1-2018']), 'xtick', [datenum(2007:2018,1,1)], 'fontsize', 14, 'ylim', [0 60])
datetick('x', 'keepticks', 'keeplimits')
ylabel('Carbon ( \mug mL^{-1})', 'fontsize', 14)
%set(gca, 'xlim', datenum([2006,6,1; 2018,1,1]), 'fontsize', 14, 'xgrid', 'on', 'box', 'on')


img = imread('http://ifcb-data.whoi.edu/mvco/IFCB5_2012_030_223923_03472.png'); %Guinardia
t = size(img,1)/1000*1.0; s = size(img,2)/1000*1.0;
%i3 = axes('position', [-.09 .68 s t]);
i3 = axes('position', [.06 .65 s t]);
imshow(img)
title('\itGuinardia delicatula', 'fontsize', 12)

c = strmatch('Ditylum', classes, 'exact');
ii = find(~isnan(C_day_mat(:,c)));

figure, set(gcf, 'paperposition', [.25 2.5 11.5 2.45], 'units', 'inches')
set(gcf, 'position', [5 4 11.5 2.45])
%set(gcf, 'position', [5 4 11.5 2])

plot(Cmdate_day(ii), C_day_mat(ii,c), 'b', 'linewidth', 2)
set(gca, 'xlim', datenum(['6-1-2006'; '1-1-2018']), 'xtick', [datenum(2007:2018,1,1)], 'fontsize', 14, 'ylim', [0 10])
datetick('x', 'keepticks', 'keeplimits')
ylabel('Carbon ( \mug mL^{-1})', 'fontsize', 14)
%set(gca, 'xlim', datenum([2006,6,1; 2018,1,1]), 'fontsize', 14, 'xgrid', 'on', 'box', 'on')

img = imread('http://ifcb-data.whoi.edu/mvco/IFCB5_2011_017_134444_01637.png'); %Ditylum
t = size(img,1)/1000*1.0; s = size(img,2)/1000*1.0;
i3 = axes('position', [-.13 .68 s t]);
imshow(img)
title('\itDitylum brightwellii', 'fontsize', 12)


