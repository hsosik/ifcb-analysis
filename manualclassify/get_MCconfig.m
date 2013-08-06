function [ MCconfig ] = get_MCconfig(MCconfig)
%function [ MCconfig ] = get_MCconfig(  )
%   Detailed explanation goes here

%if no variables were input when start_manual_classify those variables need
%to be entered here.
if ~isfield(MCconfig,'batchmode') 
    MCconfig=struct('batchmode','no'); %['yes' or 'no'] in batchmode you will be looking at only one class for all files    
    MCconfig.batch_class_index =162;% in batch mode this is the index of the class to look at.
    MCconfig.filenum2start=1;  %USER select file number to begin within the chosen set (in batch mode this is likely 1)
end


MCconfig.filepath = 'D2013/D20130620/'; %this is the folder and or file you want to look at (not used in batchmode)
%MCconfig.filepath = 'D2013/D20130426/D20130426T163234_IFCB011.adc';
%MCconfig.pick_mode = 'correct_or_subdivide'; %USER choose one from case list below
MCconfig.pick_mode = 'raw_roi';


%group specific options
MCconfig.group='Sherbrooke' %MVCO, Sherbrooke
switch MCconfig.group
    case 'Sherbrooke'
        
        MCconfig.resultpath ='/Users/profileur/whoi_data/output_manual_classify/';
        MCconfig.basepath = '/Users/profileur/whoi_data/';
        MCconfig.class2use = importfile_species_list('/Users/profileur/whoi_data/manualclassify/Montjoie_species_20130404T173307.txt');%loading data from .txt file
 
    case 'MVCO'
        MCconfig.resultpath ='I:';
        MCconfig.resultpath = 'C:\work\IFCB11\Manual\'; %USER set
        MCconfig.resultpath = 'C:\work\IFCB010\ManualClassify\'; %USER set
        temp = load('class2use_MVCOmanual3', 'class2use'); %USER load yours here
        MCconfig.class2use = temp.class2use;
end

%this allows displaying the images ordered by size.
%Options are:   'roi_index'     for ordering as they were measured
%               'size'          for ordering by decreasing size of images
MCconfig.displayed_ordered = 'size'; 
MCconfig.classpath = '';
MCconfig.class_filestr = ''; %USER set, string appended on roi name for class files

MCconfig.default_class = 'Other';



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
end

%MCconfig.class2view1 = setdiff(MCconfig.class2use, {'bad' 'mix'}); %example to skip a few
%MCconfig.class2view1 = intersect(MCconfig.class2use, {'pennate' 'mix'}); %example to select a few
MCconfig.class2view2 = { }; %example to skip view2
%MCconfig.class2view2 = { 'all' }; %example to view all

if ~exist(MCconfig.resultpath, 'dir'),
    dos(['mkdir ' resultpath]);
end;

end
