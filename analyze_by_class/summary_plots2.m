load '\\raspberry\d_work\ifcb1\ifcb_data_mvco_jun06\manual_fromClass\summary\count_biovol_manual_27Jan2012_day'
class_dino = {'Ceratium' 'dino30' 'Dinophysis' 'Gyrodinium' 'Prorocentrum' 'Gonyaulax'};
class_nonphyto = {'Thalassiosira_dirty' 'bad' 'ciliate' 'detritus' 'not_ciliate' 'ciliate_mix' 'tintinnid' 'Myrionecta' 'Laboea'};
class_mix = {'mix' 'clusterflagellate' 'crypto' 'Euglena' 'flagellate' 'kiteflagellates' 'Phaeocystis' 'Pyramimonas' 'roundCell' 'mix_elongated'};
class_diatom = {'Asterionellopsis' 'Cerataulina' 'Chaetoceros' 'Corethron' 'Coscinodiscus' 'Cylindrotheca' 'DactFragCerataul' 'Dactyliosolen'... 
    'Ditylum' 'Ephemera' 'Eucampia' 'Guinardia' 'Guinardia_flaccida' 'Guinardia_striata' 'Hemiaulus' 'Lauderia' 'Leptocylindrus' 'Licmophora'...
    'Odontella' 'Paralia' 'Pleurosigma' 'Pseudonitzschia' 'Rhizosolenia' 'Skeletonema' 'Stephanopyxis' 'Thalassionema' 'Thalassiosira' 'pennate'};
class_ciliate = {};
%skip: 'Eucampia_groenlandica' 'Tropidoneis' 'dino10'
%'other' 'bad'
[~,ind_diatoms] = intersect(class2use, class_diatom);
[~,ind_dino] = intersect(class2use, class_dino);
[~,ind_mix] = intersect(class2use, class_mix);

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
year = (2006:2011);
mdate_year = datenum(year,0,0);
mdate = repmat(yd,1,length(year))+repmat(mdate_year,length(yd),1);
Dday = NaN(length(yd),length(year),length(ind_diatoms));
Dday = NaN(length(yd),length(year),length(25));
for count = 1:length(year),    
    iii = find(dv(:,1) == year(count));
    for day = 1:366,
        ii = find(floor(yd_ifcb(iii)) == day);
        Dallday(day,count,:) = nanmean(x(iii(ii),:),1);
    end;
end;
Dallmean = squeeze(nanmean(Dallday,2));
%Danom = Dday - repmat(Dmean,1,length(year));
for count = 1:length(ind_diatoms),
    Dallmean_sm(:,count) = smooth(Dallmean(:,count),10);
end;
for count = 1:length(year),
    Dallanom_sm(:,count,:) = squeeze(Dallday(:,count,:)) - Dallmean_sm;
end;

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

Tday = NaN(length(yd),length(year));
for count = 1:length(year),    
    eval(['yd_ocn = yd_ocn' num2str(year(count)) ';'])
    eval(['Temp = Temp' num2str(year(count)) ';'])
    for day = 1:366,
        ii = find(floor(yd_ocn) == day);
        Tday(day,count) = nanmean(Temp(ii));
    end;
end;
Tmean = nanmean(Tday,2);
Tanom = Tday - repmat(Tmean,1,length(year));

Wday = NaN(length(yd),length(year));
for count = 1:length(year),    
    eval(['yd_met = yd_met' num2str(year(count)) ';'])
    eval(['Wspd = Wspd' num2str(year(count)) ';'])
    for day = 1:366,
        ii = find(floor(yd_met) == day);
        Wday(day,count) = nanmean(Wspd(ii));
    end;
end;
Wmean = nanmean(Wday,2);
Wanom = Wday - repmat(Wmean,1,length(year));

clear Temp* Saln* v* Solar* Daily* yd_ocn* yd_adcp* yd_met* yd_seacat* temp* saln* mdate_seacat*

classnum = 9;
xanom = Tanom;
yanom = Dallanom_sm(:,:,classnum);
subplotwidth = 3;
month_bins = [11 12 1 2 ; 3 4 5 6; 7 8 9 10];
month_bins = (1:12)';
[r,slope,n,p,r_sig,slope_sig] = anomaly_corr(xanom, yanom, yd, month_bins, subplotwidth);
subplot(3,4,10)
xlabel('Temperature anomaly ( \circC)', 'fontsize', 14)
subplot(3,4,5)
ylabel([class2use{ind_diatoms(classnum)} ' anomaly (biovol mL ^{-1})'], 'fontsize', 14)



dv = datevec(yd);
figure
for classnum = 1:length(ind_diatoms),
%figure(classnum)
y = Dallanom_sm(:,:,classnum);
stdy = nanstd(y(:));
maxy = max(y(:))./stdy;
stdx = nanstd(Tanom(:));
for c = 1:12, 
    subplot(3,4,c)
    ii = find(dv(:,2) == c); 
    x = Tanom(ii,:)./stdx; y = Dallanom_sm(ii,:,classnum)./stdy; 
    plot(x(:),y(:),'.b');
    title(datestr([2000 c 1 0 0 0],3)), axis([-5 5 maxy.*[-1 1]]); 
    ii = find(~isnan(x) & ~isnan(y));
    [m,b,r,sm] = lsqfitgm(x(ii),y(ii));
    yfit2 = polyval([m b],x(ii));
    hold on
    rsq(c,classnum) = r.^2; slope(c,classnum) = m; std_slope(c,classnum) = sm; r1(c,classnum) = r;
    axis square
    n(c,classnum) = length(ii);
    N = n(c,classnum);
    t = abs(r).*sqrt((N-2)./(1-r.^2));
    p(c) = 1-tcdf(t,N-2);
    if p(c) < .05, %significant cases
        plot(x(ii),yfit2, 'r-')
        text(-4,-maxy*.85,['r^2 = ' num2str(r.^2,'%0.2f')], 'color', 'r')
    else
        plot(x(ii),yfit2, 'k:')
        text(-4,-maxy*.85,['r^2 = ' num2str(r.^2,'%0.2f')])
    end;
end;
orient tall
subplot(3,4,10)
xlabel('Temperature anomaly ( \circC)', 'fontsize', 14)
subplot(3,4,5)
ylabel([class2use{ind_diatoms(classnum)} ' anomaly (biovol mL ^{-1})'], 'fontsize', 14)
end;
r = sqrt(rsq);
t = r.*sqrt((n-2)./(1-rsq));
p = 1-tcdf(t,n-2);
sig = (p<.05);
slope_sig = slope.*sig;
slope_sig(slope_sig(:) == 0) = NaN;
r1_sig = r1.*sig;
r1_sig(r1_sig(:) == 0) = NaN;


dv = datevec(1:366);
figure
for classnum = 9, %1:length(ind_diatoms),
%figure(classnum)
y = Dallanom_sm(:,:,classnum);
stdy = nanstd(y(:));
maxy = max(y(:))./stdy;
stdx = nanstd(Tanom(:));
c_all = [1 4 7 12];
for count = 1:4,
    c = c_all(count);
    subplot(1,4,count)
    ii = find(dv(:,2) == c); 
    x = Tanom(ii,:)./stdx; y = Dallanom_sm(ii,:,classnum)./stdy; 
    plot(x(:),y(:),'*b');
    title(datestr([2000 c 1 0 0 0],3), 'fontsize', 16), axis([-5 5 maxy.*[-1 1]]); 
    ii = find(~isnan(x) & ~isnan(y));
    [m,b,r,sm] = lsqfitgm(x(ii),y(ii));
    yfit2 = polyval([m b],x(ii));
    hold on
    %rsq(c,classnum) = r.^2; slope(c,classnum) = m; std_slope(c,classnum) = sm; r1(c,classnum) = r;
    axis square
    N = length(ii);
    t = abs(r).*sqrt((N-2)./(1-r.^2));
    p = 1-tcdf(t,N-2);
    if p < .05, %significant cases
        plot(x(ii),yfit2, 'r-', 'linewidth', 2)
        text(-4,-maxy*.85,['r^2 = ' num2str(r.^2,'%0.2f')], 'color', 'r', 'fontsize', 16)
    else
        %plot(x(ii),yfit2, 'k:')
        %text(-4,-maxy*.85,['r^2 = ' num2str(r.^2,'%0.2f')])
    end;
    set(gca, 'fontsize', 16)
end;
orient tall
subplot(1,4,1)
xlabel('Temperature anomaly (relative)', 'fontsize', 16)
subplot(1,4,1)
ylabel(['\it' class2use{ind_diatoms(classnum)} '\rm anomaly (biovolume, relative)'], 'fontsize', 14)
end;




load c:\work\mvco\otherData\rsyn  %from anomalies.m

r = [1 0 0];       %# start
w = [1 1 1];    %# middle
b = [0 0 1];       %# end
%# colormap of size 64-by-3, ranging from red -> white -> blue
c1 = zeros(32,3); c2 = zeros(32,3);
for i=1:3
    c1(:,i) = linspace(b(i), w(i), 32);
    c2(:,i) = linspace(w(i), r(i), 32);
end
c = [c1(1:end-1,:);c2]; %colormap
figure
%pcolor([[slope_sig(:,cind(1:15)); NaN(1,15)] NaN(13,1)]'), caxis([-2 2])
pcolor([[rsyn(:,1) r1_sig(:,cind(1:15)); NaN(1,16)] NaN(13,1)]'), caxis([-1 1])
set(gca, 'ydir', 'reverse')
colormap(c)
set(gca, 'xtick', (1:12)+.5, 'xticklabel', {'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'}, 'tickdir', 'out')
set(gca, 'ytick', (1:16)+.5,'yticklabel', []); %class_label(ind_diatoms(cind(1:15))))
th = text(.5*ones(1,16),(1:16)+.5, ['\itSynechococcus\rm spp.' class_label(ind_diatoms(cind(1:15)))], 'horizontalAlignment', 'right');
colorbar
set(gca, 'position', [0.4 0.1 0.45 0.65])
%title('Slope of relation with temperature anomaly')
title('Correlation with temperature anomaly')

load c:\work\mvco\otherData\rpeuk
figure
t = [[rsyn(:,1) rpeuk(:,1) NaN.*rpeuk(:,1) r1_sig(:,cind(1:15)); NaN(1,18)] NaN(13,1)]';
pcolor(t), caxis([-1 1])
set(gca, 'ydir', 'reverse')
colormap(c)
set(gca, 'xtick', (1:12)+.5, 'xticklabel', {'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'}, 'tickdir', 'out')
set(gca, 'ytick', (1:16)+.5,'yticklabel', []); %class_label(ind_diatoms(cind(1:15))))
th = text(.5*ones(1,19),(0:18)+.5, ['\bfPICOPLANKTON                 ' '\itSynechococcus\rm spp.' 'Picoeukaryotes' '\bfDIATOMS                               ' class_label(ind_diatoms(cind(1:15)))], 'horizontalAlignment', 'right');
colorbar
set(gca, 'position', [0.4 0.1 0.45 0.65])
title('Correlation with temperature anomaly')

figure, bar([sum(r1_sig(:,cind(1:15))' > 0); -sum(r1_sig(:,cind(1:15))' < 0)]')

figure
for classnum = 1:length(ind_diatoms),
%figure(classnum)
y = Dallanom_sm(:,:,classnum);
stdy = nanstd(y(:));
maxy = max(y(:))./stdy;
stdx = nanstd(Wanom(:));
for c = 1:12, 
    subplot(3,4,c)
    ii = find(dv(:,2) == c); 
    x = Wanom(ii,:)./stdx; y = Dallanom_sm(ii,:,classnum)./stdy; 
    plot(x(:),y(:),'.b');
    title(datestr([2000 c 1 0 0 0],3)), axis([-5 5 maxy.*[-1 1]]); 
    ii = find(~isnan(x) & ~isnan(y));
    [m,b,r,sm] = lsqfitgm(x(ii),y(ii));
    yfit2 = polyval([m b],x(ii));
    hold on
    rsq(c,classnum) = r.^2; slope(c,classnum) = m; std_slope(c,classnum) = sm; r1(c,classnum) = r;
    axis square
    n(c,classnum) = length(ii);
    N = n(c,classnum);
    t = abs(r).*sqrt((N-2)./(1-r.^2));
    p = 1-tcdf(t,N-2);
    if p < .05, %significant cases
        plot(x(ii),yfit2, 'r-')
        text(-4,-maxy*.85,['r^2 = ' num2str(r.^2,'%0.2f')], 'color', 'r')
    else
        plot(x(ii),yfit2, 'k:')
        text(-4,-maxy*.85,['r^2 = ' num2str(r.^2,'%0.2f')])
    end;
end;
orient tall
subplot(3,4,10)
xlabel('Wind speed anomaly ()', 'fontsize', 14)
subplot(3,4,5)
ylabel([class2use{ind_diatoms(classnum)} ' anomaly (biovol mL ^{-1})'], 'fontsize', 14)
end;
r = sqrt(rsq);
t = r.*sqrt((n-2)./(1-rsq));
p = 1-tcdf(t,n-2);
sig = (p<.05);
slope_sig = slope.*sig;
slope_sig(slope_sig(:) == 0) = NaN;
r1_sig = r1.*sig;
r1_sig(r1_sig(:) == 0) = NaN;

r = [1 0 0];       %# start
w = [.9 .9 .9];    %# middle
w = [1 1 1];
b = [0 0 1];       %# end

%# colormap of size 64-by-3, ranging from red -> white -> blue
c1 = zeros(32,3); c2 = zeros(32,3);
for i=1:3
    c1(:,i) = linspace(b(i), w(i), 32);
    c2(:,i) = linspace(w(i), r(i), 32);
end
c = [c1(1:end-1,:);c2];
figure
%pcolor([[slope_sig(:,cind(1:15)); NaN(1,15)] NaN(13,1)]'), caxis([-2 2])
pcolor([[rsyn(:,2) r1_sig(:,cind(1:15)); NaN(1,16)] NaN(13,1)]'), caxis([-1 1])
set(gca, 'ydir', 'reverse')
colormap(c)
set(gca, 'xtick', (1:12)+.5, 'xticklabel', {'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'}, 'tickdir', 'out')
set(gca, 'ytick', (1:16)+.5,'yticklabel', []); %class_label(ind_diatoms(cind(1:15))))
th = text(.5*ones(1,16),(1:16)+.5, ['\itSynechococcus\rm spp.' class_label(ind_diatoms(cind(1:15)))], 'horizontalAlignment', 'right');
colorbar
set(gca, 'position', [0.4 0.1 0.45 0.65])
title('Slope of relation with wind speed anomaly')
title('Correlation with wind speed anomaly')

figure, bar([sum(r1_sig(:,cind(1:15))' > 0); -sum(r1_sig(:,cind(1:15))' < 0)]')


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

