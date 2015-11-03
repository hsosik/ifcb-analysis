function createfigure(X1, Y1, X2, Y2, X3, Y3,X4,Y4)
load ('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_manual_22Nov2013_day.mat')
load Tall_day2006_2013.mat

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
ind_zero59 = find(classcount_bin(:,59)==0);

ind60 = find(~isnan(ml_analyzed_mat_bin(:,60)) | nansum(ml_analyzed_mat_bin,2) == 0);


ind_highpercent = find((((classcount_bin(:,59)./ml_analyzed_mat_bin(:,59)))./...
((classcount_bin(:,59)./ml_analyzed_mat_bin(:,59))+(classcount_bin(:,14)./ml_analyzed_mat_bin(:,14))+(classcount_bin(:,60)./ml_analyzed_mat_bin(:,60))))>.1);

proportion_infected = (((classcount_bin(:,59)./ml_analyzed_mat_bin(:,59)))./...
    ((classcount_bin(:,59)./ml_analyzed_mat_bin(:,59))+(classcount_bin(:,14)./ml_analyzed_mat_bin(:,14))+(classcount_bin(:,60)./ml_analyzed_mat_bin(:,60))));



lowT = find((Tday < 4));
gray = .93;



%CREATEFIGURE(X1,Y1,X2,Y2)
X1 = matdate_bin(ind14);
Y1 = proportion_infected(ind14)*100;
X2 = matdate_bin(ind14);
Y2 = sum((classcount_bin(ind14,ind_Gdel)./ml_analyzed_mat_bin(ind14,ind_Gdel)),2);
X3 = matdate_bin(ind_highpercent);
Y3 =  sum((classcount_bin(ind_highpercent,ind_Gdel)./ml_analyzed_mat_bin(ind_highpercent,ind_Gdel)),2);
X4 = matdate_bin(ind_zero59);
Y4 = classcount_bin(ind_zero59, 59)./ml_analyzed_mat_bin(ind_zero59, 59);


plot_number = [1:9];

figure1 = figure; set(gcf, 'color', 'w', 'position', [0         0   16.5000   10.2083] )
startday_str = {'09-8-2006',...
    '12-18-2006',...
    '10-15-2007',...
    '12-05-2008',...
    '09-05-2009',...
    '06-10-2010',...
    '06-10-2011',...
    '11-01-2011',...
    '01-01-2012'};

plot_label = {'2006',...
    '2006-2007',...
    '2007',...
    '2008-2009',...
    '2009',...
    '2010',...
    '2011',...
    '2011',...
    '2012'};

plot_letter = {'a',...
    'b',...
    'c',...
    'd',...
    'e',...
    'f',...
    'g',...
    'h',...
    'i'};

for figcount = 1:length(plot_number),

    set(gcf, 'units', 'inches')
    set(gcf, 'position', [0 0 16.5000 10.2083], 'paperposition', [0 0 16.5000 10.2083]);
    set(gca, 'Linewidth', 2)
    
    t = (datenum(startday_str(figcount)));
    %2007 winter
    %t2 = t +15;
    %t3 = t+ 30;
    
    %ttick = (datestr(t, 'mmm dd'));
    %t2tick =(datestr(t2, 'mmm dd'));
    %t3tick = (datestr(t3, 'mmm dd'));
    
    subplot1 = subplot(3,3,figcount,'Parent',figure1,...
        'YTickLabel',{''},...
        'YTick',[0 10 20 30 40 50],...
        'FontSize',20,...
        'CLim',[0 1]);
    
    
    
    xl = datenum(startday_str(figcount));
    xlim([xl (xl+60 )]);
    % Uncomment the following line to preserve the Y-limits of the axes
    ylim(subplot1,[0 60]);
    %t = datenum([text_str num2str(yr2plot(figcount)-1)]);
    %text(t, 100, num2str(yr2plot(figcount)), 'fontsize', 14);
    box(subplot1,'on');
    hold(subplot1,'all');
    
    
    ind = find(figcount==1|figcount ==4 |figcount==7);
    if sum(ind)>0
        set(gca,'YTickLabel',{'', '10','', '30','','50'}, 'Fontsize', 20)
    end
    
    xl = xlim;
    ii = find(mdate(lowT)>xl(1) & mdate(lowT) < xl(2));
    if length(ii) > 0
        lineh = line(repmat(mdate(lowT(ii)),1,2)', ylim + [.5 -.5]);
        set(lineh, 'color', [gray gray gray], 'linewidth', 4.5)
    end;
    
    
    
    
    
    plot(X2,Y2,'Marker','.','LineWidth',2,'Color',[0 0 1], 'MarkerSize',14);
    
    plot(X1,Y1,'rd-','LineWidth',2, 'MarkerSize',6, 'markerfacecolor', 'r');
    
    %plot(X3,Y3,'Marker','o','LineStyle','none','LineWidth',2,'Color', [1 0 0], 'MarkerSize',9);
    
    plot(X4,Y4,'dr', 'MarkerFaceColor','w','MarkerSize',6);
    
    
    
    text((t+3), 52, plot_label(figcount), 'FontSize',20);
    text((t+53), 52, plot_letter(figcount), 'FontSize',20);
    
    
    ind = find(figcount==1);
    if sum(ind)>0
        lh = legend('\itG. delicatula\rm', 'infected chains (%)', 'location', 'best');
        set(lh, 'box', 'on', 'edgecolor', [1 1 1], 'FontSize',14);
        tpos = get(lh, 'position'); tpos(1) = tpos(1)-.02; 
        tpos(2) = tpos(2)-.035;
        set(lh, 'position', tpos)
    end
    
    
    
    ind = find(figcount==4);
    if sum(ind)>0
        ylabel({'Chains (ml^{-1})'; 'or Infected chains (%)'},'FontSize',20);
    end
    %}
    
    
    datetick('x', 'keeplimits');
    
end


shiftover = .04; shiftup = .05;

subplot(3,3,2)
p = get(gca, 'position'); p(1) = p(1) - shiftover;
set(gca, 'position', p);
subplot(3,3,3)
p = get(gca, 'position'); p(1) = p(1) - shiftover*2;
set(gca, 'position', p);
subplot(3,3,4)
p = get(gca, 'position'); p(2) = p(2)+shiftup;
set(gca, 'position', p);
subplot(3,3,5)
p = get(gca, 'position'); p(1) = p(1) - shiftover; p(2) = p(2)+shiftup;
set(gca, 'position', p);
subplot(3,3,6)
p = get(gca, 'position'); p(1) = p(1) - shiftover*2; p(2) = p(2)+shiftup;
set(gca, 'position', p);
subplot(3,3,7)
p = get(gca, 'position'); p(2) = p(2)+shiftup*2;
set(gca, 'position', p);
subplot(3,3,8)
p = get(gca, 'position'); p(1) = p(1) - shiftover; p(2) = p(2)+shiftup*2;
set(gca, 'position', p);
subplot(3,3,9)
p = get(gca, 'position'); p(1) = p(1) - shiftover*2; p(2) = p(2)+shiftup*2;
set(gca, 'position', p, 'Linewidth', 2);

    