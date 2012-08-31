function [ MCconfig ] = get_MCconfigHLY(  )
%function [ MCconfig ] = get_MCconfigHLY(  )
%   Detailed explanation goes here

MCconfig.filenum2start = 5;  %USER select file number to begin (within the chosen set)

%MCconfig.pick_mode = 'correct_or_subdivide'; %USER choose one from case list
MCconfig.pick_mode = 'raw_roi';

MCconfig.resultpath = '\\floatcoat\LaneyLab\projects\HLY1101\work_IFCB8\Manual\'; %USER set
MCconfig.class_filestr = '_class_v1'; %USER set, string appended on roi name for class files

temp = load('\\floatcoat\LaneyLab\projects\HLY1101\work_IFCB8\code_Aug2012\class2use_HLY1101', 'class2use');
MCconfig.class2use = [temp.class2use];
MCconfig.default_class = 'other';
big_only = 0; %case for picking Laboea and tintinnids only

MCconfig.class2view1 = MCconfig.class2use; %case to view all
%MCconfig.class2view1 = setdiff(MCconfig.class2use, {'bad' 'mix'}); %example to skip a few
%MCconfig.class2view1 = intersect(MCconfig.class2use, {'ciliate'}); %example to select a few

if ~exist(MCconfig.resultpath, 'dir'),
    dos(['mkdir ' resultpath]);
end;

end

