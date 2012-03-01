load '\\raspberry\d_work\ifcb1\ifcb_data_mvco_jun06\manual_fromClass\summary\count_biovol_manual_04Feb2012_day'
ii = find(floor(matdate_bin) == datenum('2-9-2010')); %skip this day with one partial sample
classbiovol_bin(ii,:) = []; classcount_bin(ii,:) = []; ml_analyzed_mat_bin(ii,:) = []; matdate_bin(ii) = [];

class_dino = {'Ceratium' 'dino30' 'Dinophysis' 'Gyrodinium' 'Prorocentrum' 'Gonyaulax'};
class_nonphyto = {'Thalassiosira_dirty' 'bad' 'ciliate' 'detritus' 'not_ciliate' 'ciliate_mix' 'tintinnid' 'Myrionecta' 'Laboea'};
class_mix = {'mix' 'clusterflagellate' 'crypto' 'Euglena' 'flagellate' 'kiteflagellates' 'Phaeocystis' 'Pyramimonas' 'roundCell' 'mix_elongated'};
class_diatom = {'Asterionellopsis' 'Cerataulina' 'Chaetoceros' 'Corethron' 'Coscinodiscus' 'Cylindrotheca' 'DactFragCerataul' 'Dactyliosolen'... 
    'Ditylum' 'Ephemera' 'Eucampia' 'Guinardia' 'Guinardia_flaccida' 'Guinardia_striata' 'Hemiaulus' 'Lauderia' 'Leptocylindrus' 'Licmophora'...
    'Odontella' 'Paralia' 'Pleurosigma' 'Pseudonitzschia' 'Rhizosolenia' 'Skeletonema' 'Stephanopyxis' 'Thalassionema' 'Thalassiosira' 'pennate'};
class_ciliate = {'ciliate' 'ciliate_mix' 'tintinnid' 'Myrionecta' 'Laboea'};
%skip: 'Eucampia_groenlandica' 'Tropidoneis' 'dino10'
%'other' 'bad'
[~,ind_diatoms] = intersect(class2use, class_diatom);
[~,ind_dino] = intersect(class2use, class_dino);
[~,ind_mix] = intersect(class2use, class_mix);
[~,ind_ciliate] = intersect(class2use, class_ciliate); ind_ciliate = sort(ind_ciliate);

class_label = class2use;
class_label(strmatch('Leptocylindrus', class_label, 'exact')) = {'\itLeptocylindrus \rmspp.'};
class_label(strmatch('Guinardia', class_label, 'exact')) = {'\itGuinardia delicatula'};
class_label(strmatch('Rhizosolenia', class_label, 'exact')) = {'\itRhizosolenia \rmspp.'};
class_label(strmatch('Chaetoceros', class_label, 'exact')) = {'\itChaetoceros \rmspp.'};
class_label(strmatch('Eucampia_groenlandica', class_label, 'exact')) = {'\itEucampia groenlandica'};
class_label(strmatch('Thalassiosira', class_label, 'exact')) = {'\itThalassiosira \rmspp.'};
class_label(strmatch('DactFragCerataul', class_label, 'exact')) = {'\itDactyliosolen fragilissimus'};
class_label(strmatch('Asterionellopsis', class_label, 'exact')) = {'\itAsterionellopsis glacialis'};
class_label(strmatch('Skeletonema', class_label, 'exact')) = {'\itSkeletonema \rmspp.'};
class_label(strmatch('Ditylum', class_label, 'exact')) = {'\itDitylum brightwellii'};
class_label(strmatch('Thalassionema', class_label, 'exact')) = {'\itThalassionema \rmspp.'};
class_label(strmatch('Dactyliosolen', class_label, 'exact')) = {'\itDactyliosolen blavyanus'};
class_label(strmatch('Corethron', class_label, 'exact')) = {'\itCorethron hystrix'};
class_label(strmatch('Guinardia_striata', class_label, 'exact')) = {'\itGuinardia striata'};
class_label(strmatch('Cylindrotheca', class_label, 'exact')) = {'\itCylindrotheca \rmspp.'};
class_label(strmatch('Pleurosigma', class_label, 'exact')) = {'\itPleurosigma \rmspp.'};
class_label(strmatch('Pseudonitzschia', class_label, 'exact')) = {'\itPseudonitzschia \rmspp.'};
class_label(strmatch('Guinardia_flaccida', class_label, 'exact')) = {'\itGuinardia flaccida'};
class_label(strmatch('Ephemera', class_label, 'exact')) = {'\itEphemera \rmspp.'};
class_label(strmatch('Eucampia', class_label, 'exact')) = {'\itEucampia cornuta'};
class_label(strmatch('Ephemera', class_label, 'exact')) = {'\itEphemera \rmspp.'};
class_label(strmatch('pennate', class_label, 'exact')) = {'pennate, misc.'};
class_label(strmatch('Lauderia', class_label, 'exact')) = {'\itLauderia annulata'};
class_label(strmatch('Licmophora', class_label, 'exact')) = {'\itLicmophora \rmspp.'};
class_label(strmatch('Stephanopyxis', class_label, 'exact')) = {'\itStephanopyxis \rmspp.'};
class_label(strmatch('Cerataulina', class_label, 'exact')) = {'\itCerataulina pelagica'};
class_label(strmatch('Odontella', class_label, 'exact')) = {'\itOdontella \rmspp.'};
class_label(strmatch('Coscinodiscus', class_label, 'exact')) = {'\itCoscinodiscus \rmspp.'};
class_label(strmatch('Paralia', class_label, 'exact')) = {'\itParalia sulcata'};


yd_ifcb = datevec(matdate_bin);
yd_ifcb = matdate_bin-datenum(yd_ifcb(:,1),0,0);

x = sum(classbiovol_bin(:,ind_diatoms)./ml_analyzed_mat_bin(:,ind_diatoms),2); indall = find(~isnan(x));
x = classbiovol_bin(indall,ind_diatoms)./ml_analyzed_mat_bin(indall,ind_diatoms); %class specific biomass/mL for cases with all diatom classes counted
[~, cind] = sort(sum(x), 'descend'); %rank order biomass

x = classbiovol_bin(:,ind_diatoms)./ml_analyzed_mat_bin(:,ind_diatoms);
dv = datevec(matdate_bin);
yd = (1:366)';
year_ifcb = (2006:2011);
mdate_year = datenum(year_ifcb,0,0);
mdate = repmat(yd,1,length(year_ifcb))+repmat(mdate_year,length(yd),1);
for count = 1:length(year_ifcb),    
    iii = find(dv(:,1) == year_ifcb(count));
    for day = 1:366,
        ii = find(floor(yd_ifcb(iii)) == day);
        Dallday(day,count,:) = nanmean(x(iii(ii),:),1);
    end;
end;
Dallmean = squeeze(nanmean(Dallday,2));
for count = 1:length(ind_diatoms),
    Dallmean_sm(:,count) = smooth(Dallmean(:,count),10);
end;
for count = 1:length(year_ifcb),
    Dallanom_sm(:,count,:) = squeeze(Dallday(:,count,:)) - Dallmean_sm;
end;

x = classbiovol_bin(:,ind_ciliate)./ml_analyzed_mat_bin(:,ind_ciliate);
%x = classcount_bin(:,ind_ciliate)./ml_analyzed_mat_bin(:,ind_ciliate);
for count = 1:length(year_ifcb),    
    iii = find(dv(:,1) == year_ifcb(count));
    for day = 1:366,
        ii = find(floor(yd_ifcb(iii)) == day);
        Callday(day,count,:) = nanmean(x(iii(ii),:),1);
    end;
end;
Callmean = squeeze(nanmean(Callday,2));
for count = 1:length(ind_ciliate),
    Callmean_sm(:,count) = smooth(Callmean(:,count),10);
end;
for count = 1:length(year_ifcb),
    Callanom_sm(:,count,:) = squeeze(Callday(:,count,:)) - Callmean_sm;
end;

figure
for c = 1:length(ind_ciliate),
    subplot(5,1,c)
    plot(yd, squeeze(Callday(:,:,c))/1e6, '.k') 
    hold on
    plot(yd, Callmean_sm(:,c)/1e6, '-', 'linewidth', 2)
    title(class2use(ind_ciliate(c)), 'interpreter', 'none')
    datetick('x', 3), set(gca, 'fontsize', 14)
end;
ylabel('Biovolume (mm^3 mL^{-1})', 'fontsize', 16)

load c:\work\mvco\otherData\other03_04
load c:\work\mvco\otherData\other05
load c:\work\mvco\otherData\other06
load c:\work\mvco\otherData\other07
load c:\work\mvco\otherData\other08
load c:\work\mvco\otherData\other09
load c:\work\mvco\otherData\other10
load c:\work\mvco\otherData\other11

yd_ocn2003 = [yd_ocn2003; yd_seacat2003];
Temp2003 = [Temp2003; temp_seacat2003];
yd_ocn2004 = [yd_ocn2004; yd_seacat2004];
Temp2004 = [Temp2004; temp_seacat2004];

yearall = (2003:2011);
Tday = NaN(length(yd),length(yearall));
for count = 1:length(yearall),    
    eval(['yd_ocn = yd_ocn' num2str(yearall(count)) ';'])
    eval(['Temp = Temp' num2str(yearall(count)) ';'])
    for day = 1:366,
        ii = find(floor(yd_ocn) == day);
        Tday(day,count) = nanmean(Temp(ii));
    end;
end;
Tmean_syn = nanmean(Tday,2);
Tanom_fcb = Tday - repmat(Tmean_syn,1,length(yearall));
[~,~,ii] = intersect(year_ifcb,yearall);
Tmean = nanmean(Tday(:,ii),2);
Tanom_ifcb = Tday(:,ii) - repmat(Tmean,1,length(year_ifcb));

Wday = NaN(length(yd),length(yearall));
for count = 1:length(yearall),    
    eval(['yd_met = yd_met' num2str(yearall(count)) ';'])
    eval(['Wspd = Wspd' num2str(yearall(count)) ';'])
    for day = 1:366,
        ii = find(floor(yd_met) == day);
        Wday(day,count) = nanmean(Wspd(ii));
    end;
end;
Wmean_syn = nanmean(Wday,2);
Wanom_fcb = Wday - repmat(Wmean_syn,1,length(yearall));
[~,~,ii] = intersect(year_ifcb,yearall);
Wmean = nanmean(Wday(:,ii),2);
Wanom_ifcb = Wday(:,ii) - repmat(Wmean,1,length(year_ifcb));

clear Temp* Saln* v* Solar* Daily* yd_ocn* yd_adcp* yd_met* yd_seacat* temp* saln* mdate_seacat*

load c:\work\mvco\carbon\conc_summary_fcb
mdate_year = datenum(yearall,0,0);
mdate = repmat(yd_fcb,1,length(yearall))+repmat(mdate_year,length(yd_fcb),1);
Synmean = nanmean(log10(synperml),2);
Synanom = log10(synperml) - repmat(Synmean,1,length(yearall));
Picoeukmean = nanmean(log10(picoeukperml),2);
Picoeukanom = log10(picoeukperml) - repmat(Picoeukmean,1,length(yearall));

for classnum = 1:0, %length(ind_diatoms),
    %xanom = Tanom_ifcb;
    xanom = Wanom_ifcb;
    yanom = Dallanom_sm(:,:,classnum);
    subplotwidth = 4;
    month_bins = (1:12)';
    [r(classnum,:),slope(classnum,:),n(classnum,:),p(classnum,:),r_sig(classnum,:),slope_sig(classnum,:)] = anomaly_corr(xanom, yanom, yd, month_bins, subplotwidth);
    subplot(3,4,10)
    %xlabel('Temperature anomaly ( \circC)', 'fontsize', 14)
    xlabel('Wind speed anomaly ()', 'fontsize', 14)
    subplot(3,4,5)
    ylabel([class2use{ind_diatoms(classnum)} ' anomaly (biovol mL ^{-1})'], 'fontsize', 14)
end;

classnum = 9;
xanom = Tanom_ifcb;
yanom = Dallanom_sm(:,:,classnum);
subplotwidth = 4;
month_bins = [1 4 7 12]';
[~] = anomaly_corr(xanom, yanom, yd, month_bins, subplotwidth);
orient tall
subplot(1,4,1)
xlabel('Temperature anomaly (relative)', 'fontsize', 16)
subplot(1,4,1)
ylabel(['\it' class2use{ind_diatoms(classnum)} '\rm anomaly (biovolume, relative)'], 'fontsize', 14)

for classnum = 1:0, %length(ind_ciliate),
    xanom = Tanom_ifcb;
    %xanom = Wanom_ifcb;
    yanom = Callanom_sm(:,:,classnum);
    subplotwidth = 4;
    month_bins = (1:12)';
    [r(classnum,:),slope(classnum,:),n(classnum,:),p(classnum,:),r_sig(classnum,:),slope_sig(classnum,:)] = anomaly_corr(xanom, yanom, yd, month_bins, subplotwidth);
    subplot(3,4,10)
    xlabel('Temperature anomaly ( \circC)', 'fontsize', 14)
    %xlabel('Wind speed anomaly ()', 'fontsize', 14)
    subplot(3,4,5)
    ylabel([class2use{ind_ciliate(classnum)} ' anomaly (biovol mL ^{-1})'], 'fontsize', 14)
end;

xanom = Tanom_fcb;
yanom = Synanom;
subplotwidth = 4; month_bins = [14 7 12]';
subplotwidth = 3; month_bins = [11 12 1 2 ; 3 4 5 6; 7 8 9 10];
[r,slope,n,p,r_sig,slope_sig] = anomaly_corr(xanom, yanom, yd, month_bins, subplotwidth);
orient tall
subplot(1,subplotwidth,1)
xlabel('Temperature anomaly (relative)', 'fontsize', 16)
subplot(1,subplotwidth,1)
ylabel(['\itSynechococcus\rm anomaly (log10 mL{-1}, relative)'], 'fontsize', 14)

month_bins = (1:12)'; subplotwidth = 6; subplotheight = ceil(length(month_bins)/subplotwidth);
[rsyn,slope_syn,n_syn,p_syn,r_sig_syn,slope_sig_syn] = anomaly_corr(Tanom_fcb, Synanom, yd, month_bins, subplotwidth);
%subplot(subplotheight,subplotwidth,)
xlabel('Temperature anomaly (relative)', 'fontsize', 16)
subplot(subplotheight,subplotwidth,1)
ylabel(['\itSynechococcus\rm anomaly (log10 mL{-1}, relative)'], 'fontsize', 14)

month_bins = [4 7]'; subplotwidth = 2; subplotheight = ceil(length(month_bins)/subplotwidth);
[rsyn,slope_syn,n_syn,p_syn,r_sig_syn,slope_sig_syn] = anomaly_corr(Tanom_fcb, Synanom, yd, month_bins, subplotwidth);
%subplot(subplotheight,subplotwidth,)
xlabel('Temperature anomaly (relative)', 'fontsize', 12)
subplot(subplotheight,subplotwidth,1)
ylabel(['\itSynechococcus\rm anomaly (log10 mL{-1}, relative)'], 'fontsize', 12)
set(gca, 'fontsize', 12)

month_bins = (1:12)'; subplotwidth = 0;
[rsyn,slope_syn,n_syn,p_syn,r_sig_syn,slope_sig_syn] = anomaly_corr(Tanom_fcb, Synanom, yd, month_bins, subplotwidth);
figure
bar(month_bins, rsyn), hold on
ii = find(rsyn>0);
plot(month_bins(ii), r_sig_syn(ii)+.02,'r*')
ii = find(rsyn<0);
plot(month_bins(ii), r_sig_syn(ii)-.02,'r*')
ylim([-.6 1])
ylabel('Correlation coefficient', 'fontsize', 14)
xlim([0 13])
set(gca, 'xtick', 1:12, 'xticklabel', ['JFMAMJJASOND']')


classnum = 9;
xanom = Tanom_ifcb;
yanom = Dallanom_sm(:,:,classnum);
subplotwidth = 2;
month_bins = [12 1]';
[~] = anomaly_corr(xanom, yanom, yd, month_bins, subplotwidth);
orient tall
subplot(1,subplotwidth,2)
xlabel('Temperature anomaly (relative)', 'fontsize', 16)
subplot(1,subplotwidth,2)
ylabel(['\it' class2use{ind_diatoms(classnum)} '\rm anomaly (biovolume, relative)'], 'fontsize', 14)
%delete subplot 1 from above, edit anomaly_corr to stay on figure
month_bins = [1]';
[~] = anomaly_corr(Tanom_fcb, Synanom, yd, month_bins, subplotwidth);
subplot(1,subplotwidth,1)
ylabel(['\itSynechococcus\rm anomaly (log10 mL{-1}, relative)'], 'fontsize', 14)


%load c:\work\mvco\otherData\rsyn  %from anomalies.m
clear rsyn r_sig_syn
month_bins = (1:12)'; subplotwidth = 0;
[rsyn(:,1),slope_syn,n_syn,p_syn,r_sig_syn(:,1),slope_sig_syn] = anomaly_corr(Tanom_fcb, Synanom, yd, month_bins, subplotwidth);
[rpeuk(:,1),slope_syn,n_syn,p_syn,r_sig_peuk(:,1),slope_sig_syn] = anomaly_corr(Tanom_fcb, Picoeukanom, yd, month_bins, subplotwidth);
[rsyn(:,2),slope_syn,n_syn,p_syn,r_sig_syn(:,2),slope_sig] = anomaly_corr(Wanom_fcb, Synanom, yd, month_bins, subplotwidth);
[rpeuk(:,2),slope_syn,n_syn,p_syn,r_sig_peuk(:,2),slope_sig] = anomaly_corr(Wanom_fcb, Picoeukanom, yd, month_bins, subplotwidth);

for classnum = 1:length(ind_diatoms),
    xanom = Tanom_ifcb;
    yanom = Dallanom_sm(:,:,classnum);
    subplotwidth = 0;
    month_bins = (1:12)';
    [r1(classnum,:),slope1(classnum,:),n1(classnum,:),p1(classnum,:),r1_sig(classnum,:),slope1_sig(classnum,:)] = anomaly_corr(xanom, yanom, yd, month_bins, subplotwidth);
end;

for classnum = 1:length(ind_diatoms),
    xanom = Wanom_ifcb;
    yanom = Dallanom_sm(:,:,classnum);
    subplotwidth = 0;
    month_bins = (1:12)';
    [r2(classnum,:),slope2(classnum,:),n2(classnum,:),p2(classnum,:),r2_sig(classnum,:),slope2_sig(classnum,:)] = anomaly_corr(xanom, yanom, yd, month_bins, subplotwidth);
end;

r = [1 0 0];       %# start
w = [1 1 1];    %# middle
b = [0 0 1];       %# end
%# colormap of size 64-by-3, ranging from red -> white -> blue
c1 = zeros(32,3); c2 = zeros(32,3);
for i=1:3
    c1(:,i) = linspace(b(i), w(i), 32);
    c2(:,i) = linspace(w(i), r(i), 32);
end
cmap = [c1(1:end-1,:);c2]; %colormap

figure
pcolor([[r_sig_syn(:,1) r1_sig(cind(1:15),:)'; NaN(1,16)] NaN(13,1)]'), caxis([-1 1])
set(gca, 'ydir', 'reverse')
colormap(cmap)
set(gca, 'xtick', (1:12)+.5, 'xticklabel', {'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'}, 'tickdir', 'out')
set(gca, 'ytick', (1:16)+.5,'yticklabel', []); %class_label(ind_diatoms(cind(1:15))))
th = text(.5*ones(1,16),(1:16)+.5, ['\itSynechococcus\rm spp.' class_label(ind_diatoms(cind(1:15)))], 'horizontalAlignment', 'right');
colorbar
set(gca, 'position', [0.4 0.1 0.45 0.65])
%title('Slope of relation with temperature anomaly')
title('Correlation with temperature anomaly')

%load c:\work\mvco\otherData\rpeuk
figure
t = [[r_sig_syn(:,1) r_sig_peuk(:,1) NaN.*rpeuk(:,1) r1_sig(cind(1:15),:)'; NaN(1,18)] NaN(13,1)]';
pcolor(t), caxis([-1 1])
set(gca, 'ydir', 'reverse')
colormap(cmap)
set(gca, 'xtick', (1:12)+.5, 'xticklabel', {'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'}, 'tickdir', 'out')
set(gca, 'ytick', (1:16)+.5,'yticklabel', []); %class_label(ind_diatoms(cind(1:15))))
th = text(.5*ones(1,19),(0:18)+.5, ['\bfPICOPLANKTON                 ' '\itSynechococcus\rm spp.' 'Picoeukaryotes' '\bfDIATOMS                               ' class_label(ind_diatoms(cind(1:15)))], 'horizontalAlignment', 'right');
colorbar
set(gca, 'position', [0.4 0.1 0.45 0.65])
title('Correlation with temperature anomaly')


figure
pcolor([[r_sig_syn(:,2) r2_sig(cind(1:15),:)'; NaN(1,16)] NaN(13,1)]'), caxis([-1 1])
set(gca, 'ydir', 'reverse')
colormap(cmap)
set(gca, 'xtick', (1:12)+.5, 'xticklabel', {'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'}, 'tickdir', 'out')
set(gca, 'ytick', (1:16)+.5,'yticklabel', []); %class_label(ind_diatoms(cind(1:15))))
th = text(.5*ones(1,16),(1:16)+.5, ['\itSynechococcus\rm spp.' class_label(ind_diatoms(cind(1:15)))], 'horizontalAlignment', 'right');
colorbar
set(gca, 'position', [0.4 0.1 0.45 0.65])
%title('Slope of relation with wind speed anomaly')
title('Correlation with wind speed anomaly')


figure
subplot(4,1,1), c =14; ii = find(~isnan(classbiovol_bin(:,c)));
plot(matdate_bin(ii), classbiovol_bin(ii,c)./ml_analyzed_mat_bin(ii,c)/1e6, '-k', 'linewidth', 2), datetick('x'), set(gca, 'xgrid', 'on'), title(class_label(c))
ylim([0 1.2])
subplot(4,1,2), c =10; ii = find(~isnan(classbiovol_bin(:,c)));
plot(matdate_bin(ii), classbiovol_bin(ii,c)./ml_analyzed_mat_bin(ii,c)/1e6, '-k', 'linewidth', 2), datetick('x'), set(gca, 'xgrid', 'on'), title(class_label(c))
subplot(4,1,3), c =4; ii = find(~isnan(classbiovol_bin(:,c)));
plot(matdate_bin(ii), classbiovol_bin(ii,c)./ml_analyzed_mat_bin(ii,c)/1e6, '-k', 'linewidth', 2), datetick('x'), set(gca, 'xgrid', 'on'), title(class_label(c))
subplot(4,1,4), c =51; ii = find(~isnan(classbiovol_bin(:,c)));
plot(matdate_bin(ii), classbiovol_bin(ii,c)./ml_analyzed_mat_bin(ii,c)/1e6, '-k', 'linewidth', 2), datetick('x'), set(gca, 'xgrid', 'on'), title(class_label(c))
ylabel('Biovolume (mm^3 mL^{-1})', 'fontsize', 16)


figure
% subplot(3,1,1)
% x = sum(classbiovol_bin(:,ind_diatoms)./ml_analyzed_mat_bin(:,ind_diatoms),2); indall = find(~isnan(x));
% x = classbiovol_bin(indall,ind_diatoms)./ml_analyzed_mat_bin(indall,ind_diatoms); %class specific biomass/mL for cases with all diatom classes counted
% plot(matdate_bin(indall), sum(x,2), 'linewidth', 2)
% datetick('x')
% set(gca, 'xgrid', 'on', 'xticklabel', [], 'linewidth', 2)
% ylabel({'Diatom biovolume' '( \mum^3 mL^{-1})'}, 'fontsize', 14)
% set(gco, 'color', 'b')
%subplot(3,1,2)
subplot(2,1,1)
c =14; ii = find(~isnan(classbiovol_bin(:,c)));
plot(matdate_bin(ii), classbiovol_bin(ii,c)./ml_analyzed_mat_bin(ii,c), '-b', 'linewidth', 2), 
ylabel([class_label(c) '\rmbiovolume ( \mum^3 mL^{-1})'], 'fontsize', 14)
datetick('x')
set(gca, 'xgrid', 'on', 'xticklabel', [], 'linewidth', 2)
ylim([0 1.2e6])
subplot(2,1,2)
mdate_syn = datenum(repmat(yearall,length(yd_fcb),1),0,repmat(yd_fcb',length(yearall),1)');
hold on, plot(mdate_syn(:), synperml(:), 'linewidth', 2)
xlim(datenum(['1-0-2006'; '1-1-2012'])), ylim([0 3e5])
datetick('x', 'keeplimits'), set(gca, 'xgrid', 'on', 'linewidth', 2, 'box', 'on')
ylabel('\itSynechococcus\rm (mL^{-1})', 'fontsize', 14)

figure
ph = plotyy(mdate_syn(:), synperml(:), matdate_bin(ii), classbiovol_bin(ii,c)./ml_analyzed_mat_bin(ii,c));
set(ph, 'xlim', datenum(['1-0-2006'; '1-1-2012']))
datetick('x', 'keeplimits')
set(ph(2), 'xtick', get(ph(1), 'xtick'), 'xticklabel', [])
set(ph, 'linewidth', 2, 'fontsize', 14)
set(get(ph(1), 'children'), 'color', 'b', 'linewidth', 2)
set(get(ph(2), 'children'), 'color', 'r', 'linewidth', 2)
set(gca, 'xgrid', 'on')
ylabel('\itSynechococcus\rm (mL^{-1})', 'fontsize', 14)
%set(get(ph(2), 'ylabel'), 'string',  [class_label{c} '\rmbiovolume ( \mum^3 mL^{-1})'], 'fontsize', 14, 'color', 'r')
set(get(ph(2), 'ylabel'), 'string',  '\itG. delicatula \rmbiovolume ( \mum^3 mL^{-1})', 'fontsize', 14, 'color', 'r')
set(ph(2), 'ycolor', 'r')

figure
subplot(2,1,1), hold on
c =14;
y = squeeze(Dallday(:,:,c));
cstr = 'bgrcmk';
for count = 1:length(year_ifcb),
    ii = find(~isnan(y(:,count)));
    plot(yd(ii), y(ii,count), [cstr(count) '-'], 'linewidth', 2)
end;
ylabel([class_label(c) '\rmbiovolume ( \mum^3 mL^{-1})'], 'fontsize', 14)
datetick('x')
set(gca, 'xgrid', 'on', 'xticklabel', [], 'linewidth', 2)
ylim([0 1.2e6])
subplot(2,1,2)
mdate_syn = datenum(repmat(yearall,length(yd_fcb),1),0,repmat(yd_fcb',length(yearall),1)');
hold on, plot(mdate_syn(:), synperml(:), 'linewidth', 2)
xlim(datenum(['1-0-2006'; '1-1-2012'])), ylim([0 3e5])
datetick('x', 'keeplimits'), set(gca, 'xgrid', 'on', 'linewidth', 2, 'box', 'on')
ylabel('\itSynechococcus\rm (mL^{-1})', 'fontsize', 14)

figure
ii = [2 5];
for c = 1:length(ii),
    subplot(2,1,c)
    plot(yd, squeeze(Callday(:,:,ii(c)))/1e6, '.k') 
    hold on
    plot(yd, Callmean_sm(:,ii(c))/1e6, '-', 'linewidth', 2)
    title(class2use(ind_ciliate(ii(c))), 'fontsize', 14)
    datetick('x', 3), set(gca, 'fontsize', 14)
    set(gca, 'linewidth', 2)
    ylim([0 .15])
end;
ylim([0 .12])
ylabel('Biovolume (mm^3 mL^{-1})', 'fontsize', 16)
subplot(2,1,1), title('Mixed ciliates')