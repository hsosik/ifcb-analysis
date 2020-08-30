resultpath = '\\sosiknas1\Lab_data\VPR\NBP1201\manual\'; %USER
roibasepath = '\\sosiknas1\Lab_data\VPR\NBP1201\rois\vpr4\d013\'; %USER

filelist = dir([resultpath 'NBP1201vpr4*.mat']);

%calculate date
%matdate = IFCB_file2date({filelist.name});

load([resultpath filelist(1).name]) %read first file to get classes
numclass = length(class2use_manual);
class2use_manual_first = class2use_manual;
class2use_here = class2use_manual;
classcount = NaN(length(filelist),numclass);  %initialize output
%ml_analyzed = NaN(length(filelist),1);
for filecount = 1:length(filelist),
    filename = filelist(filecount).name;
    disp(filename)
    %hdrname = [roibasepath filesep filename(2:5) filesep filename(1:9) filesep regexprep(filename, 'mat', 'hdr')]; 
    %ml_analyzed(filecount) = IFCB_volume_analyzed(hdrname);
     
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
    
    roi2use = 1:5000; %This is because we only looked at the first 5000 images of each VPR hour. Change as needed.
    for classnum = 1:numclass,
            %classcount(filecount,classnum) = size(find(classlist(roi2use,2) == classnum | (isnan(classlist(roi2use,2)) & classlist(roi2use,3) == classnum)),1);
            classcount(filecount,classnum) = size(find(classlist(roi2use,2) == classnum | (isnan(classlist(roi2use,2)) & classlist(roi2use,3) == classnum)),1);
            %classcount(filecount,classnum) = size(find(classlist(:,2) == classnum),1); %manual only
    end;
    clear class2use_manual class2use_auto class2use_sub* classlist
end;

class2use = class2use_here;
if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
save([resultpath 'summary\count_manual_' datestr], 'classcount', 'filelist', 'class2use')

return

figure %example
classnum = 3;
plot(matdate, classcount(:,classnum)./ml_analyzed, '.-')
datetick('x')
ylabel([class2use{classnum} ' (mL^{-1})'])

