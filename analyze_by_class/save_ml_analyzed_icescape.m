roipath = '\\floatcoat\laneylab\projects\HLY1001\data\imager\underway\';

%syringe and pump settings
steps_per_sec = 40;
ml_per_step = 5/48000;
flowrate = ml_per_step * steps_per_sec;  %ml/sec
minproctime = 0.14;
adcpath = roipath;
filelist = dir([roipath '*.adc']);
runtime = NaN(length(filelist),1);  %initialize large to avoid growing vectors
looktime = runtime;
looktime2 = runtime;
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

    longproc_ind = find(adcdata(2:end,8)-adcdata(1:end-1,9)>minproctime);
    %only use adcdata line once in cases with 2 or more rois each with new line
    [junk,i]= unique(adcdata(longproc_ind,1));
    longproc_ind = longproc_ind(i);
    looktime(count) = adcdata(end,9)- adcdata(end,1)*minproctime - sum(adcdata(longproc_ind+1,8)-adcdata(longproc_ind,9)) + length(longproc_ind)*minproctime;
    longproc_ind = find(adcdata(2:end,8)-adcdata(1:end-1,9)>.2);
        %only use adcdata line once in cases with 2 or more rois each with new line
        [junk,i]= unique(adcdata(longproc_ind,1));
        longproc_ind = longproc_ind(i);
        looktime2(count) = adcdata(end,9)- adcdata(end,1)*.2 - sum(adcdata(longproc_ind+1,8)-adcdata(longproc_ind,9)) + length(longproc_ind)*.2;

    numtriggers(count) = adcdata(end,1);
    numrois(count) = size(adcdata,1);
    if 1, %numtriggers > 2500,
    figure(99), clf, 
    subplot(2,1,1)
    plot(adcdata(1:end-1,8)/60, diff(adcdata(:,8)), '.'), line(xlim, [.14 .14], 'color', 'r'), line(xlim, [.2 .2], 'color', 'r')
    subplot(2,1,2)
    plot(adcdata(1:end-1,8)/60, diff(adcdata(:,8)), '.'), line(xlim, [.14 .14], 'color', 'r'), line(xlim, [.2 .2], 'color', 'r'), ylim([0 .5])
    figure(100)
    hist(adcdata(2:end,8)-adcdata(1:end-1,9), 0:.01:.3), xlim([0 .3])
    pause
    end;
end;
ml_analyzed = flowrate.*looktime;
save([roipath 'ml_analyzed'], 'ml_analyzed', 'runtime', 'looktime', 'numrois', 'numtriggers', 'filelist', 'minproctime', 'looktime2')
