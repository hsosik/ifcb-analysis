roipath = '\\floatcoat\laneylab\projects\HLY1001\data\imager\underway\';

%syringe and pump settings
steps_per_sec = 40;
ml_per_step = 5/48000;
flowrate = ml_per_step * steps_per_sec;  %ml/sec
extra_proc = 0; %best guess for IFCB8 in 2010
adcpath = roipath;
filelist = dir([roipath '*.adc']);
runtime = NaN(length(filelist),1);  %initialize large to avoid growing vectors
looktime = runtime;
numtriggers = runtime;
numrois = runtime;   
for count = 1:length(filelist),
    filename = filelist(count).name;
    filename = filename(1:end-4);
    temp = dir([roipath filename '.roi']);
    disp([num2str(count) ' of ' num2str(length(filelist)) ': ' filename])
    adcdata = importdata([adcpath filename '.adc'], ',');  %robust to last line having a few missing values...
    %rob - fix time stamps for files that span midnight
    negind = find(adcdata(:,8)<0);
    adcdata(negind,8) = adcdata(negind,8) + 24*60*60;
    negind = find(adcdata(:,9)<0);
    adcdata(negind,9) = adcdata(negind,9) + 24*60*60;
    adctime = adcdata(:,8:9)';
    runtime(count) = adcdata(end,9); %Heidi, added in place of earlier version after Rob fixed midnight crossing problem above
    proc = adcdata(:,9)-adcdata(:,8); ii = find(proc >0);
    sumproc(count) = sum(proc(ii));
    looktime(count) = adcdata(end,9) - sumproc(count) - adcdata(end,1)*extra_proc;  %seems like no lag before first trigger on Healy 2010 with IFCB8
    
   % bin = 0:.01:.31;
   % t = hist(diff(adcdata(:,8)), bin);
   % temp = find(t(2:end));
   % mindiff(count) = bin(temp(1)+1)+.01;    
    
    numtriggers(count) = adcdata(end,1);
    numrois(count) = size(adcdata,1);
    if 1, %numtriggers > 2500,
    %figure(99), clf, 
    %subplot(2,1,1)
    %plot(adcdata(1:end-1,8)/60, diff(adcdata(:,8)), '.'), line(xlim, [.14 .14], 'color', 'r'), line(xlim, [.2 .2], 'color', 'r')
    %subplot(2,1,2)
    %plot(adcdata(1:end-1,8)/60, diff(adcdata(:,8)), '.'), line(xlim, [.14 .14], 'color', 'r'), line(xlim, [.2 .2], 'color', 'r'), ylim([0 .5])
    %figure(100)
    %bin = 0:.01:.31;
    %t = hist(diff(adcdata(:,8)), bin);
    %bar(bin(1:end-1), t(1:end-1))
    %hist(diff(adcdata(:,8)), 0:.01:.3), xlim([0 .3])
    %pause
%    temp = find(t(2:end));
%    mindiff(count) = bin(temp(1)+1);
    end;
end;
ml_analyzed = flowrate.*looktime;
save([roipath 'ml_analyzed'], 'ml_analyzed', 'runtime', 'looktime', 'numrois', 'numtriggers', 'filelist', 'looktime', 'extra_proc', 'sumproc')
