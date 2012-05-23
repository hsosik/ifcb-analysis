
%created 5/16/2012 to examine ciliate size climatology and month anomalies
%summary_size_classes

diambins = 0:2:150;
year_list=2006:2012;
dv = datevec(unqday);

%creating 3D matrix for diameter bins of every month for every year
%(151x12x7)(number of bins x month x year)
for year_count=1:length(year_list);%loops over each year
for month=1:12 %in each year loops over each month
ind = find(dv(:,1) == year_list(year_count) & dv(:,2) == month & ~isnan([ml_day.ciliate_mix]')); %finds years and months
h=nan(length(diambins),length(ind));%creates an empty 3D matrix to accomadate for the amount of bins, months, and years
for j=1:length(ind)% loops over every individual month and year
    day_index = ind(j);%the amount of individual days found in each month and year
    h(:,j)=hist(eqdiam_day(day_index).ciliate_mix, diambins)./ml_day(day_index).ciliate_mix; %stores a histogram amount of cells in each diameter bin/ml for each day
end
meanh(:,month,year_count) = mean(h,2); %average all bins across days of each month
end
end

repsum=repmat(sum(meanh,1),[length(diambins) 1 1]); %summing mean matrix over all bins for each month and year and repeating sum matrix 150 times for each bin
meanh_norm=meanh./repsum; %creating normalized mean matrix by dividing mean of diameters summed over all bins for each month and year from mean matrix

figure %plotting unnormalized sizes averaged over all years for each month (overlayed)
plot(diambins, nanmean(meanh,3));%takes mean of
legend(num2str((1:12)'))
xlabel('diameter (\mum)')
ylabel('Cells (mL^{-1})')
xlim([0 50])

figure %plotting normalized sizes averaged over all years for each month (overlayed)
plot(diambins, nanmean(meanh_norm,3))
xlabel('diameter (\mum)')
ylabel('Cells (mL^{-1})')
legend(num2str((1:12)'));
xlim([0 50]);



hnorm_clim=nanmean(meanh_norm,3);%creating normalized climatology matrix
rep_hnorm_clim=repmat(hnorm_clim,[1 1 year_count]); %repeating climatology matrix to subtract from mean 7 times for each year
hnorm_anom=meanh_norm-rep_hnorm_clim; %creating normalized anomaly matrix


%monthly normalized anomalies for each year
% for year_count=1:length(year_list);

figure
for count=1:12; %plotting normalized means
    subplot(3,4,count)
    plot(diambins, squeeze(meanh_norm(:,count,:)))
    title(['month ' num2str(count)])
    xlim([0 50]);
    ylim([0 .3]);
    xlabel('diameter (\mum)')
    ylabel('Cells (mL^{-1}\mum^{-1} )')
    set(gca,'xtick', 0:10:50)
end
legend(num2str((2006:2012)'))

figure
for count=1:12; %plotting normalized anomalies
    subplot(3,4,count)
    plot(diambins, squeeze(hnorm_anom(:,count,:)))
    title(['month ' num2str(count)])
    xlim([0 50]);
    ylim([-.10 .15]);
    xlabel('diameter (\mum)')
    ylabel('Cells (mL^{-1}\mum^{-1} )')
    set(gca,'xtick', 0:10:50)
end
legend(num2str((2006:2012)'))

figure
for count=1:12;%plotting un-normalized means
    subplot(3,4,count)
    plot(diambins, squeeze(meanh(:,count,:)))
    title(['month ' num2str(count)])
    xlim([0 50]);
    ylim([0 1]);
    xlabel('diameter (\mum)')
    ylabel('Cells (mL^{-1})')
    set(gca,'xtick', 0:10:50)
end
legend(num2str((2006:2012)'))

%anomalies with out normalization
h_clim=nanmean(meanh,3);%creating unnormalized climatology matrix
rep_h_clim=repmat(h_clim,[1 1 year_count]); %repeating climatology matrix to subtract from mean 7 times for each year
h_anom=meanh-rep_h_clim; %creating normalized anomaly matrix

% %monthly unnormalized anomalies for each year
% for year_count=1:length(year_list);
%     figure
% for count=1:12;
%     subplot(3,4,count)
%     plot(diambins, h_anom (:,count,year_count))
%     %title(['month ' num2str(count)])
%     xlim([0 50]);
%     xlabel('diameter (\mum)')
%     ylabel('Cells (mL^{-1})')
%     set(gca,'xtick', 0:10:50)
%     title(['month ' num2str(count)])
% end
% end


for year_count=1:length(year_list);
    figure(year_count)
    for month=1:12
        subplot(4,3,month)
        ind = find(dv(:,1) == year_list(year_count) & dv(:,2) == month & ~isnan([ml_day.ciliate_mix]')); %finds years and months
        h=nan(length(diambins),length(ind));%creates an empty 3D matrix to accomadate for the amount of bins, months, and years
        for j=1:length(ind)% loops over every individual month and year
            day_index = ind(j);%the amount of individual days found in each month and year
            h(:,j)=hist(eqdiam_day(day_index).ciliate_mix, diambins)./ml_day(day_index).ciliate_mix;
        end;
        if ~isempty(ind),
            plot(diambins, h)
            title([num2str(year_list(year_count)) ' month ' num2str(month)])
            xlim([0 50]);
            ylim([0 1.5]);
            xlabel('diameter (\mum)')
            ylabel('Cells (mL^{-1}\mum^{-1} )')
            set(gca,'xtick', 0:10:50)
        end;
    end
    set(gcf, 'position', [680   170   980   930])
end



for year_count=1:length(year_list);%loops over each year
 %in each year loops over each month
ind = find(dv(:,1) == year_list(year_count) & ~isnan([ml_day.ciliate_mix]')); %finds years and months
h=nan(length(diambins),length(ind));%creates an empty 3D matrix to accomadate for the amount of bins, months, and years
for j=1:length(ind)% loops over every individual month and year
    day_index = ind(j);%the amount of individual days found in each month and year
    h(:,j)=hist(eqdiam_day(day_index).ciliate_mix, diambins)./ml_day(day_index).ciliate_mix; %stores a histogram amount of cells in each diameter bin/ml for each day

end

end



