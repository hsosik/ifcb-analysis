roipath = '\\floatcoat\IFCBdata\IFCB8_HLY1101\data\';
roipath = 'C:\work\IFCB8\Healy1101\data\';
metapath = '\\floatcoat\IFCBdata\IFCB8_HLY1101\metadata\';

load \\floatcoat\IFCBdata\IFCB8_HLY1101\metadata\HLY1101metadata.mat
isgoodsample = ones(size(metadata));
for ind = 1:length(metadata),
    if strcmp(metadata(ind).manual_flag, 'omit'),
        isgoodsample(ind) = 0;
    elseif strfind(metadata(ind).automated_flag, 'emptyadc'),
        isgoodsample(ind) = 0;
    elseif strfind(metadata(ind).automated_flag, 'emptyroi'),
        isgoodsample(ind) = 0;    
    elseif strcmp(metadata(ind).samp_type, 'diags') || strcmp(metadata(ind).samp_type, 'beads')  
        isgoodsample(ind) = 0;
    end;
end;
%"good" subset
metadata = metadata(isgoodsample==1);
filelist = {metadata.filename}';
clear ind clear isgoodsample

%syringe and pump settings
steps_per_sec = 40;
ml_per_step = 5/48000;
flowrate = ml_per_step * steps_per_sec;  %ml/sec
extra_proc = 0.05; %derived for Healy1101 from Sam's artificial trigger exp't, see timing8sept2012.m
trig_rate_thresh = 0.9; %trig/sec, lower cut-off for accept rearm as true
rearm_time = 10.2; %seconds dead associated with rearm
adcpath = roipath;
%filelist = dir([roipath '*.adc']);
%filelist([filelist.bytes] == 0) = []; %skip 0-sized files
runtime = NaN(length(filelist),1);  %initialize large to avoid growing vectors
looktime = runtime;
numtriggers = runtime;
numrois = runtime;   
looktime2 = runtime;
looktime3 = runtime;
looktime4 = runtime;
rearms = runtime;
bins = 0:.01:.25;
prochist = NaN(length(filelist), length(bins));
intbins = 0:.01:20;
intervalhist = NaN(length(filelist), length(intbins));
for count = 1:length(filelist),
    %filename = filelist(count).name;
    %filename = filename(1:end-4);
    filename = filelist{count};
    temp = dir([roipath filename '.roi']);
    disp([num2str(count) ' of ' num2str(length(filelist)) ': ' filename])
    adcdata = importdata([adcpath filename '.adc'], ',');  %robust to last line having a few missing values...
    if ~isempty(strfind(metadata(count).automated_flag, 'adctrig1time')),
        adcdata(adcdata(:,1) == 1,:) = [];
    end;
    if ~isempty(strfind(metadata(count).automated_flag, 'adcfinaltime')) || ~isempty(strfind(metadata(count).automated_flag, 'LTalgOK')),
        if ~isempty(adcdata),
            adcdata(adcdata(:,1) == adcdata(end,1),:) = [];
        end;
    end;
    if ~isempty(adcdata),
    runtime(count) = adcdata(end,8);
    numtriggers(count) = adcdata(end,1);
    numrois(count) = size(adcdata,1);
    for j = 1:size(adcdata,1),
        rearmflags = bitshift(adcdata(:,18),-4);
        rearmindxs = find(rearmflags == 1);
        rearms(count) = length( rearmindxs );
    end;
    rearms_adj(count) = rearms(count);
    if numtriggers(count)/runtime(count) < trig_rate_thresh,
        rearms_adj(count) = 0;
    end;
    proc = adcdata(:,9)-adcdata(:,8); %ii = find(proc >0);
    %find only one instance of each trigger
    [~,ii] = unique(adcdata(:,1));
    %keyboard
    %looktime2(count) = adcdata(end,9) - sum(proc(ii)*1000*.586 + 156)/1000;
    sumproc(count) = sum(proc(ii));
    %looktime(count) = adcdata(end,9) - sumproc(count) - adcdata(end,1)*extra_proc;
    looktime(count) = adcdata(end,9) - sumproc(count) - adcdata(end,1)*extra_proc - rearms_adj(count)*rearm_time;  %add consideration of 10-sec rearms
    %extra_proc3 = .05; looktime3(count) = adcdata(end,9) - sumproc(count) - adcdata(end,1)*extra_proc3;  %
    %extra_proc4 = .05; looktime4(count) = adcdata(end,9) - sumproc(count) - adcdata(end,1)*extra_proc4 - rearms(count)*10;  %
    
    prochist(count,:) = hist(proc, bins);
    intervalhist(count,:) = hist(diff(adcdata(ii,8)), intbins);
    end;
end;
ml_analyzed = flowrate.*looktime;
save([metapath 'ml_analyzed_detail'], 'ml_analyzed', 'runtime', 'numrois', 'numtriggers', 'filelist', 'sumproc', 'looktime*', 'extra_proc*', 'bins', 'prochist', 'intbins', 'intervalhist', 'rearms*', 'trig_rate_thresh', 'rearm_time')
save([metapath 'ml_analyzed'], 'ml_analyzed', 'runtime', 'looktime', 'filelist', 'extra_proc', 'trig_rate_thresh', 'rearm_time')

%mesh(bins, 1:length(filelist), prochist)
%mesh(intbins, 1:length(filelist), intervalhist)