close all
clear all
load ('D:\work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_manual_29Jul2013_day.mat')
load Tall_day2006_2013.mat

temp = datevec(matdate_bin);
yearday = (matdate_bin-datenum(temp(:,1),0,0));
 

dv= datevec(matdate_bin);
yearday = matdate_bin - datenum(dv(:,1),1,0);
[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin(ind14), (classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14)) );

figure
plot(yd, y_mat, '.')
legend(num2str(yearlist'))
title('Guinardia')

[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin(ind14), (((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59)))./...
((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59))+(classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14))))*100 );

figure
plot(yd, y_mat, '.')
legend(num2str(yearlist'))
title('% infected chains')


figure
 set(gcf, 'position', [0 72 750 899])
subplot(4,1,1)
hold on
plot(matdate_bin(ind59), (classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59)), 'r.-')
plot(matdate_bin(ind14), (classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14)), '.-')
plot(matdate_bin(ind14), (((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59)))./...
    ((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59))+(classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14))))*100, 'g-')
xlim([732835, 733210])
datetick('x', 'mm/dd', 'keepticks', 'keeplimits')
ylim([0 130])

title('2006-2007')

subplot(4,1,2)
hold on
plot(matdate_bin(ind59), (classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59)), 'r.-')
plot(matdate_bin(ind14), (classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14)), '.-')
plot(matdate_bin(ind14), (((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59)))./...
    ((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59))+(classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14))))*100, 'g-')
xlim([733210, 733576])
datetick('x', 'mm/dd', 'keepticks', 'keeplimits')
ylim([0 130])
title('2007-2008')

subplot(4,1,3)
hold on
plot(matdate_bin(ind59), (classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59)), 'r.-')
plot(matdate_bin(ind14), (classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14)), '.-')
plot(matdate_bin(ind14), (((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59)))./...
    ((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59))+(classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14))))*100, 'g-')
xlim([733576, 733941])
datetick('x', 'mm/dd')
ylim([0 130])
title('2008-2009')

subplot(4,1,4)
hold on
plot(matdate_bin(ind59), (classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59)), 'r.-')
plot(matdate_bin(ind14), (classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14)), '.-')
plot(matdate_bin(ind14), (((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59)))./...
    ((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59))+(classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14))))*100, 'g-')
xlim([733941, 734306])
datetick('x', 'mm/dd', 'keepticks', 'keeplimits')
ylim([0 130])
title('2009-2010')

figure
 set(gcf, 'position', [750 290 750 680])
subplot(3,1,1)
hold on
plot(matdate_bin(ind59), (classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59)), 'r.-')
plot(matdate_bin(ind14), (classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14)), '.-')
plot(matdate_bin(ind14), (((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59)))./...
    ((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59))+(classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14))))*100, 'g-')
xlim([734306, 734671])
datetick('x', 'mm/dd', 'keepticks', 'keeplimits')
ylim([0 130])
title('2010-2011')

subplot(3,1,2)
hold on
plot(matdate_bin(ind59), (classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59)), 'r.-')
plot(matdate_bin(ind14), (classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14)), '.-')
plot(matdate_bin(ind14), (((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59)))./...
    ((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59))+(classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14))))*100, 'g-')
xlim([734671, 735037])
datetick('x', 'mm/dd', 'keepticks', 'keeplimits')
ylim([0 130])
title('2011-2012')

subplot(3,1,3)
hold on
plot(matdate_bin(ind59), (classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59)), 'r.-')
plot(matdate_bin(ind14), (classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14)), '.-')
plot(matdate_bin(ind14), (((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59)))./...
    ((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59))+(classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14))))*100, 'g-')
xlim([735037, 735402])
datetick('x', 'mm/dd', 'keepticks', 'keeplimits')
ylim([0 130])
title('2012-2013')

figure
 set(gcf, 'position', [0 70 1700 899])
hold on
plot(matdate_bin(ind59), (classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59)),'LineWidth',1, 'r.-')
plot(matdate_bin(ind14), (classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14)), 'LineWidth' ,1, '.-')
plot(matdate_bin(ind14), (((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59)))./...
    ((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59))+(classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14))))*100, 'g-')
xlabel('Time (years)','FontSize',14);
ylabel('Number of images','FontSize',14);
datetick keeplimits

%figure
hold on
%plot(matdate_bin(ind59), (classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59)), 'r.-')
%plot(matdate_bin(ind14), (classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14)), '.-')
%plot(matdate_bin(ind14), (((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59)))./...
 %   ((classcount_bin(ind14,59)./ml_analyzed_mat_bin(ind14,59))+(classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14))))*100, 'g.-')
%plot(matdate_bin(ind16), (classcount_bin(ind16,16)./ml_analyzed_mat_bin(ind16,16)), 'c.-')
%plot(matdate_bin(ind18), (classcount_bin(ind18,18)./ml_analyzed_mat_bin(ind18,18)), 'm.-')
%plot(matdate_bin(ind47), (classcount_bin(ind47,47)./ml_analyzed_mat_bin(ind47,47)), 'k.-')
%plot(matdate_bin(ind19), (classcount_bin(ind19,19)./ml_analyzed_mat_bin(ind19,19)), 'y.-')
datetick keeplimits
