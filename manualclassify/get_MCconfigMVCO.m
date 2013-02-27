    function [ MCconfig ] = get_MCconfigMVCO(  )
%function [ MCconfig ] = get_MCconfigMVCO(  )
%   Detailed explanation goes here
%MCconfig.filenum2start = 182;  %In the middle of batch classifying lepto
%1-25-13

MCconfig.filenum2start = 78;  %USER select file number to begin (within the chosen set)

MCconfig.pick_mode = 'correct_or_subdivide'; %USER choose one from case list
%MCconfig.pick_mode = 'raw_roi';

MCconfig.resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\'; %USER set
MCconfig.class_filestr = '_class_v1'; %USER set, string appended on roi name for class files

temp = load('class2use_MVCOmanual3', 'class2use');
%MCconfig.class2use = [temp.class2use 'unclassified'];
MCconfig.class2use = temp.class2use;
MCconfig.default_class = 'other';
big_only = 0; %case for picking Laboea and tintinnids only

%MCconfig.class2view1 = MCconfig.class2use; %case to view all
%MCconfig.class2view1 = setdiff(MCconfig.class2use, {'Asterionellopsis' 'Chaetoceros' 'bad' 'detritus' 'mix' 'Laboea'}); %example to skip a few
%MCconfig.class2view1 = intersect(MCconfig.class2use, {'Chaetoceros' 'Chaetoceros_flagellate' 'Chaetoceros_pennate' ...
%'diatom_flagellate' 'Chaetoceros_other' 'Chaetoceros_didymus' ...
%'Chaetoceros_didymus_flagellate' }); %example to select a few
MCconfig.class2view1 = intersect(MCconfig.class2use, { 'Guinardia' 'other' 'detritus' 'unclassified' 'G_delicatula_parasite'});
%MCconfig.class2view1 = intersect(MCconfig.class2use, { 'unclassified'});

if ~exist(MCconfig.resultpath, 'dir'),
    dos(['mkdir ' resultpath]);
end;

end

