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

  
  figure1 = figure;
  
set(gcf, 'units', 'inches')
set(gcf, 'position', [1 1 12.5 9], 'paperposition', [1 1 12.5 9]);
  
 %2009 summer
subplot1 = subplot(3,2,1,'Parent',figure1,...
    'YTickLabel',{'0', '20', '40'},...
    'YTick',[0 20 40],...
     'XTickLabel',{'Sept 1','Sept 15', 'Oct 1', 'Oct 15'},...
    'XTick',[734017  734031 734047 734061],...
    'XGrid','off',...
    'FontSize',14,...
    'CLim',[0 1]);
% Uncomment the following line to preserve the X-limits of the axes
 xlim(subplot1,[734017 734078]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot1,[0 50]);

text(734022, 45, '2007', 'fontsize', 14);
box(subplot1,'on');
hold(subplot1,'all');



plot(X2,Y2,'Marker','.','LineWidth',1,'Color',[0 0 1]);
% Create plot
plot(X1,Y1,'Marker','d','LineWidth',1,'MarkerEdgeColor',[1 0 0],...
                       'MarkerFaceColor',[1 1 1],'Color',[1 0 0], 'MarkerSize',4);

plot(X3,Y3,'Marker','o','LineStyle','none','LineWidth',1,'Color', [1 0 0], 'MarkerSize',6);

plot(X4,Y4,'Marker','.','LineStyle','none','LineWidth',1, 'Color',[1 0 0]);
% Create plot

lh = legend('\itG. delicatula\rm', 'infected \itG. delicatula\rm', '> 10% infection', 'location', 'northeast');
set(lh, 'box', 'off', 'Fontsize', 12)

%2011 summer
 subplot2 = subplot(3,2,3,'Parent',figure1,...
    'YTickLabel',{'0', '20', '40'},...
    'YTick',[0 20 40],...
    'XTickLabel',{'June 1','June 15', 'July 1', ''},...
    'XTick',[734655  734669 734685 734699],...
    'XGrid','off',...
    'FontSize',14,...
    'CLim',[0 1]);
% Uncomment the following line to preserve the X-limits of the axes
 xlim(subplot2,[734655 734699]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot2,[0 50]);

%to change the position of the subplot on the paper
shiftup = .05;
p = get(gca, 'position');
p(2) = p(2)+shiftup;
set(gca, 'position', p);

text(734658, 45, '2011', 'fontsize', 14);

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

%2011 Fall

 subplot3 = subplot(3,2,5,'Parent',figure1,...
 'YTickLabel',{'0', '20', '40'},...
    'YTick',[0 20 40],...
    'XTickLabel',{'Nov 15', 'Dec 1', ''},...
    'XTick',[734822 734838 734852],...
    'XGrid','off',...
    'FontSize',14,...
    'CLim',[0 1]);
% Uncomment the following line to preserve the X-limits of the axes
 xlim(subplot3,[734822 734852]);

% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot3,[0 50]);

%to change the position of the subplot on the paper
shiftup = .1;
p = get(gca, 'position');
p(2) = p(2)+shiftup;
set(gca, 'position', p);

text(734824, 45, '2011', 'fontsize', 14);


box(subplot3,'on');
hold(subplot3,'all');

plot(X2,Y2,'Marker','.','LineWidth',1,'Color',[0 0 1]);
% Create plot
plot(X1,Y1,'Marker','d','LineWidth',1,'MarkerEdgeColor',[1 0 0],...
                       'MarkerFaceColor',[1 1 1],'Color',[1 0 0], 'MarkerSize',4);

plot(X3,Y3,'Marker','o','LineStyle','none','Color', [1 0 0], 'MarkerSize',6);

plot(X4,Y4,'Marker','.','LineStyle','none','LineWidth',1, 'Color',[1 0 0]);



 %2008 summer
subplot4 = subplot(3,2,2,'Parent',figure1,...
     'YTickLabel',{''},...
    'YTick',[0 20 40],...
     'XTickLabel',{'Jun 15', 'Jul 1', 'Jul 15'},...
    'XTick',[733574 733590 733604 733621],...
    'XGrid','off',...
    'FontSize',14,...
    'CLim',[0 1]);
% Uncomment the following line to preserve the X-limits of the axes
 xlim(subplot4,[733574 733621]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot4,[0 50]);

shiftleft = 0.08;
p = get(gca, 'position');
p(1) = p(1)- shiftleft;
set(gca, 'position', p);

text(733576, 45, '2008', 'fontsize', 14);

box(subplot4,'on');
hold(subplot4,'all');



plot(X2,Y2,'Marker','.','LineWidth',1,'Color',[0 0 1]);
% Create plot
plot(X1,Y1,'Marker','d','LineWidth',1,'MarkerEdgeColor',[1 0 0],...
                       'MarkerFaceColor',[1 1 1],'Color',[1 0 0], 'MarkerSize',4);

plot(X3,Y3,'Marker','o','LineStyle','none','LineWidth',1,'Color', [1 0 0], 'MarkerSize',6);

plot(X4,Y4,'Marker','.','LineStyle','none','LineWidth',1, 'Color',[1 0 0]);
% Create plot

%2009 summer
 subplot5 = subplot(3,2,4,'Parent',figure1,...
     'YTickLabel',{''},...
    'YTick',[0 20 40],...
    'XTickLabel',{'Jun 1', 'Jun 15', 'Jul 1', 'Jul 15', 'Aug 1' },...
    'XTick',[733925 733939 733955 733969  733986],...
    'XGrid','off',...
    'FontSize',14,...
    'CLim',[0 1]);
% Uncomment the following line to preserve the X-limits of the axes
 xlim(subplot5,[733925 733986]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot5,[0 50]);

%to change the position of the subplot on the paper
shiftup = .05;
p = get(gca, 'position');
p(2) = p(2)+shiftup;
set(gca, 'position', p);

shiftleft = 0.08;
p = get(gca, 'position');
p(1) = p(1)- shiftleft;
set(gca, 'position', p);

text(733927, 45, '2009', 'fontsize', 14);

box(subplot5,'on');
hold(subplot5,'all');



plot(X2,Y2,'Marker','.','LineWidth',1,'Color',[0 0 1]);
% Create plot
plot(X1,Y1,'Marker','d','LineWidth',1,'MarkerEdgeColor',[1 0 0],...
                       'MarkerFaceColor',[1 1 1],'Color',[1 0 0], 'MarkerSize',4);

plot(X3,Y3,'Marker','o','LineStyle','none','Color', [1 0 0], 'MarkerSize',6);

plot(X4,Y4,'Marker','.','LineStyle','none','LineWidth',1, 'Color',[1 0 0]);
% Create plot


%2012 summer

 subplot6 = subplot(3,2,6,'Parent',figure1,...
     'YTickLabel',{''},...
    'YTick',[0 20 40],...
    'XTickLabel',{'Aug 1', 'Aug 15', 'Sep 1', 'Sep 15'},...
    'XTick',[735082 735096 735113 735127],...
    'XGrid','off',...
    'FontSize',14,...
    'CLim',[0 1]);
% Uncomment the following line to preserve the X-limits of the axes
 xlim(subplot6,[735082 735127]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot6,[0 50]);

%to change the position of the subplot on the paper
shiftup = .1;
p = get(gca, 'position');
p(2) = p(2)+shiftup;
set(gca, 'position', p);

shiftleft = 0.08;
p = get(gca, 'position');
p(1) = p(1)- shiftleft;
set(gca, 'position', p);

text(735084, 45, '2012', 'fontsize', 14);

box(subplot6,'on');
hold(subplot6,'all');



plot(X2,Y2,'Marker','.','LineWidth',1,'Color',[0 0 1]);
% Create plot
plot(X1,Y1,'Marker','d','LineWidth',1,'MarkerEdgeColor',[1 0 0],...
                       'MarkerFaceColor',[1 1 1],'Color',[1 0 0], 'MarkerSize',4);

plot(X3,Y3,'Marker','o','LineStyle','none','Color', [1 0 0], 'MarkerSize',6);

plot(X4,Y4,'Marker','.','LineStyle','none','LineWidth',1, 'Color',[1 0 0]);