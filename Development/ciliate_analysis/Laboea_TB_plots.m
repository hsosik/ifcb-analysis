%compile_summariesLaboea

%For a threshold of 0.7, the Laboea slope is 0.7994

load /Volumes/d_work/IFCB1/ifcb_data_mvco_jun06/Manual_fromClass/summary/summary_allTB_bythre_Laboea

%ind = strmatch('Laboea', class2useTB);
%y = classcountTB_above_adhocthreshall(:,ind)./ml_analyzedTBall;
y = classcountTB_above_thre(:,7)./ml_analyzedTB;
x = mdateTB;
[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( x, y );

load '/Volumes/d_work/IFCB1/code_svn/trunk/manualclassify/class2use_MVCOmanual3.mat'
load '/Volumes/d_work/IFCB1/ifcb_data_mvco_jun06/Manual_fromClass/summary/count_manual_current_day.mat'
ind2 = strmatch('Laboea', class2use);
%%
figure
%plot(mdate_mat(:), y_mat(:),'-','Color',[0.501960813999176 0.501960813999176 0.501960813999176])
plot(mdate_mat(:), y_mat(:)/0.7994,'k-')
hold on
plot(matdate_bin,classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2), 'r*')
datetick,set(gca, 'xgrid', 'on')
ylabel('Cell concentration (mL^{-1})\bf', 'fontsize',16, 'fontname', 'Times New Roman');
set(gca, 'fontsize', 16, 'fontname', 'Times New Roman')
lh=legend('Automated classification', 'Manual classification');
set(lh,'fontsize',12)
set(gcf,'units','inches')
set(gcf,'position',[6 7 12.6 4.75],'paperposition', [1 1 12 3.75]);
%%
%title('0.7')

figure
plot(mdate_mat(:), y_mat(:),'b-','linewidth',1.5)
hold on
%plot(matdate_bin,classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2), 'r*')
datetick,set(gca, 'xgrid', 'on')
ylabel('Cell concentration (mL^{-1})\bf', 'fontsize',18, 'fontname', 'Arial');
set(gca, 'fontsize', 18, 'fontname', 'Arial')
%legend('Automated classification', 'Manual classification');
%title('0.7')
set(gca,'xgrid','on');

%%

[laboea_ci] = poisson_count_ci(classcount_bin(:,ind2), 0.95);

for i=1:length(ml_analyzed_mat_bin(:,ind));
    laboea_ci_ml(i,:)=(laboea_ci(i,:)/ml_analyzed_mat_bin(i,ind2));
end

lower=[(classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2))-laboea_ci_ml(:,1)];
upper=[laboea_ci_ml(:,2)-(classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2))]; 


figure
%plot(mdate_mat(:), y_mat(:),'-','Color',[0.501960813999176 0.501960813999176 0.501960813999176])
plot(mdate_mat(:), y_mat(:),'b-','linewidth',2)
hold on
plot(matdate_bin,classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2), 'r.','markersize',25)

%errorbar(matdate_bin,classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2), lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
%errorbar(matdate_bin,classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2), laboea_ci_ml(:,1), laboea_ci_ml(:,2), 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);


datetick,set(gca, 'xgrid', 'on')
ylabel('Cell concentration (mL^{-1})\bf', 'fontsize',24, 'fontname', 'Arial');
set(gca, 'fontsize', 24, 'fontname', 'Arial')
legend('Automated classification', 'Manual classification');
%set(gca,'paperposition',[-2.36457 2.62259 50.2291 5.75481],'units','inches')
%set(gca, 'Position',[0 0 1 1])
%set(gcf, 'PaperUnits','inches', 'PaperPosition',[0 0 945 280])

%%


% load '/Volumes/d_work/IFCB1/ifcb_data_mvco_jun06/Manual_fromClass/summary/count_manual_31Jan2014_day.mat'
% 
% compile_summariesLaboea
% 
% figure
% plot(mdateTBall,classcountTB_above_adhocthreshall(:,23)./ml_analyzedTBall,'b-');
% hold on
% plot(matdate_bin,classcount_bin(:,75)./ml_analyzed_mat_bin(:,75),'k*');
% ylabel('Cell Concentration (mL^{-1})\bf', 'fontsize', 18, 'fontname', 'Times New Roman')
% set(gca, 'fontsize', 18, 'fontname', 'Times New Roman','XGrid','on')
% set(gca,'XTickLabel',{'2006','2007','2008','2009','2010','2011','2012','2013','2014'},'XTick',[732678 733043 733408 733774 734139 734504 734869 735235 735600]);
% %datetick('x',10)
% xlim([732678 735600])
% legend('manual classification')







