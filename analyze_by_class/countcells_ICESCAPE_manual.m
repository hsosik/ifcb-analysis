resultpath = '\\floatcoat\laneylab\projects\HLY1001\work\manual_fromClass\underway\';
roipath = '\\floatcoat\laneylab\projects\HLY1001\data\imager\underway\';
load([roipath 'ml_analyzed']) %load the milliliters analyzed for all sample files

%mode_list = manual_list(1,2:end-1); mode_list = [mode_list 'ciliate_ditylum'];
%find ml_analyzed matching each manual file
resfilelist = dir([resultpath 'IFCB*.mat']);
[~,ia, ib] = intersect(regexprep({resfilelist.name}', '.mat', ''), regexprep({filelist.name}', '.adc', ''));
if length(ia) ~= length(resfilelist),
    disp('missing some ml_analyzed values; need to make updated ml_analyzed all.mat?')
    pause
end;
temp = NaN(size(resfilelist));
temp(ia) = ml_analyzed(ib);
ml_analyzed = temp;
%clean up from ml_analyzed_all
clear looktime matdate minproctime runtim
filelist = resfilelist; clear resfilelist

%calculate date
fstr = char(filelist.name);
year = str2num(fstr(:,7:10));
yearday = str2num(fstr(:,12:14));
hour = str2num(fstr(:,16:17));
min = str2num(fstr(:,18:19));
sec = str2num(fstr(:,20:21));
matdate = datenum(year,0,yearday,hour,min,sec);
clear fstr year yearday hour min sec

load([resultpath filelist(1).name]) %read first file to get classes
class2use_manual_first = class2use_manual;
class2use_first_sub = class2use_sub4; %this is specific for one sub case = ciliates
numclass1 = length(class2use_manual);
numclass2 = length(class2use_sub4);
numclass = numclass1 + numclass2;
class2use_here = [class2use_manual_first class2use_sub4];
classcount = NaN(length(filelist),numclass);  %initialize output
for filecount = 1:length(filelist),
    filename = filelist(filecount).name;
    disp(filename)
    load([resultpath filename])
    if ~isequal(class2use_manual, class2use_manual_first)
        disp('class2use_manual does not match previous files!!!')
        keyboard
    end;
    temp = zeros(1,numclass); %init as zeros for case of subdivide checked but none found, classcount will only be zero if in class_cat, else NaN
    for classnum = 1:numclass1,
            temp(classnum) = size(find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum)),1);
    end;
    if exist('class2use_sub4', 'var'),
         if ~isequal(class2use_sub4, class2use_first_sub)
            disp('class2use_sub4 does not match previous files!!!')
            keyboard
        end;
        for classnum = 1:numclass2,
            temp(classnum+numclass1) = size(find(classlist(:,4) == classnum),1);
        end;
    end;
    classcount(filecount,:) = temp;
    clear class2use_manual class2use_auto class2use_sub* classlist
end;

class2use = class2use_here;
if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
save([resultpath 'summary\count_manual_' datestr], 'matdate', 'ml_analyzed', 'classcount', 'filelist', 'class2use')

%create and save daily binned results
[matdate_bin, classcount_bin, ml_analyzed_bin] = make_day_bins(matdate,classcount, ml_analyzed);
save([resultpath 'summary\count_manual_' datestr '_day'], 'matdate_bin', 'classcount_bin', 'ml_analyzed_bin', 'class2use')

