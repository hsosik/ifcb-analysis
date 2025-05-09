function createfigure(X1, Y1, X2, Y2, X3, Y3,X4,Y4)
load ('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_manual_05Dec2013_day.mat')
Tnode = load('Tall_day2006_2013');
Tbeam = load('Tday_beam');

Tday = Tnode.Tday; 
mdate = Tnode.mdate;
%Tday = Tbeam.Tday_beam;
%mdate = Tbeam.mdate_mat;

colsize = size(classcount_bin,2);
gapsize = 30;
ii = find(diff(matdate_bin) > gapsize);
while ~isempty(ii),
    ii = ii(1);
    matdate_bin = [matdate_bin(1:ii); NaN; matdate_bin(ii+1:end)];
    classcount_bin = [classcount_bin(1:ii,:); repmat(NaN, 1,colsize); classcount_bin(ii+1:end,:)];
    ml_analyzed_mat_bin = [ml_analyzed_mat_bin(1:ii,:); repmat(NaN, 1,colsize); ml_analyzed_mat_bin(ii+1:end,:)];
    ii = find(diff(matdate_bin) > gapsize);
end;

[ ind_Gdel, class_label ] = get_G_delicatula_ind( class2use, class2use );

ind59 = find(~isnan(ml_analyzed_mat_bin(:,59)) | nansum(ml_analyzed_mat_bin,2) == 0);
ind14 = find(~isnan(ml_analyzed_mat_bin(:,14)) | nansum(ml_analyzed_mat_bin,2) == 0);
ind_high59 = find(classcount_bin(:,59)>0);

ind60 = find(~isnan(ml_analyzed_mat_bin(:,60)) | nansum(ml_analyzed_mat_bin,2) == 0);


ind_highpercent = find((((classcount_bin(:,59)./ml_analyzed_mat_bin(:,59)))./...
((classcount_bin(:,59)./ml_analyzed_mat_bin(:,59))+(classcount_bin(:,14)./ml_analyzed_mat_bin(:,14))+(classcount_bin(:,60)./ml_analyzed_mat_bin(:,60))))>.1);


%To make circles around >10% and more than 5 counts of Guinardia
%ind_highpercent = find((((classcount_bin(:,59)./ml_analyzed_mat_bin(:,59)))./...
%((classcount_bin(:,59)./ml_analyzed_mat_bin(:,59))+(classcount_bin(:,14)./ml_analyzed_mat_bin(:,14))))>.1...
%& (classcount_bin(:,14)./ml_analyzed_mat_bin(:,14))>5);

lowT = find((Tday < 4));
gray = .93;



%CREATEFIGURE(X1,Y1,X2,Y2)
  X1 = matdate_bin(ind59);
  Y1 = classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59);
  X2 = matdate_bin(ind14);
  Y2 = classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14);
  X3 = matdate_bin(ind_highpercent);
  %Y3 = (classcount_bin(ind_highpercent, 14)+classcount_bin(ind_highpercent, 59) +classcount_bin(ind_highpercent, 60))./ml_analyzed_mat_bin(ind_highpercent,14);
  Y3 =  sum((classcount_bin(ind_highpercent,ind_Gdel)./ml_analyzed_mat_bin(ind_highpercent,ind_Gdel)),2);
  X4 = matdate_bin(ind_high59);
  Y4 = classcount_bin(ind_high59, 59)./ml_analyzed_mat_bin(ind_high59, 59);
  Y5 = sum((classcount_bin(ind14,ind_Gdel)./ml_analyzed_mat_bin(ind14,ind_Gdel)),2);
  %Y5 = (classcount_bin(ind14,59)+classcount_bin(ind14,14)+classcount_bin(ind14,60))./ml_analyzed_mat_bin(ind14,60);
  %Y6 = classcount_bin(ind60,60)./ml_analyzed_mat_bin(ind60,60);
  
  
%  Auto-generated by MATLAB on 17-Jul-2013 10:39:53

% Create figure
figure1 = figure;

set(gcf, 'units', 'inches')
 set(gcf, 'position', [0 0 15 14], 'paperposition', [0 0 15 14]);
%set(gcf, 'position', [0 700 700 300]);


%set(gcf, 'position', [100 350 1700 600]);
% Create axes
%subplot1 = subplot(2,1,1,'Parent',figure1);
subplot1 = subplot(3,1,1, 'Parent', figure1,...
    'YTick',[0 40 80 120],...
    'YTickLabel',{'0','40','80','120'},...
    'Xticklabel', [],...
    'XTick',datenum({'1-1-2007', '1-1-2008', '1-1-2009', '1-1-2010', '1-1-2011', '1-1-2012', '1-1-2013', '1-1-2014'}),...
    'FontSize',20, 'ylim', [0 130]);
% Uncomment the following line to preserve the X-limits of the axes
xlim(subplot1,[datenum({'6-1-2006', '1-1-2014'})]);
% Uncomment the following line to preserve the Y-limits of the axes
%ylim(subplot1,[0 130]);
datetick('x', 'keeplimits', 'keepticks')
set(gca, 'xticklabel', [])

box(subplot1,'on');
hold(subplot1,'all');


text(datenum('5-1-2013'), 112, 'a', 'FontSize',20);

lineh = line(repmat(mdate(lowT),1,2), ylim + [1 -1]);
set(lineh, 'color', [gray gray gray])


%set(gca,'children',flipud(get(gca,'children')))



ax = plot(X2,Y5, 'Parent', subplot1, 'Marker','.','LineWidth',1,'Color',[0 0 1]);

bx = plot(X3,Y3,'Marker','o','LineStyle','none','Color', [1 0 0], 'MarkerSize',6);

%plot(X2,Y5,'.g-', 'Parent', subplot1, 'MarkerSize',4);
line(repmat(get(gca, 'xtick'),2,1)', ylim, 'linestyle', ':', 'color', 'k')

%an = annotation('rectangle',...
 %   [0.18 0.8 0.05 0.09],...
  %  'FaceColor',[1 1 1],...
   % 'Color',[1 1 1]);

lh = legend([ax, bx], '\itG. delicatula\rm', '> 10% infection', 'location', 'northwest');
set(lh, 'box', 'on', 'edgecolor', [1 1 1], 'FontSize',20)
% Create ylabel
ylabel('Chains (ml^{ -1})','FontSize',20);


  
%set(lh, 'box', 'on', 'color', 'w')

%************************************

subplot2 = subplot(3,1,2, 'Parent', figure1,...
    'YTick',[0 5 10 15],...
    'YTickLabel',{'0', '5', '10', '15'},...
    'Xticklabel', [],...
    'XTick',datenum({'1-1-2007', '1-1-2008', '1-1-2009', '1-1-2010', '1-1-2011', '1-1-2012', '1-1-2013', '1-1-2014'}),...
    'FontSize',20, 'ylim', [0 18]);
% Uncomment the following line to preserve the X-limits of the axes
xlim(subplot2,[datenum({'6-1-2006', '1-1-2014'})]);
% Uncomment the following line to preserve the Y-limits of the axes
%ylim(subplot2,[0 50]);
datetick('x', 'keeplimits', 'keepticks')
set(gca, 'xticklabel', [])

box(subplot2,'on');
hold(subplot2,'all');

text(datenum('5-1-2013'), 16, 'b', 'FontSize',20);

lineh = line(repmat(mdate(lowT),1,2), ylim + [.1 -.1]);
set(lineh, 'color', [gray gray gray])

%plot(X1,Y1, 'Parent', subplot2, 'Marker','d','LineWidth',1,'MarkerEdgeColor',[1 0 0],...
%                       'MarkerFaceColor',[1 1 1],'Color',[1 0 0], 'MarkerSize',4);
plot(X1,Y1,'+r-', 'Parent', subplot2, 'MarkerSize',5);
plot(X4,Y4, 'dr', 'Parent', subplot2,'markerfacecolor', 'r', 'markersize', 5);
%plot(X1,Y6,'.g-', 'Parent', subplot2, 'MarkerSize',4);
%plot(X4,Y4,'Parent', subplot2,'Marker','.','LineStyle','none','LineWidth',1, 'Color',[1 0 0]);

line(repmat(get(gca, 'xtick'),2,1)', ylim, 'linestyle', ':', 'color', 'k')

ylabel({'Infected'; 'chains (ml^{ -1})'},'FontSize',20);
shiftup = .05;
p = get(gca, 'position');
p(2) = p(2)+shiftup;
set(gca, 'position', p);

subplot3 = subplot(3,1,3, 'Parent', figure1,...
    'YTick',[0 10 20],...
    'YTickLabel',{'0', '10', '20'},...
    'XTick',datenum({'1-1-2007', '1-1-2008', '1-1-2009', '1-1-2010', '1-1-2011', '1-1-2012', '1-1-2013', '1-1-2014'}),...
    'FontSize',20, 'ylim', [-2 22]);
% Uncomment the following line to preserve the X-limits of the axes
 xlim(subplot3,[datenum({'6-1-2006', '1-1-2014'})]);
% Uncomment the following line to preserve the Y-limits of the axes
%ylim(subplot2,[0 50]);
datetick('x', 'keeplimits', 'keepticks')

box(subplot3,'on');
hold(subplot3,'all');

text(datenum('5-1-2013'), 20, 'c', 'FontSize',20);

lineh = line(repmat(mdate(lowT),1,2), ylim + [.1 -.1] );
set(lineh, 'color', [gray gray gray])
ax = plot(Tbeam.mdate_mat(:), Tbeam.Tday_beam(:), 'g', 'linewidth', 2);
hold on
bx = plot(mdate(:), Tday(:), 'k');
lh = legend([ax, bx], '4 m', '12 m', 'location', 'northwest');
set(lh, 'box', 'off', 'FontSize',16)
line(xlim, [4 4],'linestyle',  '--', 'color', 'k', 'linewidth', 1.25)
line(repmat(get(gca, 'xtick'),2,1)', ylim, 'linestyle', ':', 'color', 'k')

shiftup = .1;
p = get(gca, 'position');
p(2) = p(2)+shiftup;
set(gca, 'position', p);
ylabel('Temperature (\circC)','FontSize',20);
tpos = get(lh, 'position');
tpos(1:2) = [0.1645    0.3597];
set(lh, 'position', tpos)

% Create ylabel




