roipath = '\\floatcoat\IFCBdata\IFCB8_HLY1101\data\';

%syringe and pump settings
steps_per_sec = 40;
ml_per_step = 5/48000;
flowrate = ml_per_step * steps_per_sec;  %ml/sec
extra_proc = 0; %best guess for IFCB8 in 2010
adcpath = roipath;
filelist = dir([roipath '*.adc']);
filelist([filelist.bytes] == 0) = []; %skip 0-sized files
runtime = NaN(length(filelist),1);  %initialize large to avoid growing vectors
looktime = runtime;
numtriggers = runtime;
numrois = runtime;   
looktime2 = runtime;
for count = 1:length(filelist),
    filename = filelist(count).name;
    filename = filename(1:end-4);
    temp = dir([roipath filename '.roi']);
    disp([num2str(count) ' of ' num2str(length(filelist)) ': ' filename])
    adcdata = importdata([adcpath filename '.adc'], ',');  %robust to last line having a few missing values...
    runtime(count) = adcdata(end,9); %Heidi, added in place of earlier version after Rob fixed midnight crossing problem above
    proc = adcdata(:,9)-adcdata(:,8); ii = find(proc >0);
    looktime2(count) = adcdata(end,9) - sum(proc(ii)*1000*.586 + 156)/1000;
    sumproc(count) = sum(proc(ii));
    looktime(count) = adcdata(end,9) - sumproc(count) - adcdata(end,1)*extra_proc;  %seems like no lag before first trigger on Healy 2010 with IFCB8
    numtriggers(count) = adcdata(end,1);
    numrois(count) = size(adcdata,1);
end;
ml_analyzed = flowrate.*looktime;
save([roipath 'ml_analyzed'], 'ml_analyzed', 'runtime', 'looktime', 'numrois', 'numtriggers', 'filelist', 'looktime', 'extra_proc', 'sumproc', 'looktime2')
