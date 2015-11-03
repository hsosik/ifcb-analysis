function createfigure(X1, Y1, X2, Y2, X3, Y3,X4,Y4)
 load ('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_manual_04Oct2013_day.mat')
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

  plot_number = [1:9];
  
  figure1 = figure;
  startday_str = {'09-24-2006',...
                  '01-01-2007',...
                  '10-28-2007',...
                  '12-10-2008',...
                  '09-05-2009',...
                  '06-10-2010',...
                  '06-10-2011',...
                  '11-20-2011',...
                  '01-01-2012'};
              
   plot_label = {'2006',...
                 '2007',...
                 '2007',...
                 '2008',...
                 '2009',...
                 '2010',...
                 '2011',...
                 '2011',...
                 '2012'};
  
for figcount = 1:length(plot_number),
    
set(gcf, 'units', 'inches')
set(gcf, 'position', [1 0 15 15], 'paperposition', [1 0 15 15]);
 
t = (datenum(startday_str(figcount)));
 %2007 winter
 t2 = t +15;
 t3 = t+ 30;
 
 ttick = (datestr(t, 'mmm dd'));
 t2tick =(datestr(t2, 'mmm dd'));
 t3tick = (datestr(t3, 'mmm dd'));

subplot1 = subplot(3,3,figcount,'Parent',figure1,...
    'YTickLabel',{''},...
    'YTick',[0 10 20 30 40],... 
    'XTick',[t (t+15) (t+30)],...
    'XTickLabel', [{ttick, t2tick, t3tick}],...
    'FontSize',14,...
    'CLim',[0 1]);


%'XTick',[733012 733043 733074 733102  733133 733163],...
% Uncomment the following line to preserve the X-limits of the axes
xl = datenum(startday_str(figcount)); 
xlim([xl (xl+45)]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot1,[0 50]);
%t = datenum([text_str num2str(yr2plot(figcount)-1)]);
 %text(t, 100, num2str(yr2plot(figcount)), 'fontsize', 14);
box(subplot1,'on');
hold(subplot1,'all');
%datetick('x','mmm', 'keeplimits');

ind = find(figcount==1|figcount ==4 |figcount==7);
if sum(ind)>0  
    set(gca,'YTickLabel',{'0', '10', '20', '30', '40'})
end



plot(X2,Y2,'Marker','.','LineWidth',2,'Color',[0 0 1], 'MarkerSize',14);
% Create plot
plot(X1,Y1,'Marker','d','LineWidth',2,'MarkerEdgeColor',[1 0 0],...
                       'MarkerFaceColor',[1 1 1],'Color',[1 0 0], 'MarkerSize',6);

plot(X3,Y3,'Marker','o','LineStyle','none','LineWidth',2,'Color', [1 0 0], 'MarkerSize',9);

plot(X4,Y4,'Marker','d','LineStyle','none','MarkerEdgeColor',[1 0 0],...
                       'MarkerFaceColor',[1 0 0],'Color',[1 0 0], 'MarkerSize',6);
% Create plot


 text((t+2), 44, plot_label(figcount), 'fontsize', 14);  

ind = find(figcount==4|figcount ==5 |figcount==6);
if sum(ind)>0  
shiftup = .04;
p = get(gca, 'position');
p(2) = p(2)+shiftup;
set(gca, 'position', p);
end

ind = find(figcount==7|figcount ==8 |figcount==9);
if sum(ind)>0  
shiftup = .08;
p = get(gca, 'position');
p(2) = p(2)+shiftup;
set(gca, 'position', p);
end

ind = find(figcount==2|figcount ==5 |figcount==8);
if sum(ind)>0  
shiftover = .04;
p = get(gca, 'position');
p(1) = p(1) - shiftover;
set(gca, 'position', p);
end

ind = find(figcount==3|figcount ==6 |figcount==9);
if sum(ind)>0  
shiftover = .08;
p = get(gca, 'position');
p(1) = p(1) - shiftover;
set(gca, 'position', p);
end
%if figcount == 1,
%lh = legend('\itG. delicatula\rm', 'infected \itG. delicatula\rm', '> 10% infection', 'location', 'northeast');
%set(lh, 'box', 'off')
%end;
plot(mdate(:), Tday(:), 'g')
line(xlim, [5 5],'linestyle',  ':', 'color', 'g')
%plot(mdate(:), Tday(:)*5, 'g')
%line(xlim, [5 5]*5,'linestyle',  ':', 'color', 'g')
end;
return
