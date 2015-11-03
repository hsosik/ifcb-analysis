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
  Y1 = classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59)*10;
  X2 = matdate_bin(ind14);
  Y2 = classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14);
  X3 = matdate_bin(ind_highpercent);
  Y3 = classcount_bin(ind_highpercent, 14)./ml_analyzed_mat_bin(ind_highpercent,14);
  X4 = matdate_bin(ind_high59);
  Y4 = classcount_bin(ind_high59, 59)./ml_analyzed_mat_bin(ind_high59, 59)*10;

  yr2plot = [2007 2010 2009 2011 2012 2013];
  
  figure1 = figure;
  startday_str = '12-1-';
  endday_str = '03-1-';
  text_str = '12-15-';
for figcount = 1:length(yr2plot),
    
set(gcf, 'units', 'inches')
set(gcf, 'position', [1 1 12.5 9], 'paperposition', [1 1 12.5 9]);
  
 %2007 winter
subplot1 = subplot(3,2,figcount,'Parent',figure1,...
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

plot(X3,Y3,'Marker','o','LineStyle','none','LineWidth',1,'Color', [1 0 0], 'MarkerSize',6);

plot(X4,Y4,'Marker','.','LineStyle','none','LineWidth',1, 'Color',[1 0 0]);
% Create plot

if figcount == 1,
lh = legend('\itG. delicatula\rm', 'infected \itG. delicatula\rm', '> 10% infection', 'location', 'northeast');
set(lh, 'box', 'off')
end;

plot(mdate(:), Tday(:)*5, 'g')
line(xlim, [5 5]*5,'linestyle',  ':', 'color', 'g')
end;
return

%2009 winter
 subplot2 = subplot(3,2,3,'Parent',figure1,...
    'YTickLabel',{'0', '40', '80', '120'},...
    'YTick',[0 40 80 120],...
    'XTickLabel',{''},...
    'XTick',[733743 733774 733805 733833  733864 733894],...
    'XGrid','off',...
    'FontSize',14,...
    'CLim',[0 1]);
% Uncomment the following line to preserve the X-limits of the axes
 xlim(subplot2,[733743 733894]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot2,[0 130]);

%to change the position of the subplot on the paper
shiftup = .05;
p = get(gca, 'position');
p(2) = p(2)+shiftup;
set(gca, 'position', p);

text(733757, 100, '2009', 'fontsize', 14);

box(subplot2,'on');
hold(subplot2,'all');



plot(X2,Y2,'Marker','.','LineWidth',1,'Color',[0 0 1]);
% Create plot
plot(X1,Y1,'Marker','d','LineWidth',1,'MarkerEdgeColor',[1 0 0],...
                       'MarkerFaceColor',[1 1 1],'Color',[1 0 0], 'MarkerSize',4);

plot(X3,Y3,'Marker','o','LineStyle','none','Color', [1 0 0], 'MarkerSize',6);

plot(X4,Y4,'Marker','.','LineStyle','none','LineWidth',1, 'Color',[1 0 0]);
% Create plot
ylabel('Chains (mL^{-1})','FontSize',14);

%2012 winter

 subplot3 = subplot(3,2,5,'Parent',figure1,...
    'YTickLabel',{'0', '40', '80', '120'},...
    'YTick',[0 40 80 120],...
    'XTickLabel',{'Dec 1', 'Jan 1', 'Feb 1', 'Mar 1', 'Apr 1'},...
    'XTick',[734838 734869 734900 734929  734960],...
    'XGrid','off',...
    'FontSize',14,...
    'CLim',[0 1]);
% Uncomment the following line to preserve the X-limits of the axes
 xlim(subplot3,[734838 734990]);

% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot3,[0 130]);

%to change the position of the subplot on the paper
shiftup = .1;
p = get(gca, 'position');
p(2) = p(2)+shiftup;
set(gca, 'position', p);

text(734852, 100, '2012', 'fontsize', 14);


box(subplot3,'on');
hold(subplot3,'all');

plot(X2,Y2,'Marker','.','LineWidth',1,'Color',[0 0 1]);
% Create plot
plot(X1,Y1,'Marker','d','LineWidth',1,'MarkerEdgeColor',[1 0 0],...
                       'MarkerFaceColor',[1 1 1],'Color',[1 0 0], 'MarkerSize',4);

plot(X3,Y3,'Marker','o','LineStyle','none','Color', [1 0 0], 'MarkerSize',6);

plot(X4,Y4,'Marker','.','LineStyle','none','LineWidth',1, 'Color',[1 0 0]);



 %2010 winter
subplot4 = subplot(3,2,2,'Parent',figure1,...
      'YTickLabel',{''},...
    'YTick',[0 40 80 120],...
    'XTickLabel',{''},...
    'XTick',[734108 734139 734170 734198  734229 734259],...
    'XGrid','off',...
    'FontSize',14,...
    'CLim',[0 1]);
% Uncomment the following line to preserve the X-limits of the axes
 xlim(subplot4,[734108 734259]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot4,[0 130]);

shiftleft = 0.08;
p = get(gca, 'position');
p(1) = p(1)- shiftleft;
set(gca, 'position', p);

text(734122, 100, '2010', 'fontsize', 14);

box(subplot4,'on');
hold(subplot4,'all');



plot(X2,Y2,'Marker','.','LineWidth',1,'Color',[0 0 1]);
% Create plot
plot(X1,Y1,'Marker','d','LineWidth',1,'MarkerEdgeColor',[1 0 0],...
                       'MarkerFaceColor',[1 1 1],'Color',[1 0 0], 'MarkerSize',4);

plot(X3,Y3,'Marker','o','LineStyle','none','LineWidth',1,'Color', [1 0 0], 'MarkerSize',6);

plot(X4,Y4,'Marker','.','LineStyle','none','LineWidth',1, 'Color',[1 0 0]);
% Create plot

%2011 winter
 subplot5 = subplot(3,2,4,'Parent',figure1,...
    'YTickLabel',{''},...
    'YTick',[0 30 60 90 120],...
    'XTickLabel',{''},...
    'XTick',[734473 734504 734535 734563  734594 734624],...
    'XGrid','off',...
    'FontSize',14,...
    'CLim',[0 1]);
% Uncomment the following line to preserve the X-limits of the axes
 xlim(subplot5,[734473 734624]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot5,[0 130]);

%to change the position of the subplot on the paper
shiftup = .05;
p = get(gca, 'position');
p(2) = p(2)+shiftup;
set(gca, 'position', p);

shiftleft = 0.08;
p = get(gca, 'position');
p(1) = p(1)- shiftleft;
set(gca, 'position', p);

text(734487, 100, '2011', 'fontsize', 14);

box(subplot5,'on');
hold(subplot5,'all');



plot(X2,Y2,'Marker','.','LineWidth',1,'Color',[0 0 1]);
% Create plot
plot(X1,Y1,'Marker','d','LineWidth',1,'MarkerEdgeColor',[1 0 0],...
                       'MarkerFaceColor',[1 1 1],'Color',[1 0 0], 'MarkerSize',4);

plot(X3,Y3,'Marker','o','LineStyle','none','Color', [1 0 0], 'MarkerSize',6);

plot(X4,Y4,'Marker','.','LineStyle','none','LineWidth',1, 'Color',[1 0 0]);
% Create plot


%2013 winter

 subplot6 = subplot(3,2,6,'Parent',figure1,...
    'YTickLabel',{''},...
    'YTick',[0 40 80 120],...
    'XTickLabel',{'Dec 1', 'Jan 1', 'Feb 1', 'Mar 1', 'Apr 1'},...
    'XTick',[735204 735235 735266 735294  735325],...
    'XGrid','off',...
    'FontSize',14,...
    'CLim',[0 1]);
% Uncomment the following line to preserve the X-limits of the axes
 xlim(subplot6,[735204 735355]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot6,[0 130]);

%to change the position of the subplot on the paper
shiftup = .1;
p = get(gca, 'position');
p(2) = p(2)+shiftup;
set(gca, 'position', p);

shiftleft = 0.08;
p = get(gca, 'position');
p(1) = p(1)- shiftleft;
set(gca, 'position', p);

text(735218, 100, '2013', 'fontsize', 14);

box(subplot6,'on');
hold(subplot6,'all');



plot(X2,Y2,'Marker','.','LineWidth',1,'Color',[0 0 1]);
% Create plot
plot(X1,Y1,'Marker','d','LineWidth',1,'MarkerEdgeColor',[1 0 0],...
                       'MarkerFaceColor',[1 1 1],'Color',[1 0 0], 'MarkerSize',4);

plot(X3,Y3,'Marker','o','LineStyle','none','Color', [1 0 0], 'MarkerSize',6);

plot(X4,Y4,'Marker','.','LineStyle','none','LineWidth',1, 'Color',[1 0 0]);