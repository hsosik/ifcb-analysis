
%syringe and pump settings
steps_per_sec = 40;
ml_per_step = 5/48000;
flowrate = ml_per_step * steps_per_sec;  %ml/sec

minproctime = 0.086;

roipath = '\\queenrose\IFCB2_C211A_SEA2007\data\';
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
    if ~isempty(adcdata),
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
        numtriggers(count) = adcdata(end,1);
        numrois(count) = size(adcdata,1);
    end;
end;
ml_analyzed = flowrate.*looktime;
save \\queenrose\IFCB2_C211A_SEA2007\ml_analyzed_C211A ml_analyzed runtime looktime numrois numtriggers filelist minproctime