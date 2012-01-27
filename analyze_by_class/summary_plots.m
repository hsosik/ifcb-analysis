load '\\raspberry\d_work\ifcb1\ifcb_data_mvco_jun06\manual_fromClass\summary\count_biovol_manual_21Jan2012_day'
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

yd_ifcb = datevec(matdate_bin);
yd_ifcb = matdate_bin-datenum(yd_ifcb(:,1),0,0);

figure
x = sum(classbiovol_bin(:,ind_diatoms)./ml_analyzed_mat_bin(:,ind_diatoms),2); ii = find(~isnan(x));
plot(matdate_bin(ii), x(ii), '.-')
datetick
hold on
for count = 1:length(ind_diatoms),
    ph = plot(matdate_bin(ii), classbiovol_bin(ii,ind_diatoms(count))./ml_analyzed_mat_bin(ii, ind_diatoms(count)), 'r');
    title(class2use(ind_diatoms(count)))
    pause
    delete(ph)
end;

x = sum(classbiovol_bin(:,ind_diatoms)./ml_analyzed_mat_bin(:,ind_diatoms),2); ii = find(~isnan(x));
dv = datevec(matdate_bin);
yd = (1:366)';
year = (2006:2011);
Dday = NaN(length(yd),length(year));
for count = 1:length(year),    
    iii = find(dv(:,1) == year(count));
    for day = 1:366,
        ii = find(floor(yd_ifcb(iii)) == day);
        Dday(day,count) = nanmean(x(iii(ii)));
    end;
end;
Dmean = nanmean(Dday,2);
Danom = Dday - repmat(Dmean,1,length(year));
Dmean_sm = smooth(Dmean,10);
Danom_sm = Dday - repmat(Dmean_sm,1,length(year));

mdate_year = datenum(year,0,0);
mdate = repmat(yd,1,length(year))+repmat(mdate_year,length(yd),1);

figure, hold on, for c = 1:6, ii = find(~isnan(Dday(:,c))); plot(yd(ii), Dday(ii,c), ['-' cstr(c)], 'linewidth', 2), end; legend(num2str(year')), datetick('x',3)

plot(mdate(:), Danom_sm(:), '.')
datetick('x')
set(gca, 'xgrid', 'on')
line(xlim, [0 0], 'color', 'k', 'linestyle', '--')

dv = datevec(1:366);
figure
y = Danom_sm;
stdy = nanstd(y(:));
maxy = max(y(:))./stdy;
for c = 1:12, 
    subplot(3,4,c)
    ii = find(dv(:,2) == c); 
    x = Tanom(ii,:); y = Danom_sm(ii,:)/stdy; 
    plot(x(:),y(:),'.b');
    title(datestr([2000 c 1 0 0 0],3)), axis([-5 5 maxy*[-1 1] ]); 
    ii = find(~isnan(x) & ~isnan(y));
        [m,b,r,sm] = lsqfitgm(x(ii),y(ii));
    %yfit = polyval(p,x(ii));
    yfit2 = polyval([m b],x(ii));
    hold on
    %plot(x(ii),yfit, 'g-')
    %r = corrcoef(x(ii),y(ii)); rsq = r(2).^2;
    rsq(c) = r.^2; slope(c) = m; std_slope(c) = sm;
    axis square
    n(c) = length(ii);
    N = n(c);
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
xlabel('Temperature anomaly ( \circC)', 'fontsize', 14)
subplot(3,4,5)
ylabel('Diatom anomaly (biovol mL ^{-1})', 'fontsize', 14)


x = classbiovol_bin(:,ind_diatoms)./ml_analyzed_mat_bin(:,ind_diatoms);
dv = datevec(matdate_bin);
yd = (1:366)';
year = (2006:2011);
mdate_year = datenum(year,0,0);
mdate = repmat(yd,1,length(year))+repmat(mdate_year,length(yd),1);
Dday = NaN(length(yd),length(year),length(ind_diatoms));
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

plot(mdate,Dallanom_sm(:,:,9), 'k.')
line(xlim, [0 0], 'color', 'k', 'linestyle', '--')
set(gca, 'xgrid', 'on')
xlim(datenum(['1-0-2007'; '1-0-2012']))
datetick('x', 'keeplimits')

dv = datevec(1:366);
for classnum = 1:length(ind_diatoms),
figure(classnum)
y = Dallanom_sm(:,:,classnum);
stdy = nanstd(y(:));
maxy = max(y(:))./stdy;
for c = 1:12, 
    subplot(3,4,c)
    ii = find(dv(:,2) == c); 
    x = Tanom(ii,:); y = Dallanom_sm(ii,:,classnum)./stdy; 
    plot(x(:),y(:),'.b');
    title(datestr([2000 c 1 0 0 0],3)), axis([-5 5 maxy.*[-1 1]]); 
    ii = find(~isnan(x) & ~isnan(y));
%    p = polyfit(x(ii),y(ii), 1);
    [m,b,r,sm] = lsqfitgm(x(ii),y(ii));
    %yfit = polyval(p,x(ii));
    yfit2 = polyval([m b],x(ii));
    hold on
    %plot(x(ii),yfit, 'g-')
    %r = corrcoef(x(ii),y(ii)); rsq = r(2).^2;
    rsq(c,classnum) = r.^2; slope(c,classnum) = m; std_slope(c,classnum) = sm;
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
xlabel('Temperature anomaly ( \circC)', 'fontsize', 14)
subplot(3,4,5)
ylabel([class2use{ind_diatoms(classnum)} ' anomaly (biovol mL ^{-1})'], 'fontsize', 14)
end;
r = sqrt(rsq);
t = r.*sqrt((n-2)./(1-rsq));
p = 1-tcdf(t,n-2);
sig = (p<.05);
slope_sig = slope.*sig;

figure
for c = 1:28,subplot(7,4,c),bar(slope_sig(:,c)), xlim([0 13]), ym = max(abs(ylim)); ylim([-1 1].*ym), title(class2use(ind_diatoms(c))); end;

figure
spnum = 1;
for classnum = 1:length(ind_diatoms),
%    if spnum > 12,
%        figure
%        spnum = 1;
%    end;
    subplot(4,7,spnum)
    plot(1:366,Dallmean(:,classnum), '.')
    hold on
    plot(1:366,Dallmean_sm(:,classnum), 'r-')
    %xlim([1 366])
    %datetick('x', 'keeplimits')
    datetick('x',3)
    title(class2use(ind_diatoms(classnum)))
    spnum = spnum + 1;
    ylim([0 inf])
end;
