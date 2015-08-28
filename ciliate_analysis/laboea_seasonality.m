% laboea_norm=log10(classcountTB_above_adhocthreshall(:,23));
% laboea_norm(isinf(laboea_norm)) = 0;
% laboea_mean=nanmean(laboea_norm,1);
% laboea_std=nanstd(laboea_norm);
% 
% laboea_seasonality=(laboea_norm-laboea_mean)/laboea_std;

% figure
% plot(mdateTBall,laboea_seasonality)

%%%
%compile_summariesLaboea

%ind = strmatch('Laboea', class2useTB);
%laboea_classcount = classcountTB_above_adhocthreshall(:,ind)./ml_analyzedTBall;
%mdate = mdateTBall;
%y = classcountTB_above_adhocthreshall(:,ind)./ml_analyzedTBall;
%x = mdateTBall;
%laboea_ml = classcountTB_above_adhocthreshall(:,ind)./ml_analyzedTBall;

laboea_classcount = classcountTB_above_thre(:,8)./ml_analyzedTB;
mdate = mdateTB;
y = classcountTB_above_thre(:,8)./ml_analyzedTB;
x = mdateTB;
laboea_ml = classcountTB_above_thre(:,8)./ml_analyzedTB;

[ mdate_mat, laboea_mat, yearlist, yd ] = timeseries2ydmat( mdate, laboea_ml );
[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( x, y );

%log_laboea=log10(laboea_mat);
log_laboea=laboea_mat;
log_laboea(isinf(log_laboea)) = NaN;
mean_day_laboea=nanmean(log_laboea,2);
mean_day_laboea=mean_day_laboea';

std_laboea=NaN(1,366);
for i=1:length(yd);
    std_laboea(i)=nanstd(log_laboea(i,:));
end

rep_laboea_mean = repmat(mean_day_laboea, 10, 1);
rep_laboea_std = repmat(std_laboea,10,1);

log_laboea=log_laboea';
laboea_norm=(log_laboea-rep_laboea_mean)./rep_laboea_std;

%laboea_norm=nanmean(log_laboea-rep_laboea_mean);
%%
figure
laboea_norm=laboea_norm';
plot(mdate_mat(:), laboea_norm(:),'b-')
datetick,set(gca, 'xgrid', 'on')
set(gca, 'fontsize', 18, 'fontname', 'Arial')
set(gca,'xgrid','on');

%%

[row,column]=find(laboea_norm>2 | laboea_norm<-2);

season=mdate_mat(row,column);

for i=1:length(row)
    season_A(i)=mdate_mat(row(i),column(i));
end

day = floor(season_A);
unqday = unique(day);
dv = datevec(unqday);

%figure
[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_day_bins(mdateTB,laboea_classcount, ml_analyzedTB);
laboea_perml=classcount_bin./ml_analyzed_mat_bin;
m=nanmean(laboea_perml);
s=nanstd(laboea_perml);
smooth_laboea=smooth(matdate_bin,(laboea_perml-m)/s,12);
%plot(matdate_bin,smooth_laboea)
%%
figure1 = figure;
% axes1 = axes('Parent',figure1,...
%     'YTickLabel',{'2006','2007','2008','2009','2010','2011','2012','2013'},...
%     'YTick',[1.5 2.5 3.5 4.5 5.5 6.5 7.5 8.5],...
%     'FontSize',12,...
%     'FontName','Times New Roman')

[ y_wkmat, mdate_wkmat, yd_wk ] = ydmat2weeklymat( y_mat, yearlist );
%%pcolor([y_wkmat';zeros(1,52)])
%%pcolor([y_wkmat';yd_wk'])
% pcolor([yd_wk ;yd_wk(end)+7],[yearlist yearlist(end)+1],[[y_wkmat';zeros(1,52)] zeros(11,1)])
% caxis([0 0.6])
% ylabel('Year', 'fontsize',16, 'fontname', 'Times New Roman');
% xlabel('Month', 'fontsize',16, 'fontname', 'Times New Roman');
% %datetick('x',3)

pcolor([yd_wk ;yd_wk(end)+7],[yearlist(1:9) yearlist(9)+1],[[y_wkmat(:,1:9)';zeros(1,52)] zeros(10,1)]) %for just 2006:2014
caxis([0 0.6])
ylabel('Year', 'fontsize',16, 'fontname', 'Times New Roman');
xlabel('Month', 'fontsize',16, 'fontname', 'Times New Roman');
%datetick('x',3)

h=colorbar;
% colormap(mycmap);
%set(get(h,'ylabel'),'string','Cell concentration (mL^{-1})');
set(get(h,'ylabel'),'string','Cell concentration (mL^{-1})','fontsize',16,'fontname','Times New Roman');
datetick('x',4)
axis square


