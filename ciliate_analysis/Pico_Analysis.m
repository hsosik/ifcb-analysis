clear all;
close all;

%%

%%%%%%%%%%%%%%%%%%%
%DOCK SAMPLE-NORMAL SETTINGS
%%%%%%%%%%%%%%%%%%%

datadir = '/Users/markmiller/Documents/24Sep2014/Normal Sample 3/';
filelist = dir([datadir '*.mat']);

signal=struct;
%axes_handle=gca;

for i=1:length(filelist);
a=importdata([datadir filelist(i).name]);
pmtC=a.A;
pmtB=a.B;
signal(i).pmtC=pmtC;
signal(i).pmtB=pmtB;
end
%

figure
for i=1:length(filelist);
    plot(signal(i).pmtC,'-r')
    hold on
end
title('Chlorophyll- Normal Sample')
xlim([1000 1500])
ylim([-0.2 3])

figure
for i=1:length(filelist);
    plot(signal(i).pmtB,'-g')
    hold on
end
title('PE- Normal Sample')
xlim([1000 1500])
ylim([-0.2 0.3])

%%
%%%%%%%%%%%%%%%%%%%
%DOCK SAMPLE-ALT SETTINGS
%%%%%%%%%%%%%%%%%%%

datadir = '/Users/markmiller/Documents/24Sep2014/Alt Sample 1/';
filelist = dir([datadir '*.mat']);

signal=struct;
%axes_handle=gca;

for i=1:length(filelist);
a=importdata([datadir filelist(i).name]);
pmtC=a.A;
pmtB=a.B;
signal(i).pmtC=pmtC;
signal(i).pmtB=pmtB;
end
%

figure
for i=1:length(filelist);
    plot(signal(i).pmtC,'-r')
    hold on
end
title('Chlorophyll- Alt Sample')
xlim([700 1200])
ylim([-0.2 4])

figure
for i=1:length(filelist);
    plot(signal(i).pmtB,'-g')
    hold on
end
title('Green- Alt Sample')
xlim([700 1200])
ylim([-0.2 0.8])

%%
%%%%%%%%%%%%%%%%%%%
%MESO SAMPLE-NORMAL SETTINGS -ALL SIGNALS
%%%%%%%%%%%%%%%%%%%

datadir = '/Users/markmiller/Documents/24Sep2014/Meso_Normal_1/';
filelist = dir([datadir '*.mat']);

signal=struct;
%axes_handle=gca;

for i=1:length(filelist);
a=importdata([datadir filelist(i).name]);
pmtC=a.A;
pmtB=a.B;
signal(i).pmtC=pmtC;
signal(i).pmtB=pmtB;
end
%

figure
for i=1:length(filelist);
    plot(signal(i).pmtC,'-r')
    hold on
end
title('Chlorophyll- Normal Sample')
%xlim([1000 2000])
ylim([-0.2 4])

figure
for i=1:length(filelist);
    plot(signal(i).pmtB,'-g')
    hold on
end
title('PE- Normal Sample')
%xlim([1000 2000])
ylim([-0.2 4])

%%

%%%%%%%%%%%%%%%%%%%
%MESO SAMPLE-ALT SETTINGS -ALL SIGNALS- NO STAIN
%%%%%%%%%%%%%%%%%%%

datadir = '/Users/markmiller/Documents/24Sep2014/Meso_Alt_2/';
filelist = dir([datadir '*.mat']);

signal=struct;
%axes_handle=gca;

for i=1:length(filelist);
a=importdata([datadir filelist(i).name]);
pmtC=a.A;
pmtB=a.B;
signal(i).pmtC=pmtC;
signal(i).pmtB=pmtB;
end
%

figure
for i=1:length(filelist);
    plot(signal(i).pmtC,'-r')
    hold on
end
title('Chlorophyll- Alt Sample')
%xlim([1000 2000])
ylim([-0.2 4])

figure
for i=1:length(filelist);
    plot(signal(i).pmtB,'-g')
    hold on
end
title('Green- Alt Sample')
%xlim([1000 2000])
ylim([-0.2 4])

%%