classes = fields(ml_analyzed_struct);
day = floor(matdate);
unqday = unique(day);
diambins = 0:2:150;
year_list=2006:2013;
dv = datevec(unqday);


% for classcount=71:length(classes),
%     test=cell2mat(eqdiam.(classes{classcount})');
%     figure
%     hist(test, diambins);
%     title(classes{classcount});
% end

% t=eqdiam.Ciliate_mix;
% averages = cellfun(@mean, t);
% t_1=ml_analyzed_struct.Ciliate_mix;

%[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,averages', t_1');

for year_count=1:length(year_list);%loops over each year
for month=1:12 %in each year loops over each month
ind = find(dv(:,1) == year_list(year_count) & dv(:,2) == month & ~isnan([ml_day.Mesodinium_sp]')); %finds years and months
%ind = find(dv(:,1) == year_list(year_count) & dv(:,2) == month & ~isnan([ml_day.tintinnid]')); %finds years and months
h=nan(length(diambins),length(ind));%creates an empty 3D matrix to accomadate for the amount of bins, months, and years
for j=1:length(ind)% loops over every individual month and year
    day_index = ind(j);%the amount of individual days found in each month and year
    h(:,j)=hist(eqdiam_day(day_index).Mesodinium_sp, diambins)./ml_day(day_index).Mesodinium_sp; %stores a histogram amount of cells in each diameter bin/ml for each day
    %h(:,j)=hist(eqdiam_day(day_index).tintinnid, diambins)./ml_day(day_index).tintinnid;
end
meanh(:,month,year_count) = mean(h,2); %average all bins across days of each month
end
end

repsum=repmat(sum(meanh,1),[length(diambins) 1 1]); %summing mean matrix over all bins for each month and year and repeating sum matrix 150 times for each bin
meanh_norm=meanh./repsum; %creating normalized mean matrix by dividing mean of diameters summed over all bins for each month and year from mean matrix


t=colormap(jet);
t=t(12:64/12:end,:);
figure %plotting normalized sizes averaged over all years for each month (overlayed)
set(gca, 'colororder', t)
hold on
plot(diambins, nanmean(meanh_norm,3), 'linewidth', 2)
xlabel('Equivalent circular diameter (\mum)', 'fontsize', 14)
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 14)
%legend(num2str((1:12)'));
xlim([0 100]);
legend('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec');
set(gca,'fontsize',14, 'YTick',[0 0.5 1])
title(['Tontonia gracillima'])

%test=cell2mat(eqdiam.Ciliate_mix');

% test=eqdiam.Ciliate_mix;
% t=cellfun('isempty',test);
% ind=find(t==0);
% data_hist=[];
% 
% for j=1:length(ind)
%     temp=test{ind(j)};
%     data_hist=[data_hist; temp];
% end
% 
% figure
% hist(data_hist,diambins)
% title('Ciliate Mix')
% 
hnorm_clim=nanmean(meanh_norm,3);%creating normalized climatology matrix
rep_hnorm_clim=repmat(hnorm_clim,[1 1 year_count]); %repeating climatology matrix to subtract from mean 7 times for each year
hnorm_anom=meanh_norm-rep_hnorm_clim; %creating normalized anomaly matrix


figure
for count=1:12; %plotting normalized means
    subplot(3,4,count)
    h= plot(diambins, squeeze(meanh_norm(:,count,:)));
    title(['month ' num2str(count)])
    xlim([0 50]);
    ylim([0 .5]);
    xlabel('Diameter (\mum)')
    ylabel('Cells (mL^{-1}\mum^{-1} )')
    set(h(8),'DisplayName','2013','Color',[0 0 0]);
    set(gca,'xtick', 0:10:50)
end
legend(num2str((2006:2013)'))