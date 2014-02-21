function [ MCconfig ] = get_MCconfig(MCconfig)
%function [ MCconfig ] = get_MCconfig( MCconfig  )
%   configures most of the setup for manual_classify_4_0.m
%   MCconfig is a structure passed in and out again, contains the settings for file paths, classes to view, etc.    
%   Heidi M. Sosik, Woods Hole Oceanographic Institution, 

%   revised August 2013 to incorporate settings previously done in get_MCfilelist. m

MCconfig.pick_mode = 'correct_or_subdivide'; %USER choose one 'correct_or_subdivide' (start from classifier or already sorted images) or 'raw_roi'
%MCconfig.pick_mode = 'raw_roi';

MCconfig.displayed_ordered = 'size'; %USER choose one 'size' (images appear by decreasing size) or 'roi_index' (images in order acquired)
%MCconfig.displayed_ordered = 'roi_index'; 

MCconfig.alphabetize='no' ; %yes= alphabetize the list in the identification window, no = do not alphabetize the list.

MCconfig.classfiles = [];
MCconfig.stitchfiles = [];

%group specific options
MCconfig.group = 'MVCO'; %MVCO, Sherbrooke, OKEX

%default
switch MCconfig.batchmode
    case 'yes'
        if ischar(MCconfig.batch_class_index) %case when the name is given
            MCconfig.class2view1 = MCconfig.batch_class_index; %if you want to see one file by index
        else %case where the number is given
            MCconfig.class2view1 = MCconfig.class2use(MCconfig.batch_class_index); %if you want to see one file by index        
        end
end

switch MCconfig.group
    case 'Sherbrooke'
        MCconfig.resultpath ='/Users/profileur/whoi_data/output_manual_classify/';
        MCconfig.basepath = '/Users/profileur/whoi_data/';
        MCconfig.filepath = 'D2013/D20130426/'; %this is the folder and or file you want to look at (not used in batchmode)
        MCconfig.class2use = importfile_species_list('/Users/profileur/whoi_data/manualclassify/Montjoie_species_20130404T173307.txt');%loading data from .txt file
        MCconfig.class_filestr = ''; %USER set, string appended on roi name for class files
        MCconfig.default_class = 'Other';
        MCconfig.class2view2 = { }; %example to skip view2
        MCconfig.classpath = '';
        switch MCconfig.batchmode
            case 'no'
                MCconfig.filelist = dir([MCconfig.basepath MCconfig.filepath '*.adc']);
            case 'yes'
                MCconfig.filelist = dir([MCconfig.resultpath MCconfig.filepath]);
        end
        [MCconfig.filelist, MCconfig.classfiles] = resolve_files(MCconfig.filelist, MCconfig.basepath, MCconfig.classpath, MCconfig.class_filestr);
    case 'MVCO'
        MCconfig.resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\'; %USER set
        temp = load('class2use_MVCOmanual3', 'class2use'); %USER load yours here
        MCconfig.class2use = temp.class2use;
        MCconfig.class_filestr = '_class_v1'; %USER set, string appended on roi name for class files
        MCconfig.default_class = 'unclassified';
        temp = load('class2use_MVCOciliate', 'class2use_sub4'); 
        MCconfig.class2use_sub = temp.class2use_sub4;
        MCconfig.sub_default_class = 'Ciliate_mix';
        MCconfig.classstr = 'ciliate';
        %MCconfig.class2view2 = MCconfig.class2use_sub; %example to view all
        %MCconfig.class2view2 = {}; %example to skip view2
        MCconfig.class2view2 = {'Laboea' 'Tintinid' };
        MVCOfilelisttype ='manual_list'; %manual_list, loadfile, dirlist
        switch MVCOfilelisttype
            case 'manual_list' %MVCO batch system
                MCconfig.filelist = get_filelist_manual([MCconfig.resultpath 'manual_list'],5,[2012], 'all'); %manual_list, column to use, year to find
            case 'loadfile'
                load current_filelist.mat
                MCconfig.filelist = filelist; 
            case 'dirlist' %other MVCO cases
                MCconfig.filelist = dir('\\demi\vol1\IFCB5_2012_006\IFCB5_2012_006_025*.adc');   
        end
        [MCconfig.filelist, MCconfig.classfiles, MCconfig.stitchfiles] = resolve_MVCOfiles(MCconfig.filelist, MCconfig.class_filestr);
        %pick one
        MCconfig.class2view1 = MCconfig.class2use; %case to view all
        %MCconfig.class2view1 = setdiff(MCconfig.class2use,{'Asterionellopsis' 'Chaetoceros' 'bad' 'detritus' 'mix'}); %example to skip a few
        MCconfig.class2view1 = intersect(MCconfig.class2use, {'other'}); %example to select a few
        %MCconfig.class2view1 = intersect(MCconfig.class2use, {'G_delicatula_parasite'}); %example to select a few
    case 'OKEX'
        MCconfig.resultpath = '/home/ifcb/ifcb_010_data/manual/'; %USER set
        MCconfig.basepath = '/home/ifcb/ifcb_010_data/'; %USER set
        MCconfig.filepaht = '/';
        temp = load('class2use_MVCOmanual3', 'class2use'); %USER load yours here
        MCconfig.class2use = temp.class2use;
        MCconfig.classpath = '/home/ifcb/ifcb_010_data/class/'; 
        MCconfig.class_filestr = '_class_v1'; %USER set, string appended on roi name for class files
        MCconfig.default_class = 'other';
        temp = load('class2use_MVCOciliate', 'class2use_sub4'); 
        MCconfig.class2use_sub = temp.class2use_sub4;
        MCconfig.sub_default_class = 'Ciliate_mix';
        MCconfig.classstr = 'ciliate';
        MCconfig.class2view2 = MCconfig.class2use_sub; %example to view all
        filelisttype = 'loadfile'; %manual_list, loadfile, dirlist
        switch filelisttype
            case 'manual_list' % batch system
                MCconfig.filelist = get_filelist_manual_EB([MCconfig.resultpath 'manual_listEB'],5,[2013], 'all'); %manual_list, column to use, year to find
            case 'loadfile'
                load filelist_extranans_bigonly
                MCconfig.filelist = filelist; 
            case 'dirlist' %other MVCO cases
                MCconfig.filelist = dir('\\demi\vol1\IFCB5_2012_006\IFCB5_2012_006_0*.adc');    
        end
        [MCconfig.filelist, MCconfig.classfiles] = resolve_files_OKEX(MCconfig.filelist, MCconfig.basepath, MCconfig.classpath, MCconfig.class_filestr);
    case 'GEOCAPE'
        MCconfig.resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\'; %USER set
        temp = load('class2use_MVCOmanual3', 'class2use'); %USER load yours here
        MCconfig.class2use = temp.class2use;
        MCconfig.class_filestr = '_class_v1'; %USER set, string appended on roi name for class files
        MCconfig.default_class = 'unclassified';
        temp = load('class2use_MVCOciliate', 'class2use_sub4'); 
        MCconfig.class2use_sub = temp.class2use_sub4;
        MCconfig.sub_default_class = 'Ciliate_mix';
        MCconfig.classstr = 'ciliate';
        MCconfig.class2view2 = MCconfig.class2use_sub; %example to view all
        %MCconfig.class2view2 = {}; %example to skip view2
        %MCconfig.class2view2 = {'Laboea' 'Tintinid' };
        MVCOfilelisttype ='dirlist'; %manual_list, loadfile, dirlist
        switch MVCOfilelisttype
            case 'manual_list' %MVCO batch system
                MCconfig.filelist = get_filelist_manual([MCconfig.resultpath 'manual_list'],5,[2012], 'all'); %manual_list, column to use, year to find
            case 'loadfile'
                load current_filelist.mat
                MCconfig.filelist = filelist; 
            case 'dirlist' %other MVCO cases
                MCconfig.filelist = dir('\\queenrose\IFCB101_GEOCAPE_GOMEX20132\data\*.adc');   
        end
        [MCconfig.filelist, MCconfig.classfiles, MCconfig.stitchfiles] = resolve_MVCOfiles(MCconfig.filelist, MCconfig.class_filestr);
        %pick one
        MCconfig.class2view1 = MCconfig.class2use; %case to view all
        %MCconfig.class2view1 = setdiff(MCconfig.class2use,{'Asterionellopsis' 'Chaetoceros' 'bad' 'detritus' 'mix'}); %example to skip a few
        %MCconfig.class2view1 = intersect(MCconfig.class2use, {'other'}); %example to select a few
        %MCconfig.class2view1 = intersect(MCconfig.class2use,
        %{'G_delicatula_parasite'}); %example to select a few
end

%defaults case if class2view1 not specified yet
if ~isfield(MCconfig,'class2view1')
        MCconfig.class2view1 = MCconfig.class2use; %case to view all
end;

if ~exist(MCconfig.resultpath, 'dir'),
    dos(['mkdir ' resultpath]);
end;

[~,f]= fileparts(MCconfig.filelist{1}); 
if f(1) == 'I',
    MCconfig.dataformat = 0;
elseif f(1) == 'D',
    MCconfig.dataformat = 1;
end;

if strcmp(MCconfig.pick_mode, 'correct_or_subdivide')
    if isempty(MCconfig.classfiles)
        disp('No class files specified. Check path setting in get_MCconfig if you want to load classifier results.')
        disp('Hit enter to continue without classifier results.')
        pause
    else
        if ~exist(MCconfig.classfiles{1}, 'file'),
            disp('First class file not found. Check path setting in get_MCconfig if you want to load classifier results.')
            disp('Hit enter to continue without classifier results.')
            pause
        end;
    end;
end;

end
