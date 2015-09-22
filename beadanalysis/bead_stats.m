feapath = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\features_beads_v2\';
in_url = 'http://demi.whoi.edu/mvco_beads/';
filelist = dir([feapath 'I*.csv']);
feafile = [feapath filelist(1).name];
features = importdata(feafile);
Ecc_ind = strmatch('Eccentricity', features.colheaders);
Eqd_ind = strmatch('EquivDiameter', features.colheaders);
roinum_ind = strmatch('roi_number', features.colheaders);
Maj_ind =  strmatch('MajorAxisLength', features.colheaders);
Min_ind =  strmatch('MinorAxisLength', features.colheaders);
invM1_ind = strmatch('moment_invariant1', features.colheaders);
csvfile = [in_url filelist(1).name(1:21), '.csv'];
[filestr,status] = urlwrite(csvfile, 'temp.csv');
csvdata = importdata(filestr);
delete(filestr)
csvheaders = csvdata.textdata(1,:);
chl_ind =  strmatch('fluorescenceLow', csvheaders);
ssc_ind = strmatch('scatteringLow', csvheaders);

feaind = [1:50 230:236];

for count = 1:length(filelist),
    feafile = [feapath filelist(count).name];
    disp(feafile)
    features = importdata(feafile);
    files{count} = filelist(count).name(1:21);
    csvfile = [in_url filelist(count).name(1:21), '.csv'];
    [filestr,status] = urlwrite(csvfile, 'temp.csv');
    csvdata = importdata(filestr);
    delete(filestr)
    adcvalues = -1*[str2num(char(csvdata.textdata(2:end,ssc_ind))) str2num(char(csvdata.textdata(2:end,chl_ind)))];
    adc{count} = adcvalues;
    adcvalues(:,1) = adcvalues(:,1)+.03; %add some offset estimates
    adcvalues(:,2) = adcvalues(:,2)+.05;
    fea{count} = features.data(:,feaind);
%for x = 22:26, figure(1), clf,  plot(b2,features.data(b2,x), '.'), hold on, plot(b,features.data(b,x), 'or'), title(features.colheaders(x)),pause, end;

%roinum_ind = strmatch('roi_number', features.colheaders);
roinum_ind = strmatch('roi_number', features.textdata);
roinum = features.data(:,roinum_ind);
%bdind = [21 23 25 26 28 32 33 36 37 38 39 42 41];
%[~,b2] = setdiff(features.data(:,roinum_ind),bdind);
%[~,a,b] = intersect(bdind, features.data(:,roinum_ind));

pid_base = [in_url char(filelist(count).name(1:22))];
pid{count} = cellstr([repmat(pid_base,length(roinum),1) num2str(roinum,'%05.0f') repmat('.png',length(roinum),1)]);

b{count} = find(features.data(:,invM1_ind) < .165 & features.data(:,Eqd_ind) < 40 & features.data(:,Eqd_ind) > 25 & features.data(:,Maj_ind)./features.data(:,Min_ind) < 1.2 & adcvalues(:,2) > .1);
if 0,
x = 22; figure(1), clf,  plot(features.data(:,x), '.'), hold on, plot(b,features.data(b,x), 'or'), title(features.colheaders(x))

figure(2), clf
for ii = 1:min([length(b),80]),
    subplot(8,10,ii)
    imshow(imread(pid{b(ii)}))
end;

b2 = setdiff( 1:length(roinum), b);
figure(3), clf
for ii = 1:min([length(b2),80]),
    subplot(8,10,ii)
    imshow(imread(pid{b2(ii)}))
end;

figure(4), clf, subplot(1,2,1)
plot(adcvalues(:,1)+.03, adcvalues(:,2)+.05, '.')
hold on
plot(adcvalues(b,1)+.03, adcvalues(b,2)+.05, 'ro')
subplot(1,2,2)
plot((adcvalues(:,2)+.05)./(adcvalues(:,1)+.03), '.')
hold on
plot(b,(adcvalues(b,2)+.05)./(adcvalues(b,1)+.03), 'ro')

pause
end;
end;
save('beadsum', 'fea', 'b', 'pid', 'adc', 'files')
return

mdate = IFCB_file2date(files);
[~,ii] = sort(mdate);
mdate = mdate(ii);
fea = fea(:,ii);
files = files(:,ii);
pid = pid(ii);
adc = adc(ii);
b = b(ii);
clear ii

Eqd_ind = 1;
for ii = 1:length(b), 
    figure(1), clf,  
    [h,x] = hist(fea{ii}(b{ii},Eqd_ind), 0:50);
    bar(x,h)
    [~,a] =max(h);
    md(ii) = x(a); clear a
    n(ii) = size(b{ii},1);
    mn(ii) = mean(fea{ii}(b{ii},Eqd_ind));
    sd(ii) = std(fea{ii}(b{ii},Eqd_ind));
    title(files{ii}, 'interpreter', 'none')
%    pause 
end;

t = char(files');
t = str2num(t(:,5));

figure
subplot(3,1,1)
semilogy(mdate, n, '.-')
datetick('x')
ylabel('Number')
subplot(3,1,2)
a = find(n>=10);
b = find(n<10);
plot(mdate(a), mn(a), '.-')
hold on, plot(mdate(b), mn(b), 'c.')
ylim([28 38])
datetick('x')
ylabel('Mean eq. sph. diam (pixels)')
subplot(3,1,3)
plot(mdate(a), std(a)./mn(a), '.-')
%hold on, plot(mdate(b), std(b)./mn(b), '.c')
datetick('x')
ylabel('CV (diam, pixels)')

for ii = 1:length(b), 
    figure(1), clf,  
    [h,x] = hist(fea{ii}(b{ii},Eqd_ind), 0:50);
    bar(x,h)
    [~,a] =max(h);
    md(ii) = x(a); clear a
    n(ii) = size(b{ii},1);
    mn(ii) = mean(fea{ii}(b{ii},Eqd_ind));
    sd(ii) = std(fea{ii}(b{ii},Eqd_ind));
    title(files{ii}, 'interpreter', 'none')
%    pause 
end;


%8 aug 2011 focus
%4 Sept 09 focus
%8 Sep 09 (10:15 local) -- adjust focus 9 CCW -- for less halo...

%for ii = 1:50, figure(99),clf, plot(features.data(b2,ii), '.'), hold on, plot(features.data(b,ii), 'r.'), title(features.colheaders(ii)),pause, end;
