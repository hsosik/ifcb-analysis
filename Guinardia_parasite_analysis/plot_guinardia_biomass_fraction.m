%load c:\work\mvco\carbon\IFCB_carbon_manual_Jan2014.mat %from summary_size_classes.m
load IFCB_carbon_manual_Jan2014 %from summary_size_classes.m
%load ('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_biovol_manual_29Jul2013_day.mat')
[ ind_Gdel, class_label ] = get_G_delicatula_ind( classes, classes );

Y = C10_20phyto_mat(:)+C20_infphyto_mat(:);  %total > 10 microns
[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( Cmdate_day, sum(C_day_mat(:,ind_Gdel),2) ); %total G. del
ii = find(~isnan(Y));

X = Cmdate_mat(ii);
Y = y_mat(ii)./Y(ii);

gapsize = 30;
ii = find(diff(X) > gapsize);
while ~isempty(ii),
    ii = ii(1);
    X = [X(1:ii); NaN; X(ii+1:end)];
    Y = [Y(1:ii); NaN; Y(ii+1:end)];
    ii = find(diff(X) > gapsize);
end;

figure1 = figure;
set(gcf, 'units', 'inches')
set(gcf, 'position', [0 0 15 14], 'paperposition', [0 0 15 14]);
subplot(3,1,1)    
plot(X,Y, '.-')
ylabel({'\itG. delicatula\rm'; 'biomass fraction'},'FontSize',20)
set(gca, 'Xlim', datenum({'6-1-2006'; '1-1-2014'}), 'XTick',datenum({'1-1-2007', '1-1-2008', '1-1-2009', '1-1-2010', '1-1-2011', '1-1-2012', '1-1-2013', '1-1-2014'}))
set(gca, 'FontSize',20, 'ylim', [0 1]);
datetick('x', 'keepticks', 'keeplimits')
