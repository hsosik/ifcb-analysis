function [] = time_trend(mdate_mat, y_mat, yearlist, labelstr)
%function [] = time_trend(mdate_mat, y_mat, yearlist, labelstr)

figure
plot(1:366, y_mat, '.')

next_year = yearlist(end)+1;
%[ y_mat, mdate_mat, yd_wk ] = ydmat2weeklymat_1daysubsample( y_mat, yearlist );
[ y_mat, mdate_mat, yd_wk ] = ydmat2weeklymat( y_mat, yearlist );
[ ymean, ystd ] = smoothed_climatology( y_mat , 3);
%yanom = y_mat-repmat(ymeansm',1,length(yearlist));
yanom = y_mat-repmat(ymean',1,length(yearlist));

hold on
plot(yd_wk, ymean, 'linewidth', 2);
ylabel(labelstr)
datetick

figure
set(gcf, 'position', [350 600 720 200])
plot(mdate_mat(:), y_mat(:), '.'), hold on
xlim(datenum([yearlist(1) next_year],1,1))
set(gca, 'xtick', datenum([yearlist next_year],1,1))
datetick('x', 'keeplimits', 'keepticks')
[s,b,r,p]=fit_line(mdate_mat(:), y_mat(:));
fplot(['x*' num2str(s) '+' num2str(b)], xlim,'k')
title(['r = ' num2str(r(1), '%.2f') '; \tau = '  num2str(r(2), '%.2f') '; y = ' num2str(s) '*x+' num2str(b) '; p = ' num2str(p, '%.3f ')])
ylabel(labelstr)

figure
set(gcf, 'position', [350 600 720 200])
plot(mdate_mat(:), yanom(:), '.'), hold on
xlim(datenum([yearlist(1) next_year],1,1))
set(gca, 'xtick', datenum([yearlist next_year],1,1))
datetick('x', 'keeplimits', 'keepticks')
[s,b,r,p]=fit_line(mdate_mat(:), yanom(:));
fplot(['x*' num2str(s) '+' num2str(b)], xlim,'k')
title(['r = ' num2str(r(1), '%.2f') '; \tau = '  num2str(r(2), '%.2f') '; y = ' num2str(s) '*x+' num2str(b) '; p = ' num2str(p, '%.3f ')])
line(xlim, [0 0], 'linestyle',  '--')
ylabel([labelstr ', anom'])

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
