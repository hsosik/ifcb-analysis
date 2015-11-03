% countcells_allTBnew.m, modified from countcells_allTBMVCO.m
% configured for IFCB007 and higher (except IFCB008)
% summarizes class results for a series of classifier output files (treebagger)
% summary file will be located in subdir \summary\ at the top level
% location of classifier output files
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2012

%classpath_generic = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\classxxxx_v1\';
%classpath_generic = 'C:\IFCB\class_TAMUG_Trees_19Mar2015\xxxx\'; %USER class file location, leave xxxx in place of 4 digit year
classpath_generic = '\\RASPBERRY\d_work\IFCB9_acoustic\class\';
in_dir = '\\RASPBERRY\d_work\IFCB9_acoustic\'; %USER where to access data (hdr files) (url for web services, full path for local)
yrrange = 2015; %USER

path_out = [regexprep(classpath_generic, 'xxxx', ''), 'summary' filesep];

classfiles = [];
filelist = [];
for yrcount = 1:length(yrrange), %USER not tested yet for multiple years, but should work
    yr = yrrange(yrcount);
    classpath = regexprep(classpath_generic, 'xxxx', num2str(yr));
    %temp = [dir([classpath 'I*.mat']); dir([classpath 'D*.mat'])];
    temp = dir([classpath 'D*.mat']);
    pathall = repmat(classpath, length(temp),1);
    %temp = [filelist; char(temp.name)];
    temp = char(temp.name);
    classfiles = [classfiles; cellstr([pathall temp])];
    filelist = [filelist; temp(:,1:24)];
    clear temp pathall classpath
end;

if strcmp('http', in_dir(1:4))
    hdrfiles = cellstr([repmat(in_dir,length(filelist),1) filelist repmat('.hdr', length(filelist), 1)]);
else
    fsep = repmat(filesep, size(filelist,1),1);
    hdrfiles = cellstr([repmat(in_dir,size(filelist,1),1) filelist(:,1:5) fsep filelist repmat('.hdr', size(filelist,1), 1)]);
end;
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
    %     ml_analyzed(filecount) = IFCB_volume_analyzed_Rob2(hdrfiles{filecount});
    adcpath  = '\\sosiknas1\Lab_data\IFCB9_Acoustic_Focusing\data';
    temp = char(classfiles(filecount));
    slashpos1 = findstr('\', (temp));
    slashpos1 = slashpos1(end);
    fname = [adcpath temp(slashpos1:slashpos1+24) '.adc'];
    adcdata = load(fname);
    sec2event2 = adcdata(2,2); %Rob added
%     ml_analyzed(filecount) = IFCB_volume_analyzed_Rob2(hdrfiles{filecount});
%     ml_analyzed(filecount) = IFCB_volume_analyzed_Rob2(hdrfiles{filecount});
    ml_analyzed(filecount) = IFCB_volume_analyzed_acoustic(hdrfiles{filecount}, sec2event2);
    
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
clear mdate filelist class2use classcount classcount_above_optthresh classcount_above_adhocthresh filecount yr* classfiles in_dir num2dostr

if exist('adhocthresh', 'var'),
    classcountTB_above_adhocthresh = classcount_above_adhocthresh;
    save([path_out 'summary_allTB'] , 'class2useTB', 'classcountTB', 'classcountTB_above_optthresh', 'classcountTB_above_adhocthresh', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'adhocthresh', 'classpath_generic', 'sec2event2') %Rob added
else
    save([path_out 'summary_allTB'] , 'class2useTB', 'classcountTB', 'classcountTB_above_optthresh', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'classpath_generic', 'sec2event2') %Rob added
end;


%example plotting code (load summary file first)
figure, subplot(2,1,1)
classind = 25;
plot(mdateTB, classcountTB(:,classind)./ml_analyzedTB, '.-')
hold on
plot(mdateTB, classcountTB_above_optthresh(:,classind)./ml_analyzedTB, 'g.-')
legend('All wins', 'Wins above optimal threshold')
ylabel([class2useTB{classind} ', mL^{ -1}'])
datetick('x')
subplot(2,1,2)
classind = 11;
plot(mdateTB, classcountTB(:,classind)./ml_analyzedTB, '.-')
hold on
plot(mdateTB, classcountTB_above_optthresh(:,classind)./ml_analyzedTB, 'g.-')
legend('All wins', 'Wins above optimal threshold')
ylabel([class2useTB{classind} ', mL^{ -1}'])
datetick('x')