load \\raspberry\d_work\mvcodata\MVCO_CHEMTAX_Oct2012\108all
load c:\work\mvco\carbon\IFCB_carbon_manual_Dec2012
load c:\work\mvco\carbon\carbon_summary_fcb.mat

%near ASIT, <5m
tind = find(meta_data(:,9) < 5 & meta_data(:,13) < 41.33 & meta_data(:,13) > 41.32 & meta_data(:,14) < -70.56 & meta_data(:,14) > -70.575);
[~,ii] = sort(matdate(tind));
tind = tind(ii);

[~,i1,i2] = intersect(floor(matdate(tind)),Cmdate_day);
i1 = tind(i1);

figure
Cphyto = sum(C_day_mat(:,ind_phyto),2);
x = sum(average_all(i1,:),2);
y = Cphyto(i2);
figure, loglog(x,y, '.')
[a] = regress(log10(y), [log10(x) ones(size(i1))]);
hold on
eval(['fplot(''x.^' num2str(a(1)) '*10^' num2str(a(2)) ''', xlim)'])
title('Total phyto')
ylabel('Carbon (mg m ^{-3})'), xlabel('HPLC Chl a (mg m ^{-3})')

figure 
x = sum(average_all(i1,:),2);
y = Cphyto(i2);
plot(x,y, '.')
%[a, aint, r, rint, stat] = regress(log10(y), [log10(x) ones(size(i1))]);
hold on
%eval(['fplot(''x.^' num2str(a(1)) '*10^' num2str(a(2)) ''', xlim, ''r'')'])
%eval(['fplot(''' num2str(m) '* x +' num2str(b) ''', [0 1], ''r'')'])
[m,b,r,sm,sb]=lsqfitgm(log10(x),log10(y));
eval(['fplot(''x.^' num2str(m) '*10^' num2str(b) ''', xlim, ''r'')'])
text(6,20, ['y = ' num2str(10^b, '%0.2f') 'x^{' num2str(m, '%0.2f') '}'], 'color', 'r')
text(6,10, ['r = ' num2str(r, '%0.3f')], 'color', 'r')
ylabel('Phytoplankton carbon (mg m ^{-3})'), xlabel('HPLC Chl a (mg m ^{-3})')
axis square
ylim([0 120]) 
    
x1 = average_all(i1,1);
y1 = C_diatom(i2);
x = x1(x1>0); 
y = y1(x1>0);
figure
plot(x1,y1, '.')
hold on
%[a, aint, r, rint, stat] = regress(log10(y), [log10(x) ones(size(x))]);
[m,b,r,sm,sb]=lsqfitgm(log10(x),log10(y));
eval(['fplot(''x.^' num2str(m) '*10^' num2str(b) ''', xlim, ''r'')'])
text(5,10, ['y = ' num2str(10^b, '%0.2f') 'x^{' num2str(m, '%0.2f') '}'], 'color', 'r')
text(5,6, ['r = ' num2str(r, '%0.3f')], 'color', 'r')
ylabel('Diatom carbon (mg m ^{-3})'), xlabel('HPLC/CHEMTAX Diatom Chl a (mg m ^{-3})')
axis square
ylim([0 60])

[ ind_dino, class_label ] = get_dino_ind(classes, classes );
x = average_all(i1,2);
y = sum(C_day_mat(i2,ind_dino),2);
figure
plot(x,y, '.')
hold on
%[a, aint, r, rint, stat] = regress(log10(y), [log10(x) ones(size(x))]);
[m,b,r,sm,sb]=lsqfitgm(log10(x),log10(y));
eval(['fplot(''x.^' num2str(m) '*10^' num2str(b) ''', xlim, ''r'')'])
text(.95,8, ['y = ' num2str(10^b, '%0.2f') 'x^{' num2str(m, '%0.2f') '}'], 'color', 'r')
text(.95,5, ['r = ' num2str(r, '%0.3f')], 'color', 'r')
ylabel('Dinoflagellate carbon (mg m ^{-3})'), xlabel('HPLC/CHEMTAX Dinoflagellate Chl a (mg m ^{-3})')
axis square
ylim([0 40])

ind = strmatch('Phaeocystis', classes);
x = average_all(i1,6);
y = C_day_mat(i2,ind);
%figure, loglog(x,y, '.')
figure, plot(x,y, '.')
[a] = regress(log10(y), [log10(x) ones(size(i1))])
hold on
eval(['fplot(''x.^' num2str(a(1)) '*10^' num2str(a(2)) ''', xlim)'])

figure, hold on
plot(x,y, '.')
[~,i1syn,i2syn] = intersect(floor(matdate(tind)),mdate(:));
i1syn = tind(i1syn);
x1 = average_all(i1syn,8);
y1 = synCperml(i2syn);
x = x1(x1>0 & y1>0); 
y = y1(x1>0 & y1>0);
[m,b,r,sm,sb]=lsqfitgm(log10(x),log10(y));
eval(['fplot(''x.^' num2str(m) '*10^' num2str(b) ''', xlim, ''r'')'])
text(.08,5, ['y = ' num2str(10^b, '%0.2f') 'x^{' num2str(m, '%0.2f') '}'], 'color', 'r')
text(.08,3, ['r = ' num2str(r, '%0.3f')], 'color', 'r')
ylabel('Cyanobacteria carbon (mg m ^{-3})'), xlabel('HPLC/CHEMTAX Cyanobacteria Chl a (mg m ^{-3})')
axis square
%ylim([0 60])


Cphyto = sum(C_day_mat(:,ind_phyto),2);
y = average_all(i1,1)./sum(average_all(i1,:),2);
x = C_diatom(i2)./Cphyto(i2);
figure
plot(x,y, '.')
hold on
line([0 1], [0 1], 'color', 'k')
set(gca, 'ytick', 0:.2:1, 'xtick', 0:.2:1)
[m,b,r,sm,sb]=lsqfitgm(x,y);
eval(['fplot(''' num2str(m) '* x +' num2str(b) ''', [0 1], ''r'')'])
axis([0 1 0 1])
set(gca, 'box', 'on')
text(.1, .9, ['y = ' num2str(m, '%0.3f') 'x + ' num2str(b, '%0.3f')], 'color', 'r')
text(.1, .84, ['r = ' num2str(r, '%0.3f')], 'color', 'r')
mpd = mean((y-x)./x)*100;
apd = mean(abs((y-x)./x))*100;
text(.6, .15, ['\delta(%) = ' num2str(mpd, '%0.2f')])
text(.6, .09, ['|\delta|(%) = ' num2str(apd, '%0.2f')])
xlabel('Diatom fraction, FCM carbon'), ylabel('Diatom fraction, HPLC/CHEMTAX Chl a')
axis square


[ ind_dino, class_label ] = get_dino_ind(classes, classes );
C_dino = sum(C_day_mat(i2,ind_dino),2);
Cphyto = sum(C_day_mat(:,ind_phyto),2);
y = average_all(i1,2)./sum(average_all(i1,:),2);
x = C_dino./Cphyto(i2);
figure
plot(x,y, '.')
hold on
line([0 1], [0 1], 'color', 'k')
set(gca, 'ytick', 0:.2:1, 'xtick', 0:.2:1)
[m,b,r,sm,sb]=lsqfitgm(x,y);
eval(['fplot(''' num2str(m) '* x +' num2str(b) ''', [0 1], ''r'')'])
axis([0 1 0 1])
set(gca, 'box', 'on')
text(.6, .15, ['y = ' num2str(m, '%0.3f') 'x + ' num2str(b, '%0.3f')], 'color', 'r')
text(.6, .09, ['r = ' num2str(r, '%0.3f')], 'color', 'r')
mpd = mean((y-x)./x)*100;
apd = mean(abs((y-x)./x))*100;
text(.1, .9, ['\delta(%) = ' num2str(mpd, '%0.2f')])
text(.1, .84, ['|\delta|(%) = ' num2str(apd, '%0.2f')])
xlabel('Dinoflagellate fraction, FCM carbon'), ylabel('Dinoflagellate fraction, HPLC/CHEMTAX Chl a')
axis square


picoC = synCperml(:,end-6:end)+picoeukCperml(:,end-6:end);
nanoC = euk2_10Cperml(:,end-6:end) + C10_20phyto_mat;
microC = C20_infphyto_mat;
totalC2 = picoC+nanoC+microC;
Csyn = synCperml(:,end-6:end);

[~,i1syn,i2syn] = intersect(floor(matdate(tind)),Cmdate_mat(:));
i1syn = tind(i1syn);
y1 = average_all(i1syn,8);
x1 = Csyn(i2syn)./totalC2(i2syn);
x = x1(x1>0 & y1>0); 
y = y1(x1>0 & y1>0);
figure
plot(x,y, '.')
hold on
line([0 .35], [0 .35], 'color', 'k')
set(gca, 'ytick', 0:.1:.3, 'xtick', 0:.1:.3)
[m,b,r,sm,sb]=lsqfitgm(x,y);
eval(['fplot(''' num2str(m) '* x +' num2str(b) ''', [0 1], ''r'')'])
axis([0 .35 0 .35])
set(gca, 'box', 'on')
text(.2, .14, ['y = ' num2str(m, '%0.3f') 'x + ' num2str(b, '%0.3f')], 'color', 'r')
text(.2, .12, ['r = ' num2str(r, '%0.3f')], 'color', 'r')
mpd = mean((y-x)./x)*100;
apd = mean(abs((y-x)./x))*100;
text(.05, .31, ['\delta(%) = ' num2str(mpd, '%0.2f')])
text(.05, .29, ['|\delta|(%) = ' num2str(apd, '%0.2f')])
xlabel('Cyanobacteria fraction, FCM carbon'), ylabel('Cyanobacteria fraction, HPLC/CHEMTAX Chl a')
axis square
