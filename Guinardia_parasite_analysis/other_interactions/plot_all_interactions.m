close all
clear all
load ('D:\work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_manual_09Sep2013_day.mat')
load Tall_day2006_2013.mat


ind59 = find(~isnan(ml_analyzed_mat_bin(:,59)));
ind60 = find(~isnan(ml_analyzed_mat_bin(:,60)));
ind62 = find(~isnan(ml_analyzed_mat_bin(:,62)));
ind63 = find(~isnan(ml_analyzed_mat_bin(:,63)));
ind67 = find(~isnan(ml_analyzed_mat_bin(:,67)));

ind56 = find(~isnan(ml_analyzed_mat_bin(:,56)));
ind57 = find(~isnan(ml_analyzed_mat_bin(:,57)));
ind58 = find(~isnan(ml_analyzed_mat_bin(:,58)));
ind61 = find(~isnan(ml_analyzed_mat_bin(:,61)));
ind66 = find(~isnan(ml_analyzed_mat_bin(:,66)));

dv= datevec(matdate_bin);
yearday = matdate_bin - datenum(dv(:,1),1,0);
[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin(ind59), (classcount_bin(ind59,59)+classcount_bin(ind59,60)+classcount_bin(ind59,62)...
    +classcount_bin(ind59,63)+ classcount_bin(ind59,67))./ml_analyzed_mat_bin(ind59,59));


dv= datevec(matdate_bin);
yearday = matdate_bin - datenum(dv(:,1),1,0);
[ mdate_mat, y_mat2, yearlist, yd2 ] = timeseries2ydmat( matdate_bin(ind56), (classcount_bin(ind56,56)+classcount_bin(ind56,57)+classcount_bin(ind56,58)...
    +classcount_bin(ind56,61)+ classcount_bin(ind56,66))./ml_analyzed_mat_bin(ind56,56));



figure
plot(yd, y_mat, '.')

hold on

plot(yd2, y_mat2, '.')
legend(num2str(yearlist'))

figure
plot(matdate_bin(ind57),(classcount_bin(ind57,57)./ml_analyzed_mat_bin(ind57,57)), '.');
datetick;
ylabel('Chaetoceros with Pennates, Chains/ml');

figure
plot(matdate_bin(ind67),(classcount_bin(ind67,67)./ml_analyzed_mat_bin(ind67,67)), '.');
datetick;
ylabel('diatoms with Pennates, Chains/ml');

