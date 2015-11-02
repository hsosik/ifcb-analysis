

%summary_size_classes

%show the size dist of ALL the M.rubra in the whole data set
% diambins = 0:1:60;
% hist(cat(1,eqdiam_day.Myrionecta),diambins)
% %OR
% % %size dist for all Mrubra measured in January
% % dv = datevec(unqday);
% % ind = find(dv(:,2) == 1 & ~isnan([ml_day.Myrionecta]'));
% % hist(cat(1,eqdiam_day(ind).Myrionecta),diambins)
% % OR
% %size dist in cells per mL per bin for just the 15th day
% temphist = hist(eqdiam_day(15).Myrionecta,diambins);
% bar(diambins, temphist./ml_day(15).Myrionecta)


diambins = 0:1:150;
%size dist for all Mrubra for each year
j=0;
for year=2006:2012;
j=j+1;
figure(j)
dv = datevec(unqday);
ind = find(dv(:,1) == year & ~isnan([ml_day.ciliate_mix]'));

hist(cat(1,eqdiam_day(ind).ciliate_mix),diambins)
xlim([0 150])
title(['Year: ' num2str(year)])
pause
end

%size dist for all Mrubra for each month
% for month=1:12;
% j=j+1;
% figure(j)
% dv = datevec(unqday);
% ind = find(dv(:,2) == month & ~isnan([ml_day.ciliate_mix]'));
% 
% hist(cat(1,eqdiam_day(ind).ciliate_mix),diambins)
% title(['Month: ' num2str(month)])
% xlim([0 150])
% pause
% end;

figure
for month=1:12;
subplot(3,4,month)
dv = datevec(unqday);
ind = find(dv(:,2) == month & ~isnan([ml_day.ciliate_mix]'));

hist(cat(1,eqdiam_day(ind).ciliate_mix),diambins)
title(['Month: ' num2str(month)])
xlim([10 150])
set(gca, 'xscale', 'log', 'xgrid', 'on')
end

for year = 2006:2012,
    figure
    for month=1:12;
        subplot(3,4,month)
        dv = datevec(unqday);
        ind = find(dv(:,1) == year & dv(:,2) == month & ~isnan([ml_day.ciliate_mix]'));
        hist(cat(1,eqdiam_day(ind).ciliate_mix),diambins)
        title(['Month: ' num2str(month)])
        xlim([10 150])
        set(gca, 'xscale', 'log', 'xgrid', 'on')
    end
end




for year = 2006:2012, %to normalize histograms %bar(hist(Y) ./ sum(hist(Y)))
    figure
    for month=1:12;
        subplot(3,4,month)
        dv = datevec(unqday);
        ind = find(dv(:,1) == year & dv(:,2) == month & ~isnan([ml_day.ciliate_mix]'));
        C=hist(cat(1,eqdiam_day(ind).ciliate_mix),diambins);
        C = C ./ sum(C);
        bar(C);
        title(['Month: ' num2str(month)])
        xlim([10 150])
        set(gca, 'xscale', 'log', 'xgrid', 'on')
    end
end




% j=0;
% for year=2006:2012;
%     j=j+1;
%     figure(j)
%     dv = datevec(unqday);
%     ind = find(dv(:,1) == year & ~isnan([ml_day.ciliate_mix]'));
%     climatology= sum(eqdiam_day(ind).ciliate_mix)./sum(ml_day(ind).ciliate_mix);
%     hist(cat(1,eqdiam_day(ind).ciliate_mix),diambins)
%     xlim([0 150])
%     title(['Year: ' num2str(year)])
%     xlim([10 150])
%     set(gca, 'xscale', 'log', 'xgrid', 'on')
%     pause
% end



