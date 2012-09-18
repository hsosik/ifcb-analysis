classcountTBall = [];
classcountTB_above_adhocthreshall = [];
classcountTB_above_optthreshall = [];
ml_analyzedTBall = [];
mdateTBall = [];
filelistTBall = [];

for yr = 2006:2012,
    temp = load(['summary_allTB' num2str(yr)]);
    classcountTBall = [ classcountTBall; temp.classcountTB];
    classcountTB_above_adhocthreshall = [ classcountTB_above_adhocthreshall; temp.classcountTB_above_adhocthresh];
    classcountTB_above_optthreshall = [ classcountTB_above_optthreshall; temp.classcountTB_above_optthresh];
    ml_analyzedTBall = [ ml_analyzedTBall; temp.ml_analyzedTB];
    mdateTBall = [ mdateTBall; temp.mdateTB];
    filelistTBall = [ filelistTBall; temp.filelistTB];
    class2useTB = temp.class2useTB;
    clear temp
end;

return


load \\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_biovol_manual_13Sep2012_day
figure, set(gcf, 'paperposition', [.25 2.5 8 2.5], 'units', 'inches')
set(gcf, 'position', [5 4 8 2.5])

ind = 13;
[xmat, ymat ] = timeseries2ydmat(mdateTBall, classcountTB_above_adhocthreshall(:,ind)./ml_analyzedTBall);
hold on, plot(xmat(:), ymat(:), 'linewidth', 1.5)
plot(matdate_bin, classcount_bin(:,10)./ml_analyzed_mat_bin(:,10), 'r.')
%text(datenum(2007,1,1), 10, ['\it' class2useTB(ind)])
datetick, set(gca, 'xgrid', 'on', 'box', 'on')
ylim([0 12])
legend('automated', 'manual')
ylabel('Cells mL^{-1}')

img = imread('http://ifcb-data.whoi.edu/mvco/IFCB5_2011_017_134444_01637.png');
t = size(img,1)/1000*1.0; s = size(img,2)/1000*1.0;
i3 = axes('position', [-.05 .65 s t]);
imshow(img)
title('\itDitylum brightwellii')

print Ditylum_timeseries -depsc
print Ditylum_timeseries -dpng
