load C:\work\MVCO_May2003\code_misc\FCBsummary_cellsperml
clear *2*
ii = find(~isnan(matdate_fcball));
[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( matdate_fcball(ii), (synpermlall(ii)) );
[ mdate_mat_1hr, y_mat_1hr, yearlist, yd ] = timeseries2ydmat_1hrsubsample( matdate_fcball(ii), (synpermlall(ii)) );

[ y_wkmat, mdate_mat, yd_wk ] = ydmat2weeklymat( y_mat, yearlist );
[ ymean, ystd ] = smoothed_climatology( y_wkmat , 3);
yanom = y_wkmat-repmat(ymean',1,length(yearlist));

[ y_wkmat_day, mdate_mat, yd_wk ] = ydmat2weeklymat_1daysubsample( y_mat, yearlist );
[ ymean, ystd ] = smoothed_climatology( y_wkmat_day , 3);
yanom_1day = y_wkmat_day-repmat(ymean',1,length(yearlist));

[ y_wkmat_1hr_1day, mdate_mat2, yd_wk ] = ydmat2weeklymat_1daysubsample( y_mat_1hr, yearlist );
[ ymean, ystd ] = smoothed_climatology( y_wkmat_1hr_1day , 3);
yanom_1hr_1day = y_wkmat_1hr_1day-repmat(ymean',1,length(yearlist));

labelstr = 'Syn, mL^{-1}';
next_year = yearlist(end)+1;

figure
set(gcf, 'position', [350 600 720 200])
plot(mdate_mat(:), y_wkmat(:), '.'), hold on
xlim(datenum([yearlist(1) next_year],1,1))
set(gca, 'xtick', datenum([yearlist next_year],1,1))
datetick('x', 'keeplimits', 'keepticks')
[s,b,r,p]=fit_line(mdate_mat(:), y_wkmat(:));
fplot(['x*' num2str(s) '+' num2str(b)], xlim,'k')
title(['r = ' num2str(r(1), '%.2f') '; \tau = '  num2str(r(2), '%.2f') '; y = ' num2str(s) '*x+' num2str(b) '; p = ' num2str(p, '%.3f ')])
ylabel(labelstr)
ylim([0 4e5])

[s,b,r,p]=fit_line(mdate_mat(:), yanom(:));
figure
set(gcf, 'position', [350 600 720 200])
ipos = find(yanom(:)>0);
bar(mdate_mat(ipos), yanom(ipos), 'r', 'edgecolor', 'r')
hold on 
ineg = find(yanom(:)<0);
bar(mdate_mat(ineg), yanom(ineg), 'b', 'edgecolor', 'b')
xlim(datenum([yearlist(1) next_year],1,1))
set(gca, 'xtick', datenum([yearlist next_year],1,1))
datetick('x', 'keeplimits', 'keepticks')
%[s,b,r,p]=fit_line(mdate_mat(:), yanom(:));
fplot(['x*' num2str(s) '+' num2str(b)], xlim,'k')
title(['r = ' num2str(r(1), '%.2f') '; \tau = '  num2str(r(2), '%.2f') '; y = ' num2str(s) '*x+' num2str(b) '; p = ' num2str(p, '%.3f ')])
ylabel([labelstr ', anom'])
ylim([-1e5 3e5])

figure
set(gcf, 'position', [350 600 720 200])
plot(mdate_mat2(:), y_wkmat_1hr_1day(:), '.'), hold on
xlim(datenum([yearlist(1) next_year],1,1))
set(gca, 'xtick', datenum([yearlist next_year],1,1))
datetick('x', 'keeplimits', 'keepticks')
[s,b,r,p]=fit_line(mdate_mat2(:), y_wkmat_1hr_1day(:));
fplot(['x*' num2str(s) '+' num2str(b)], xlim,'k')
title(['r = ' num2str(r(1), '%.2f') '; \tau = '  num2str(r(2), '%.2f') '; y = ' num2str(s) '*x+' num2str(b) '; p = ' num2str(p, '%.3f ')])
ylabel(labelstr)
ylim([0 4e5])

[s,b,r,p]=fit_line(mdate_mat2(:), yanom_1hr_1day(:));
figure
set(gcf, 'position', [350 600 720 200])
ipos = find(yanom(:)>0);
bar(mdate_mat2(ipos), yanom_1hr_1day(ipos), 'r', 'edgecolor', 'r')
hold on 
ineg = find(yanom(:)<0);
bar(mdate_mat2(ineg), yanom_1hr_1day(ineg), 'b', 'edgecolor', 'b')
xlim(datenum([yearlist(1) next_year],1,1))
set(gca, 'xtick', datenum([yearlist next_year],1,1))
datetick('x', 'keeplimits', 'keepticks')
%[s,b,r,p]=fit_line(mdate_mat(:), yanom(:));
fplot(['x*' num2str(s) '+' num2str(b)], xlim,'k')
title(['r = ' num2str(r(1), '%.2f') '; \tau = '  num2str(r(2), '%.2f') '; y = ' num2str(s) '*x+' num2str(b) '; p = ' num2str(p, '%.3f ')])
ylabel([labelstr ', anom'])
ylim([-1e5 3e5])

figure
plot(yanom(:), yanom_1hr_1day(:), '.')
line(xlim, xlim)
xlabel({'Full (1-h) resolution' 'weekly anomaly Syn per mL'})
ylabel({'Subsampled to 1-h per week' ; 'weekly anomaly Syn per mL'})

figure
plot(matdate_fcball, synpermlall)
hold on
plot(mdate_mat, y_wkmat, '.r')
datetick