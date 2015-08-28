compile_summariesLaboea

ind = strmatch('Myrionecta', class2useTB);
y = classcountTB_above_adhocthreshall(:,ind)./ml_analyzedTBall;
x = mdateTBall;
[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( x, y );

load '/Volumes/IFCB1/code_svn/trunk/manualclassify/class2use_MVCOmanual3.mat'
load '/Volumes/d_work/IFCB1/ifcb_data_mvco_jun06/Manual_fromClass/summary/count_manual_31Jan2014_day.mat'
ind2 = strmatch('Mesodinium', class2use);
%%
figure
%plot(mdate_mat(:), y_mat(:),'-','Color',[0.501960813999176 0.501960813999176 0.501960813999176])
plot(mdate_mat(:), y_mat(:),'b-')
hold on
plot(matdate_bin,classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2), 'r*')
datetick,set(gca, 'xgrid', 'on')
ylabel('Abundance (cell mL^{-1})\bf', 'fontsize',24, 'fontname', 'Times New Roman');
set(gca, 'fontsize', 24, 'fontname', 'Times New Roman')
legend('Automated classification', 'Manual classification');
%%
%title('0.7')

figure
plot(mdate_mat(:), y_mat(:),'b-','linewidth',1.5)
hold on
%plot(matdate_bin,classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2), 'r*')
datetick,set(gca, 'xgrid', 'on')
ylabel('Abundance (cell mL^{-1})\bf', 'fontsize',18, 'fontname', 'Arial');
set(gca, 'fontsize', 18, 'fontname', 'Arial')
%legend('Automated classification', 'Manual classification');
%title('0.7')
set(gca,'xgrid','on');

%%

figure
%plot(mdate_mat(:), y_mat(:),'-','Color',[0.501960813999176 0.501960813999176 0.501960813999176])
plot(mdate_mat(:), y_mat(:),'b-','linewidth',2)
hold on
plot(matdate_bin,classcount_bin(:,ind2)./ml_analyzed_mat_bin(:,ind2), 'r.','markersize',25)
datetick,set(gca, 'xgrid', 'on')
ylabel('Abundance (cell mL^{-1})\bf', 'fontsize',24, 'fontname', 'Arial');
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





