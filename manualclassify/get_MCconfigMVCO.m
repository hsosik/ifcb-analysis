function [ MCconfig ] = get_MCconfigMVCO( MCconfig )
%function [ MCconfig ] = get_MCconfigMVCO(  )
%   Detailed explanation goes here
%MCconfig.filenum2start = 182;  %In the middle of batch classifying lepto
%1-25-13

if ~isfield(MCconfig, 'filenum2start'),
    MCconfig.filenum2start = 1;  %USER select file number to begin (within the chosen set)
end;

MCconfig.pick_mode = 'correct_or_subdivide'; %USER choose one from case list
%MCconfig.pick_mode = 'raw_roi';

MCconfig.resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\'; %USER set
MCconfig.class_filestr = '_class_v1'; %USER set, string appended on roi name for class files

temp = load('class2use_MVCOmanual3', 'class2use'); 
%MCconfig.class2use = [temp.class2use 'unclassified'];
MCconfig.class2use = temp.class2use;
MCconfig.default_class = 'other';
temp = load('class2use_MVCOciliate', 'class2use_sub4'); 
MCconfig.class2use_sub = temp.class2use_sub4;
MCconfig.sub_default_class = 'Ciliate_mix';
MCconfig.classstr = 'ciliate';
big_only = 0; %case for picking Laboea and tintinnids only

%this allows displaying the images ordered by size.
%Options are:   'roi_index'     for ordering as they were measured
%               'size'          for ordering by decreasing size of images
MCconfig.displayed_ordered = 'size'; 

switch MCconfig.batchmode
    case 'yes'
        if ischar(MCconfig.batch_class_index) %case when the name is given
            MCconfig.class2view1 = MCconfig.batch_class_index; %if you want to see one file by index
        else %case where the number is given
            MCconfig.class2view1 = MCconfig.class2use(MCconfig.batch_class_index); %if you want to see one file by index        
        end
        MCconfig.filepath='D*.mat';
    case 'no'
         MCconfig.class2view1 = MCconfig.class2use; %case to view all
        %MCconfig.class2view1 = { }; %example to skip view1 
        %MCconfig.class2view1 = setdiff(MCconfig.class2use, {'bad' 'mix'}); %example to skip a few
        %MCconfig.class2view1 = intersect(MCconfig.class2use, {'Ditylum'});
        %%example to select a few
end


if ~isfield(MCconfig, 'class2view1'),
   
end;
MCconfig.class2view2 = MCconfig.class2use_sub; %case to view all ciliates
%MCconfig.class2view2 = { }; %example to skip view2

if ~exist(MCconfig.resultpath, 'dir'),
    dos(['mkdir ' MCconfig.resultpath]);
end;

end

