compile_summariesLaboea

ind = strmatch('Laboea', class2useTB);
y = classcountTB_above_adhocthreshall(:,ind)./ml_analyzedTBall;
x = mdateTBall;
[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( x, y );

load \\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_manual_11Jan2013_day.mat
load \\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_manual_11Jan2013.mat
ind2 = strmatch('Laboea', class2use);

figure
plot(mdate_mat(:), y_mat(:))
hold on
plot(matdate_bin,classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2), '.r')
datetick,set(gca, 'xgrid', 'on')

i2 = find(ml_analyzed_mat(:,ind2)>0);
[~,ia,ib] = intersect(filelist(i2),filelistTBall);
figure
plot(matdate(i2(ia)),classcount(i2(ia),ind2)./ml_analyzed_mat(i2(ia),ind2), '.-')
hold on
plot(mdateTBall(ib), classcountTB_above_adhocthreshall(ib,ind)./ml_analyzedTBall(ib), 'r^');
datetick

figure, plot(classcount(i2(ia),ind2)./ml_analyzed_mat(i2(ia),ind2),  classcountTB_above_adhocthreshall(ib,ind)./ml_analyzedTBall(ib), '.')
line(xlim, xlim)

[ mdate_mat1, y_mat1, yearlist, yd ] = timeseries2ydmat( matdate(i2(ia)), classcount(i2(ia),ind2)./ml_analyzed_mat(i2(ia),ind2) );
[ mdate_mat2, y_mat2, yearlist, yd ] = timeseries2ydmat( mdateTBall(ib), classcountTB_above_adhocthreshall(ib,ind)./ml_analyzedTBall(ib) );
figure, plot(mdate_mat1(:), y_mat1(:), 'r.-'), hold on, plot(mdate_mat2(:), y_mat2(:), 'b.'), datetick, set(gca, 'xgrid', 'on')
figure, plot(y_mat1(:), y_mat2(:), '.')
line(xlim, xlim)

