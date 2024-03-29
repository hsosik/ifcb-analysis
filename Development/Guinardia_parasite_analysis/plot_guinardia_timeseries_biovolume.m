function createfigure(X1, Y1, X2, Y2, X3, Y3,X4,Y4)
load ('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_biovol_manual_29Jul2013_day.mat')
load Tall_day2006_2013.mat
ind59 = find(~isnan(ml_analyzed_mat_bin(:,59)));
ind14 = find(~isnan(ml_analyzed_mat_bin(:,14)));
ind_high59 = find(classbiovol_bin(:,59)>0);

%TO make cirlces around any that have >10%
ind_highpercent = find((((classbiovol_bin(:,59)./ml_analyzed_mat_bin(:,59)))./...
((classbiovol_bin(:,59)./ml_analyzed_mat_bin(:,59))+(classbiovol_bin(:,14)./ml_analyzed_mat_bin(:,14))))>.1);

%To make circles around >10% and more than 5 counts of Guinardia
%ind_highpercent = find((((classbiovol_bin(:,59)./ml_analyzed_mat_bin(:,59)))./...
%((classbiovol_bin(:,59)./ml_analyzed_mat_bin(:,59))+(classbiovol_bin(:,14)./ml_analyzed_mat_bin(:,14))))>.1...
%& (classbiovol_bin(:,14)./ml_analyzed_mat_bin(:,14))>5);




%CREATEFIGURE(X1,Y1,X2,Y2)
  X1 = matdate_bin(ind59);
  Y1 = classbiovol_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59);
  X2 = matdate_bin(ind14);
  Y2 = classbiovol_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14);
  X3 = matdate_bin(ind_highpercent);
  Y3 = classbiovol_bin(ind_highpercent, 14)./ml_analyzed_mat_bin(ind_highpercent,14);
  X4 = matdate_bin(ind_high59);
  Y4 = classbiovol_bin(ind_high59, 59)./ml_analyzed_mat_bin(ind_high59, 59);

%  Auto-generated by MATLAB on 17-Jul-2013 10:39:53

% Create figure
figure1 = figure;


% Create axes
%subplot1 = subplot(2,1,1,'Parent',figure1);
subplot1 = subplot(2,1,1, 'Parent', figure1,...
    'XTickLabel',{'2005','2006','2007','2008','2009','2010','2011','2012','2013','2014'},...
    'XTick',[732313 732678 733043 733408 733774 734139 734504 734869 735235 735600],...
    'XGrid','on',...
    'FontSize',14);
% Uncomment the following line to preserve the X-limits of the axes
 xlim(subplot1,[732750 735500]);
% Uncomment the following line to preserve the Y-limits of the axes
%ylim(subplot1,[0 130]);

box(subplot1,'on');
hold(subplot1,'all');



plot(X2,Y2, 'Parent', subplot1, 'Marker','.','LineWidth',2,'Color',[0 0 1]);


plot(X3,Y3,'Marker','o','LineStyle','none','LineWidth',2,'Color', [1 0 0], 'MarkerSize',6);



for i = [732678 733043 733408 733774 734139 734504 734869 735235];
    line([i,i], [0 130], 'LineStyle', ':','LineWidth',1, 'Color',[0 0 0]);
end

for i = [732678 733043 733408 733774 734139 734504 734869 735235];
    line([(i+91),(i+91)], [0 3],'LineWidth',1, 'Color',[0 0 0]);
    line([(i+182),(i+182)], [0 3],'LineWidth',1, 'Color',[0 0 0]);
    line([(i+274),(i+274)], [0 3],'LineWidth',1, 'Color',[0 0 0]);
end



% Create ylabel
ylabel('biovolume','FontSize',14);

legend('G. delicatula', '> 10% infection');


%************************************

subplot2 = subplot(2,1,2, 'Parent', figure1,...
    'XTickLabel',{'2005','2006','2007','2008','2009','2010','2011','2012','2013','2014'},...
    'XTick',[732313 732678 733043 733408 733774 734139 734504 734869 735235 735600],...
    'XGrid','on',...
    'FontSize',14);
% Uncomment the following line to preserve the X-limits of the axes
 xlim(subplot2,[732750 735500]);
% Uncomment the following line to preserve the Y-limits of the axes
%ylim(subplot2,[0 50]);

box(subplot2,'on');
hold(subplot2,'all');

plot(X1,Y1, 'Parent', subplot2, 'Marker','d','LineWidth',2,'MarkerEdgeColor',[1 0 0],...
                       'MarkerFaceColor',[1 1 1],'Color',[1 0 0], 'MarkerSize',4);

plot(X4,Y4,'Parent', subplot2,'Marker','.','LineStyle','none','LineWidth',2, 'Color',[1 0 0]);






for i = [732678 733043 733408 733774 734139 734504 734869 735235];
    line([i,i], [0 130], 'LineStyle', ':','LineWidth',1, 'Color',[0 0 0]);
end

for i = [732678 733043 733408 733774 734139 734504 734869 735235];
    line([(i+91),(i+91)], [0 .5],'LineWidth',1, 'Color',[0 0 0]);
    line([(i+182),(i+182)], [0 .5],'LineWidth',1, 'Color',[0 0 0]);
    line([(i+274),(i+274)], [0 .5],'LineWidth',1, 'Color',[0 0 0]);
end



% Create ylabel
ylabel('biovolume','FontSize',14);

legend('G. delicatula parasite');


set(gcf, 'position', [100 350 1700 600]);