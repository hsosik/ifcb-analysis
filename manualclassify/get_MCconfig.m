function [ MCconfig ] = get_MCconfig(  )
%function [ MCconfig ] = get_MCconfig(  )
%   Detailed explanation goes here

MCconfig.filenum2start = 1;  %USER select file number to begin (within the chosen set)

MCconfig.pick_mode = 'correct_or_subdivide'; %USER choose one from case list below
%MCconfig.pick_mode = 'raw_roi';

MCconfig.resultpath = 'C:\work\IFCB11\Manual\'; %USER set
%MCconfig.resultpath = 'C:\work\IFCB010\ManualClassify\'; %USER set

MCconfig.classpath = '';
MCconfig.class_filestr = ''; %USER set, string appended on roi name for class files
temp = load('class2use_MVCOmanual3', 'class2use'); %USER load yours here
MCconfig.class2use = temp.class2use;
MCconfig.default_class = 'other';

%MCconfig.class2view1 = MCconfig.class2use; %case to view all
%MCconfig.class2view1 = setdiff(MCconfig.class2use, {'bad' 'mix'}); %example to skip a few
MCconfig.class2view1 = intersect(MCconfig.class2use, {'pennate' 'mix'}); %example to select a few
%MCconfig.class2view2 = { }; %example to skip view2 
MCconfig.class2view2 = { 'all' }; %example to view all 

if ~exist(MCconfig.resultpath, 'dir'),
    dos(['mkdir ' resultpath]);
end;

end

