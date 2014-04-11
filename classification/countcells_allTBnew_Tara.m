% countcells_allTBnew.m, modified from countcells_allTBMVCO.m
% configured for IFCB007 and higher (except IFCB008)
% summarizes class results for a series of classifier output files (treebagger)
% summary file will be located in subdir \summary\ at the top level
% location of classifier output files
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2012

classpath = 'C:\work\IFCB\temp\class\'; classpath_generic = classpath;
%classpath_generic = '/Volumes/TOSHIBA EXT/whoi_data/class/xxxx/'; %USER class file location, leave xxxx in place of 4 digit year
in_url = 'http://ifcb-data.whoi.edu/TaraOceansPolarCircle_IFCB013/'; %USER web services to access data
%in_url = '/Volumes/TOSHIBA EXT/whoi_data/D2012/'; %USER local disk to access data

yrrange = 2013:2013; %USER

%path_out = [regexprep(classpath_generic, 'xxxx', ''), 'summary' filesep];
path_out = [classpath 'summary' filesep];

classfiles = [];
filelist = [];
for yrcount = 1:length(yrrange), %USER not tested yet for multiple years, but should work
    yr = yrrange(yrcount);
%    classpath = regexprep(classpath_generic, 'xxxx', num2str(yr));
    %temp = [dir([classpath 'I*.mat']); dir([classpath 'D*.mat'])];
    temp = dir([classpath 'D*.mat']);
    pathall = repmat(classpath, length(temp),1);
    temp = [filelist; char(temp.name)];
    classfiles = [classfiles; cellstr([pathall temp])];
    filelist = [filelist temp(:,1:24)];
    clear temp pathall classpath
end;
hdrfiles = cellstr([repmat(in_url,size(filelist,1),1) filelist repmat('.hdr', size(filelist,1), 1)]);%  To use with web services

%hdrfiles = cellstr([repmat(in_url,size(filelist,1),1) filelist(:,1:9) repmat(filesep,size(filelist,1),1)  filelist repmat('.hdr', length(filelist), 1)]);
mdate = IFCB_file2date(filelist);

%presumes all class files have same class2useTB list
temp = load(classfiles{1}, 'class2useTB');
class2use = temp.class2useTB; clear temp classfilestr
classcount = NaN(length(classfiles),length(class2use));
classcount_above_optthresh = classcount;
classcount_above_adhocthresh = classcount;
num2dostr = num2str(length(classfiles));
ml_analyzed = NaN(size(classfiles));
%adhocthresh = 0.5.*ones(size(class2use)); %assign all classes the same adhoc decision threshold between 0 and 1
%adhocthresh(strmatch('Ditylum', class2use, 'exact')) = 0.45; %reassign value for specific class

for filecount = 1:length(classfiles)
    if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end;
    ml_analyzed(filecount) = IFCB_volume_analyzed(hdrfiles{filecount});
    if exist('adhocthresh', 'var'),
        [classcount(filecount,:), classcount_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:)] = summarize_TBclass(classfiles{filecount});
    else
        [classcount(filecount,:), classcount_above_optthresh(filecount,:)] = summarize_TBclass(classfiles{filecount});
    end;
end;

if ~exist(path_out, 'dir'),
    mkdir(path_out)
end;

ml_analyzedTB = ml_analyzed;
mdateTB = mdate;
filelistTB = filelist;
class2useTB = class2use;
classcountTB = classcount;
classcountTB_above_optthresh = classcount_above_optthresh;
clear mdate filelist class2use classcount classcount_above_optthresh classcount_above_adhocthresh filecount yr* classfiles in_url num2dostr

if exist('adhocthresh', 'var'),
    classcountTB_above_adhocthresh = classcount_above_adhocthresh;
    save([path_out 'summary_allTB'] , 'class2useTB', 'classcountTB', 'classcountTB_above_optthresh', 'classcountTB_above_adhocthresh', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'adhocthresh', 'classpath_generic')
else
    save([path_out 'summary_allTB'] , 'class2useTB', 'classcountTB', 'classcountTB_above_optthresh', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'classpath_generic')
end;


%example plotting code (load summary file first)
figure, subplot(2,1,1)
classind = 4;
plot(mdateTB, classcountTB(:,classind)./ml_analyzedTB, '.-')
hold on
plot(mdateTB, classcountTB_above_optthresh(:,classind)./ml_analyzedTB, 'g.-')
legend('All wins', 'Wins above optimal threshold')
ylabel([class2useTB{classind} ', mL^{ -1}'])
datetick('x')

subplot(2,1,2)
classind = 1;
plot(mdateTB, classcountTB(:,classind)./ml_analyzedTB, '.-')
hold on
plot(mdateTB, classcountTB_above_optthresh(:,classind)./ml_analyzedTB, 'g.-')
legend('All wins', 'Wins above optimal threshold')
ylabel([class2useTB{classind} ', mL^{ -1}'])
datetick('x')