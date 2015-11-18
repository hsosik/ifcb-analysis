%function [ ] = countcells_allTBnew_VPR(classpath_generic , in_dir, yrrange)
%function [ ] = countcells_allTBnew_user_training(classpath_generic , in_dir, yrrange)
%For example:
%countcells_allTBnew_user_training('C:\work\IFCB\user_training_test_data\class\classxxxx_v1\' , 'C:\work\IFCB\user_training_test_data\data\', 2014)
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2012 / August 2015
%
%Example inputs:
%   classpath_generic = 'C:\work\IFCB\user_training_test_data\class\classxxxx_v1\'; %USER class file location, leave xxxx in place of 4 digit year
%   in_dir = 'C:\work\IFCB\user_training_test_data\data\'; %USER where to access data (hdr files) (url for web services, full path for local)
%   yrrange = 2014; %USER one value or range (e.g., 2013:2014)

% countcells_allTBnew.m, modified from countcells_allTBMVCO.m
% configured for IFCB007 and higher (except IFCB008)
% summarizes class results for a series of classifier output files (treebagger)
% summary file will be located in subdir \summary\ at the top level
% location of classifier output files
%classpath = '\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_22Sep2015_200trees_allCat\classpath_div\';
classpath = '\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_30Oct2015_six_classes\classpath_div\';
%classpath = '\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_24Sep2015_combineAllPheao24Sep2015\';
%classpath = '\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_24Sep2015_combineAllPheao24Sep2015\classpath_div\';
%path_out = [regexprep(classpath_generic, 'classxxxx_v1\', ''), 'summary' filesep];
path_out = [classpath, filesep, 'summary', filesep];
classfiles = [];
filelist = [];
% for yrcount = 1:length(yrrange), %USER not tested yet for multiple years, but should work
%     yr = yrrange(yrcount);
%     classpath = regexprep(classpath_generic, 'xxxx', num2str(yr));
     %temp = [dir([classpath 'I*.mat']); dir([classpath 'D*.mat'])];
     temp = dir([classpath 'd*.mat']);
    if ~isempty(temp)
        pathall = repmat(classpath, length(temp),1);
        temp = char(temp.name);
        classfiles = [classfiles; cellstr([pathall temp])];
        filelist = [filelist; temp(:,1:22)];
    end
%     clear temp pathall classpath
% end;

% if strcmp('http', in_dir(1:4))
%     hdrfiles = cellstr([repmat(in_dir,length(filelist),1) filelist repmat('.hdr', length(filelist), 1)]);
% else
%     fsep = repmat(filesep, size(filelist,1),1);
%     hdrfiles = cellstr([repmat(in_dir,size(filelist,1),1) filelist(:,2:5) fsep filelist(:,1:9) fsep filelist repmat('.hdr', size(filelist,1), 1)]);
% end;
%mdate = IFCB_file2date(filelist);

%presumes all class files have same class2useTB list
temp = load(classfiles{1}, 'class2useTB');
class2use = temp.class2useTB; clear temp classfilestr
classcount = NaN(length(classfiles),length(class2use));
classcount_above_optthresh = classcount;
classcount_above_adhocthresh = classcount;
num2dostr = num2str(length(classfiles));
%ml_analyzed = NaN(size(classfiles));
adhocthresh = 0.5.*ones(size(class2use)); %assign all classes the same adhoc decision threshold between 0 and 1
adhocthresh(strmatch('whiteout', class2use, 'exact')) = 0.7; %reassign value for specific class
adhocthresh(strmatch('phae2all', class2use, 'exact')) = 0.4; %reassign value for specific class
adhocthresh(strmatch('phaeMany', class2use, 'exact')) = 0.7; %reassign value for specific class
adhocthresh(strmatch('squashed', class2use, 'exact')) = 0.3; %reassign value for specific class
adhocthresh(strmatch('blurry_marSnow', class2use, 'exact')) = 0.5; %reassign value for specific class
adhocthresh(strmatch('phaeIndiv', class2use, 'exact')) = 0.4; %reassign value for specific class
for filecount = 1:length(classfiles)
     if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end;
     %ml_analyzed(filecount) = IFCB_volume_analyzed(hdrfiles{filecount});
    if exist('adhocthresh', 'var'),
        [classcount(filecount,:), classcount_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:)] = summarize_TBclass(classfiles{filecount}, adhocthresh);
    else
        [classcount(filecount,:), classcount_above_optthresh(filecount,:)] = summarize_TBclass(classfiles{filecount});
    end;

end;

if ~exist(path_out, 'dir'),
    mkdir(path_out)
end;

%ml_analyzedTB = ml_analyzed;
%mdateTB = mdate;
filelistTB = filelist;
class2useTB = class2use;
classcountTB = classcount;
classcountTB_above_optthresh = classcount_above_optthresh;
clear filelist class2use classcount classcount_above_optthresh filecount yr* classfiles in_dir num2dostr

if exist('adhocthresh', 'var'),
    classcountTB_above_adhocthresh = classcount_above_adhocthresh;
    save([path_out 'summary_allTB'] , 'class2useTB', 'classcountTB', 'classcountTB_above_optthresh', 'classcountTB_above_adhocthresh', 'filelistTB', 'adhocthresh')
else
    save([path_out 'summary_allTB'] , 'class2useTB', 'classcountTB', 'classcountTB_above_optthresh','filelistTB')
end;

return


% %example plotting code for all of the data (load summary file first)
% figure
% classind = 2;
% plot(mdateTB, classcountTB(:,classind)./ml_analyzedTB, '.-')
% hold on
% plot(mdateTB, classcountTB_above_optthresh(:,classind)./ml_analyzedTB, 'g.-')
% plot(mdateTB, classcountTB_above_adhocthresh(:,classind)./ml_analyzedTB, 'g.-')
% legend('All wins', 'Wins above optimal threshold', 'Wins above adhoc threshold')
% ylabel([class2useTB{classind} ', mL^{ -1}'])
% datetick('x')
