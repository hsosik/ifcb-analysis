resultpath = 'C:\work\IFCB\user_training_test_data\manual\'; %USER
roibasepath = 'C:\work\IFCB\user_training_test_data\data\'; %USER
feapath = 'C:\work\IFCB\user_training_test_data\features\2014\'; %USER
micron_factor = 1/3.4; %USER PUT YOUR OWN microns per pixel conversion
filelist = dir([resultpath 'D*.mat']);

%calculate date
matdate = IFCB_file2date({filelist.name});

load([resultpath filelist(1).name]) %read first file to get classes
numclass = length(class2use_manual);
class2use_manual_first = class2use_manual;
classcount = NaN(length(filelist),numclass);  %initialize output
classbiovol = classcount;
ml_analyzed = NaN(length(filelist),1);

for filecount = 1:length(filelist),
    filename = filelist(filecount).name;
    disp(filename)
    hdrname = [roibasepath filesep filename(2:5) filesep filename(1:9) filesep regexprep(filename, 'mat', 'hdr')]; 
    ml_analyzed(filecount) = IFCB_volume_analyzed(hdrname);
     
    load([resultpath filename])
  %  yr = str2num(filename(7:10));
    clear targets
  %  feapath = regexprep(feapath_base, 'XXXX', filename(7:10));
    [~,file] = fileparts(filename);
    feastruct = importdata([feapath file '_fea_v2.csv'], ',');
    ind = strmatch('Biovolume', feastruct.colheaders);
    targets.Biovolume = feastruct.data(:,ind);
    ind = strmatch('roi_number', feastruct.colheaders);
    tind = feastruct.data(:,ind);
    
    classlist = classlist(tind,:);
    if ~isequal(class2use_manual, class2use_manual_first)
        disp('class2use_manual does not match previous files!!!')
        %     keyboard
    end;
    temp = zeros(1,numclass); %init as zeros for case of subdivide checked but none found, classcount will only be zero if in class_cat, else NaN
    tempvol = temp;
    for classnum = 1:numclass,
        cind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
        temp(classnum) = length(cind);
        tempvol(classnum) = nansum(targets.Biovolume(cind)*micron_factor.^3);
    end;
    
    classcount(filecount,:) = temp;
    classbiovol(filecount,:) = tempvol;  
    clear class2use_manual class2use_auto class2use_sub* classlist
end;

class2use = class2use_manual_first;
if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
notes = 'Biovolume in units of cubed micrometers';
save([resultpath 'summary\count_biovol_manual_' datestr], 'matdate', 'ml_analyzed', 'classcount', 'classbiovol', 'filelist', 'class2use', 'notes')


