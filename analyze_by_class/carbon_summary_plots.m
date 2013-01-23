load c:\work\mvco\carbon\IFCB_carbon_manual_May2012.mat %from summary_size_classes.m
load c:\work\mvco\carbon\carbon_summary_fcb.mat

%FIX later! Omit one really extreme value during Phaeocystis bloom in 2009 
C20_infphyto_mat(C20_infphyto_mat(:) > 300) = NaN;

%temp = [nanmean(synCperml+picoeukCperml,2) nanmean(euk2_10Cperml(:,end-6:end),2)+nanmean(C10_20phyto_mat,2) nanmean(euk2_10Cperml(:,end-6:end)+C10_20phyto_mat,2) nanmean(C20_infphyto_mat,2)]
%nano this way:
%nanmean(euk2_10Cperml(:,end-6:end),2)+nanmean(C10_20phyto_mat,2) 
%or nano this way: 
%nanmean(euk2_10Cperml(:,end-6:end)+C10_20phyto_mat,2)
%second option gives a few more values when both 2-10 and 10-20 exist on a year day but not for the same year
%pico, nano, micro "climatology"
sizefracC = [nanmean(synCperml+picoeukCperml,2) nanmean(euk2_10Cperml(:,end-6:end),2)+nanmean(C10_20phyto_mat,2) nanmean(C20_infphyto_mat,2)];
totalC = sum(sizefracC,2);
picoC = synCperml(:,end-6:end)+picoeukCperml(:,end-6:end);
nanoC = euk2_10Cperml(:,end-6:end) + C10_20phyto_mat;
microC = C20_infphyto_mat;
totalC2 = picoC+nanoC+microC;

win = 20; 
[ totalCmn, totalCstd ] = smoothed_climatology( totalC2 , win);
%for ii = 1:366, iii = ii-win:ii+win; iii = intersect(iii,1:366); t = x(iii,:); xmn(ii) = nanmean(t(:)); xstd(ii) = nanstd(t(:)); end;
iwin = win/2:win/2:366;

figure, set(gcf, 'position', [520 58 407 740])
subplot(3,1,2)
plot(yd(iwin), totalCmn(iwin), 'b', 'linewidth', 2), hold on
plot(yd(iwin), totalCmn(iwin)-totalCstd(iwin), ':', 'linewidth', 1)
plot(yd(iwin), totalCmn(iwin)+totalCstd(iwin), ':', 'linewidth', 1)
ylim([0 140]), text(20, 120, 'b', 'fontsize', 16)
ylabel('Phyto C (  \mug mL^{-1})', 'fontsize', 14)
datetick('x', 3), set(gca, 'xticklabel', [])
pos2 = get(gca, 'position'); pos2([1:3]) = pos2([1:3]).*[1.4 1.16 .8];
set(gca, 'position', pos2)

propC = sizefracC./repmat(totalC, 1,3);
%ii = find(~isnan(totalC)); propC = propC(ii,:); yd_propC = yd(ii);
[ propCmn(:,1), propCstd(:,1) ] = smoothed_climatology( propC(:,1) , win);
[ propCmn(:,2), propCstd(:,2) ] = smoothed_climatology( propC(:,2) , win);
[ propCmn(:,3), propCstd(:,3) ] = smoothed_climatology( propC(:,3) , win);

subplot(3,1,3)
plot(yd(iwin), propCmn(iwin,:), 'linewidth', 2), hold on
ch = get(gca, 'children'); set(ch(2), 'color', 'g')
datetick('x', 3)
ylabel('Phyto C fraction', 'fontsize', 14)
lh = legend('pico, < 2\mum', 'nano, 2-20 \mum', 'micro >20 \mum'); %, 'location', 'north');
ylim([0 1]), set(lh, 'box', 'off'); text(20, .85, 'c', 'fontsize', 16)
pos3 = get(gca, 'position'); pos3([1:3]) = pos3([1:3]).*[1.4 2.2 .8];
set(gca, 'position', pos3)
posl = get(lh, 'position'); posl(2) = posl(2)*1.04;
set(lh, 'position', posl)

load c:\work\mvco\discrete_chl\chlatASIT_fluorometric.mat
[ Chlmdate_mat, Chl_mat, Chlyearlist, yd ] = timeseries2ydmat( FL_matdate, FL_chl );
[ Chlmn(:,1), Chlstd(:,1) ] = smoothed_climatology( Chl_mat , win);
subplot(3,1,1)
plot(yd(iwin), Chlmn(iwin), 'linewidth', 2)
hold on
plot(yd(iwin), Chlmn(iwin)+Chlstd(iwin),':', 'linewidth', 1)
plot(yd(iwin), Chlmn(iwin)-Chlstd(iwin),':', 'linewidth', 1)
ylabel('Chl (  \mug mL^{-1})', 'fontsize', 14)
datetick('x', 3), set(gca, 'xticklabel', [])
ylim([0 8]), text(20, 7, 'a', 'fontsize', 16)
pos1 = get(gca, 'position'); pos1([1,3]) = pos1([1,3]).*[1.4 .8];
set(gca, 'position', pos1)


c = strmatch('Guinardia', classes, 'exact');
ii = find(~isnan(C_day_mat(:,c)));
figure
ph = plotyy(mdate(:), synCperml(:), Cmdate_day(ii), C_day_mat(ii,c));
set(ph, 'xlim', datenum(['1-0-2006'; '5-1-2012']))
datetick('x', 'keeplimits')
set(ph(2), 'xtick', get(ph(1), 'xtick'), 'xticklabel', [], 'ylim', [0 60], 'ytick', [0 30 60])
set(ph, 'linewidth', 2, 'fontsize', 14)
set(get(ph(1), 'children'), 'color', 'b', 'linewidth', 2)
set(get(ph(2), 'children'), 'color', 'r', 'linewidth', 2)
set(gca, 'xgrid', 'on')
ylabel('\itSynechococcus\rm (\mugC mL^{-1})', 'fontsize', 14)
%set(get(ph(2), 'ylabel'), 'string',  [class_label{c} '\rmbiovolume ( \mum^3 mL^{-1})'], 'fontsize', 14, 'color', 'r')
set(get(ph(2), 'ylabel'), 'string',  '\itG. delicatula \rm ( \mugC mL^{-1})', 'fontsize', 14, 'color', 'r')
set(ph(2), 'ycolor', 'r')
set(gcf, 'position', [ 520   511   698   287])


load C:\work\mvco\VGPM\carbon
win = 20;
iwin = win/2:win/2:366;
mvco_carbon = squeeze(nanmean(carbon(5:6,6,:),1));
shelf_carbon = squeeze(carbon(12,6,:));
[ mdate_mat, Carbon_mat, yearlist, yd ] = timeseries2ydmat( startday',  mvco_carbon); 
[ Cmn, Cstd ] = smoothed_climatology( Carbon_mat , win);
[ mdate_mat, Carbon_shelf_mat, yearlist, yd ] = timeseries2ydmat( startday',  shelf_carbon); 
[ C_shelf_mn, C_shelf_std ] = smoothed_climatology( Carbon_shelf_mat , win);

figure, set(gcf, 'position', [   520   485   431   313])
plot(yd(iwin), totalCmn(iwin), 'b', 'linewidth', 3), hold on
%plot(yd(4:8:end), t(1:8:end), '-')
plot(yd(iwin), Cmn(iwin), 'r', 'linewidth', 3)
plot(yd(iwin), C_shelf_mn(iwin), 'g', 'linewidth', 3)
lh = legend('MVCO in situ', 'MVCO MODIS', 'Mid-shelf MODIS', 'location','northwest');
ylim([0 175])
set(lh, 'fontsize', 12, 'box', 'off'), set(gca, 'fontsize', 14)
ylabel('Phytoplankton carbon (mg m  ^{-3})', 'fontsize', 14)
datetick('x', 3)

figure, set(gcf, 'position', [   520   485   431   313])
plot(yd(iwin), totalCmn(iwin), 'b', 'linewidth', 3), hold on
%plot(yd(4:8:end), t(1:8:end), '-')
plot(yd(iwin), Cmn(iwin), 'r', 'linewidth', 3)
lh = legend('MVCO in situ', 'MVCO MODIS', 'location','northwest');
ylim([0 175])
set(lh, 'fontsize', 12, 'box', 'off'), set(gca, 'fontsize', 14)
ylabel('Phytoplankton carbon (mg m  ^{-3})', 'fontsize', 14)
datetick('x', 3)

figure
[ Cdiatom_mdate_mat, Cdiatom_mat, yearlist, yd ] = timeseries2ydmat( Cmdate_day, C_diatom );
[ xmean, xstd ] = smoothed_climatology_median( Cdiatom_mat , 30);
plot(1:366, smooth(xmean,10), 'r-', 'linewidth', 3)
datetick('x', 3)
ylabel('Diatoms (mgC m  ^{-3})', 'fontsize', 14)
set(gca, 'fontsize', 14)