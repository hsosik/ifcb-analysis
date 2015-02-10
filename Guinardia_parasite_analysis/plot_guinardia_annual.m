function createfigure(X1, Y1, X2, Y2, X3, Y3,X4,Y4)
 load ('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_manual_29Jul2013_day.mat')
load Tall_day2006_2013.mat
ind59 = find(~isnan(ml_analyzed_mat_bin(:,59)));
ind14 = find(~isnan(ml_analyzed_mat_bin(:,14)));
ind_high59 = find(classcount_bin(:,59)>0);

%TO make cirlces around any that have >10%
ind_highpercent = find((((classcount_bin(:,59)./ml_analyzed_mat_bin(:,59)))./...
((classcount_bin(:,59)./ml_analyzed_mat_bin(:,59))+(classcount_bin(:,14)./ml_analyzed_mat_bin(:,14))))>.1);

%To make circles around >10% and more than 5 counts of Guinardia
%ind_highpercent = find((((classcount_bin(:,59)./ml_analyzed_mat_bin(:,59)))./...
%((classcount_bin(:,59)./ml_analyzed_mat_bin(:,59))+(classcount_bin(:,14)./ml_analyzed_mat_bin(:,14))))>.1...
%& (classcount_bin(:,14)./ml_analyzed_mat_bin(:,14))>5);




%CREATEFIGURE(X1,Y1,X2,Y2)
  X1 = matdate_bin(ind59);
  Y1 = classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59);
  X2 = matdate_bin(ind14);
  Y2 = classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14);
  X3 = matdate_bin(ind_highpercent);
  Y3 = classcount_bin(ind_highpercent, 14)./ml_analyzed_mat_bin(ind_highpercent,14);
  X4 = matdate_bin(ind_high59);
  Y4 = classcount_bin(ind_high59, 59)./ml_analyzed_mat_bin(ind_high59, 59);

  yr2plot = [2007:2012];
  
  figure1 = figure;
  startday_str = '12-1-';
  endday_str = '12-1-';
  text_str = '12-15-';
for figcount = 1:length(yr2plot),
    
set(gcf, 'units', 'inches')
set(gcf, 'position', [1 0 12.5 11], 'paperposition', [1 0 12.5 11]);
  
 %2007 winter
subplot1 = subplot(6,1,figcount,'Parent',figure1,...
     'YTickLabel',{'0', '40', '80', '120'},...
    'YTick',[0 40 80 120],...
    'XTickLabel',{''},...    
    'XGrid','off',...
    'FontSize',14,...
    'CLim',[0 1]);

%'XTick',[733012 733043 733074 733102  733133 733163],...
% Uncomment the following line to preserve the X-limits of the axes
xl = datenum([startday_str num2str(yr2plot(figcount)-1); endday_str num2str(yr2plot(figcount))]); 
xlim(xl);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot1,[0 130]);
t = datenum([text_str num2str(yr2plot(figcount)-1)]);
 text(t, 100, num2str(yr2plot(figcount)), 'fontsize', 14);
box(subplot1,'on');
hold(subplot1,'all');

plot(X2,Y2,'Marker','.','LineWidth',1,'Color',[0 0 1]);
% Create plot
plot(X1,Y1,'Marker','d','LineWidth',1,'MarkerEdgeColor',[1 0 0],...
                       'MarkerFaceColor',[1 1 1],'Color',[1 0 0], 'MarkerSize',4);

plot(X3,Y3,'Marker','o','LineStyle','none','LineWidth',1,'Color', [0 1 1], 'MarkerSize',6);

plot(X4,Y4,'Marker','.','LineStyle','none','LineWidth',1, 'Color',[1 0 0]);
% Create plot

%if figcount == 1,
%lh = legend('\itG. delicatula\rm', 'infected \itG. delicatula\rm', '> 10% infection', 'location', 'northeast');
%set(lh, 'box', 'off')
%end;

%plot(mdate(:), Tday(:)*5, 'g')
%line(xlim, [5 5]*5,'linestyle',  ':', 'color', 'g')
end;
return
