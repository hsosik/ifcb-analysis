resultpath = '\\mellon\saltpond\manualclassify\';
urlbase = 'http://ifcb-data.whoi.edu/saltpond/';
filelist = dir([resultpath 'D*.mat']);

%calculate date
matdate = IFCB_file2date({filelist.name});

load([resultpath filelist(1).name]) %read first file to get classes
numclass = length(class2use_manual);
class2use_manual_first = class2use_manual;
class2use_here = class2use_manual;
classcount = NaN(length(filelist),numclass);  %initialize output
ml_analyzed = NaN(length(filelist),1);
for filecount = 1:length(filelist),
    filename = filelist(filecount).name;
    disp(filename)
    hdrname = [urlbase regexprep(filename, 'mat', 'hdr')]; 
    ml_analyzed(filecount) = IFCB_volume_analyzed(hdrname);
    
%     roipath = [roidaypath filename(1:9) '\'];
%     hdr = IFCBxxx_readhdr([roipath regexprep(filename, 'mat', 'hdr')]); 
%     adcdata = importdata([roipath regexprep(filename, 'mat', 'adc')]);
%     runtime = adcdata(end,13)-adcdata(1,13); %triggers 2-last
%     temp = runtime./(adcdata(end,1)-1);
%     runtime = runtime+temp; %add average for 1 extra trigger (first)
%     missed_ratio = hdr.inhibittime./hdr.runtime;
%     looktime = runtime-runtime*missed_ratio;
%     ml_analyzed(filecount) = flowrate*looktime/60;
%     
    load([resultpath filename])
    if ~isequal(class2use_manual, class2use_manual_first)
        [t,ii] = min([length(class2use_manual_first), length(class2use_manual)]);
        if ~isequal(class2use_manual(1:t), class2use_manual_first(1:t)),
            disp('class2use_manual does not match previous files!!!')
            keyboard
        else
            if ii == 1, class2use_manual_first = class2use_manual; end; %new longest list
        end;
    end;
    for classnum = 1:numclass,
            %classcount(filecount,classnum) = size(find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum)),1);
            classcount(filecount,classnum) = size(find(classlist(:,2) == classnum),1); %manual only
    end;
    clear class2use_manual class2use_auto class2use_sub* classlist
end;

class2use = class2use_here;
if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
save([resultpath 'summary\count_manual_' datestr], 'matdate', 'ml_analyzed', 'classcount', 'filelist', 'class2use')

return

figure %example
classnum = 1;
plot(matdate, classcount(:,classnum)./ml_analyzed, '.-')
datetick('x')
ylabel([class2use{classnum} ' (mL^{-1})'])

