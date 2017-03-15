function [ ] = countcells_manual_user_training( resultpath, in_dir )
%function [ ] = countcells_manual_user_training( resultpath, in_dir )
%For example:
%countcells_manual_user_training('C:\work\IFCB\user_training_test_data\manual\' , 'C:\work\IFCB\user_training_test_data\data\')
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2012 / August 2015
%
%Example inputs:
%   resultpath = 'C:\work\IFCB\user_training_test_data\class\classxxxx_v1\'; %USER manual file location
%   in_dir = 'C:\work\IFCB\user_training_test_data\data\'; %USER where to access data (hdr files) (url for web services, full path for local)
%
% configured for IFCB007 and higher (except IFCB008)
% summarizes class results for a series of manual annotation files (as saved by startMC)
% summary file will be located in subdir \summary\ at the top level of the
% location of the manual result files

%resultpath = 'C:\work\IFCB\user_training_test_data\manual_temp\'; %USER
%in_dir = 'C:\work\IFCB\user_training_test_data\data\'; %USER

%make sure input paths end with filesep
if ~isequal(resultpath(end), filesep)
    resultpath = [resultpath filesep];
end
if ~isequal(in_dir(end), filesep)
    in_dir = [in_dir filesep];
end

filelist = dir([resultpath 'D*.mat']);

%calculate date
matdate = IFCB_file2date({filelist.name});

load([resultpath filelist(1).name]) %read first file to get classes
numclass = length(class2use_manual);
class2use_manual_first = class2use_manual;
classcount = NaN(length(filelist),numclass);  %initialize output
ml_analyzed = NaN(length(filelist),1);
for filecount = 1:length(filelist),
    filename = filelist(filecount).name;
    disp(filename)
    hdrname = [in_dir filesep filename(2:5) filesep filename(1:9) filesep regexprep(filename, 'mat', 'hdr')]; 
    ml_analyzed(filecount) = IFCB_volume_analyzed(hdrname);
     
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
            classcount(filecount,classnum) = size(find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum)),1);
            %classcount(filecount,classnum) = size(find(classlist(:,2) == classnum),1); %manual only
    end;
    clear class2use_manual class2use_auto class2use_sub* classlist
end;

class2use = class2use_manual_first;
if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
save([resultpath 'summary\count_manual_' datestr], 'matdate', 'ml_analyzed', 'classcount', 'filelist', 'class2use')

disp('Summary cell count file stored here:')
disp([resultpath 'summary\count_manual_' datestr])

return

figure %example
classnum = 3;
plot(matdate, classcount(:,classnum)./ml_analyzed, '.-')
datetick('x')
ylabel([class2use{classnum} ' (mL^{-1})'])

