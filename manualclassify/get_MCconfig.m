function [ MCconfig ] = get_MCconfig(MCconfig)
%function [ MCconfig ] = get_MCconfig( MCconfig  )
%   configures most of the setup for manual_classify_4_0.m
%   MCconfig is a structure passed in and out again, contains the settings for file paths, classes to view, etc.    
%   Heidi M. Sosik, Woods Hole Oceanographic Institution, 

%   revised August 2013 to incorporate settings previously done in get_MCfilelist. m
%   April 2015, revised to remove subdivide functionality and recast for manual_classify_4_1

%Some DEFAULT settings
%USER - DO NOT CHANGE these, copy desired lines to your case below and change as there
MCconfig.pick_mode = 'raw_roi';  %CHOICES 'raw_roi' or 'correct_classifier'
MCconfig.displayed_ordered = 'size'; %CHOICES 'size' (images appear by decreasing size) or 'roi_index' (images in order acquired)
MCconfig.alphabetize='no' ; %CHOICES yes= alphabetize the list in the identification window, no = do not alphabetize the list.
MCconfig.classfiles = [];
MCconfig.stitchfiles = [];
MCconfig.maxlist1 = 60; %default length of category list box before split to second box
MCconfig.setsize = 200; %how many images to read before displaying 
MCconfig.bar_length_micron = 10; %scale bar length in microns, enter 0 for no bar displayed
MCconfig.x_pixel_threshold = 150;  %cutoff in pixels, 1=no threshold
MCconfig.y_pixel_threshold = 75; %cutoff in pixels, 1=no threshold
MCconfig.threshold_mode = 0; %0 = show all, 1 = show larger than 1 or both thresholds, 2 = show smaller than both thresholds
MCconfig.imresize_factor = 1; %image display scale factor, 1 for no scaling
MCconfig.verbose = 1; %0 = off, suppresses output to command line for classes with no ROIs
MCconfig.list_fontsize = 8;       
%USER - DO NOT CHANGE above lines, copy desired lines to your case below and change as there

switch MCconfig.group
    case 'Sherbrooke'
        MCconfig.resultpath ='/Users/profileur/whoi_data/output_manual_classify/';
        MCconfig.basepath = '/Users/profileur/whoi_data/';
        MCconfig.filepath = 'D2013/D20130426/'; %this is the folder and or file you want to look at (not used in batchmode)
        MCconfig.pick_mode = 'raw_roi';
        MCconfig.class2use = importfile_species_list('/Users/profileur/whoi_data/manualclassify/Montjoie_species_20130404T173307.txt');%loading data from .txt file
        MCconfig.class_filestr = ''; %USER set, string appended on roi name for class files
        MCconfig.default_class = 'Other';
        MCconfig.class2view2 = { }; %example to skip view2
        MCconfig.classpath = '';
        MCconfig.displayed_ordered = 'size'; %CHOICES 'size' (images appear by decreasing size) or 'roi_index' (images in order acquired)
        MCconfig.alphabetize='no' ; %CHOICES yes= alphabetize the list in the identification window, no = do not alphabetize the list.
        switch MCconfig.batchmode
            case 'no'
                MCconfig.filelist = dir([MCconfig.basepath MCconfig.filepath '*.adc']);
            case 'yes'
                MCconfig.filelist = dir([MCconfig.resultpath MCconfig.filepath]);
        end
        [MCconfig.filelist, MCconfig.classfiles] = resolve_files(MCconfig.filelist, MCconfig.basepath, MCconfig.classpath, MCconfig.class_filestr);
    case 'MVCO'
        MCconfig.maxlist1 = 75;
        MCconfig.setsize = 200; %how many images to read before displaying 
        MCconfig.pixel_per_micron= 3.4; %pixel to micrometer conversion factor DO NOT ASSUME THIS VALUE APPLIES FOR YOUR DATA
        MCconfig.bar_length_micron = 10; %scale bar length in microns, enter 0 for no bar displayed
        MCconfig.x_pixel_threshold = 150;  %cutoff in pixels, 1=no threshold
        MCconfig.y_pixel_threshold = 75; %cutoff in pixels, 1=no threshold
        MCconfig.threshold_mode = 0; %0 = show all, 1 = show larger than 1 or both thresholds, 2 = show smaller than both thresholds
        %MCconfig.bar_height_micron = 2; %scale bar height in microns
        MCconfig.verbose = 1; %0 = off, suppresses output to command line for classes with no ROIs
        MCconfig.list_fontsize = 8;
        MCconfig.imresize_factor = 1; %image display scale factor, 1 for no scaling
        MCconfig.resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\'; %USER set
        %MCconfig.resultpath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\Manual_fromClass\'; %USER set
        temp = load('class2use_MVCOmanual5', 'class2use'); %USER load yours here
        MCconfig.pick_mode = 'raw_roi';
        MCconfig.displayed_ordered = 'size'; %CHOICES 'size' (images appear by decreasing size) or 'roi_index' (images in order acquired)
        MCconfig.alphabetize='no' ; %CHOICES yes= alphabetize the list in te identification window, no = do not alphabetize the list.
        MCconfig.class2use = temp.class2use;
        MCconfig.class_filestr = '_class_v1'; %USER set, string appended on roi name for class files
        MCconfig.default_class = 'unclassified';
        MVCOfilelisttype ='thislist'; %manual_list, loadfile, dirlist
        switch MVCOfilelisttype
            case 'manual_list' %MVCO batch system
                MCconfig.filelist = get_filelist_manual([MCconfig.resultpath 'manual_list'],5,[2014], 'all'); %manual_list, column to use, year to find
            case 'loadfile'
                load current_filelist.mat
                MCconfig.filelist = filelist; 
            case 'dirlist' %other MVCO cases
                temp = dir('\\sosiknas1\IFCB_data\MVCO\data\2012\IFCB5_2012_006\IFCB5_2012_006_12*.adc'); temp = char(temp.name);
                MCconfig.filelist = cellstr(temp(:,1:end-4)); clear temp
            case 'thislist'
                MCconfig.filelist = {'IFCB1_2006_158_010552' 'IFCB5_2011_208_193851' 'IFCB5_2011_075_172900'  'IFCB1_2010_285_001802'}; 
        end
        [MCconfig.filelist, MCconfig.classfiles, MCconfig.stitchfiles] = resolve_MVCOfiles(MCconfig.filelist, MCconfig.class_filestr);
        %pick one
%        MCconfig.class2view1 = MCconfig.class2use; %case to view all
        %MCconfig.class2view1 = setdiff(MCconfig.class2use,{'Asterionellopsis' 'Chaetoceros' 'bad' 'detritus' 'mix'}); %example to skip a few
        %MCconfig.class2view1 = intersect(MCconfig.class2use, {'other'}); %example to select a few
        %MCconfig.class2view1 = intersect(MCconfig.class2use, {'leptocylindrus' 'other' 'mix_elongated'}); %example to select a few
    case 'OKEX'
        MCconfig.resultpath = '/home/ifcb/ifcb_010_data/manual/'; %USER set
        MCconfig.basepath = '/home/ifcb/ifcb_010_data/'; %USER set
        MCconfig.filepath = '/';
        MCconfig.pick_mode = 'correct_classifier';
        MCconfig.displayed_ordered = 'size'; %CHOICES 'size' (images appear by decreasing size) or 'roi_index' (images in order acquired)
        MCconfig.alphabetize='no' ; %CHOICES yes= alphabetize the list in the identification window, no = do not alphabetize the list.
        temp = load('class2use_MVCOmanual3', 'class2use'); %USER load yours here
        MCconfig.class2use = temp.class2use;
        MCconfig.classpath = '/home/ifcb/ifcb_010_data/class/'; 
        MCconfig.class_filestr = '_class_v1'; %USER set, string appended on roi name for class files
        MCconfig.default_class = 'other';
        temp = load('class2use_MVCOciliate', 'class2use_sub4'); 
        filelisttype = 'loadfile'; %manual_list, loadfile, dirlist
        switch filelisttype
            case 'manual_list' % batch system
                MCconfig.filelist = get_filelist_manual_EB([MCconfig.resultpath 'manual_listEB'],5,[2013], 'all'); %manual_list, column to use, year to find
            case 'loadfile'
                load filelist_extranans_bigonly
                MCconfig.filelist = filelist; 
            case 'dirlist' %other MVCO cases
                temp = dir('\\demi\vol1\IFCB5_2012_006\IFCB5_2012_006_025*.adc'); temp = char(temp.name);
                MCconfig.filelist = cellstr(temp(:,1:end-4)); clear temp
        end
        [MCconfig.filelist, MCconfig.classfiles] = resolve_files_OKEX(MCconfig.filelist, MCconfig.basepath, MCconfig.classpath, MCconfig.class_filestr);
    case 'SEA2007'
        MCconfig.resultpath = '\\Queenrose\ifcb2_c211a_sea2007\Manual_fromClass\'; %USER set
        MCconfig.basepath = '\\Queenrose\ifcb2_c211a_sea2007\data\'; %USER set
        temp = load('class2use_MVCOmanual3', 'class2use'); %USER load yours here
        MCconfig.pick_mode = 'correct_classifier';
        MCconfig.displayed_ordered = 'size'; %CHOICES 'size' (images appear by decreasing size) or 'roi_index' (images in order acquired)
        MCconfig.alphabetize='no' ; %CHOICES yes= alphabetize the list in the identification window, no = do not alphabetize the list.
        MCconfig.class2use = temp.class2use;
        MCconfig.class_filestr = '_class_v1'; %USER set, string appended on roi name for class files
        MCconfig.classpath = '\\Queenrose\ifcb2_c211a_sea2007\data\class2007_v1\'; 
        MCconfig.default_class = 'unclassified';
        temp = load('class2use_MVCOciliate', 'class2use_sub4'); 
        MCconfig.class2use_sub = temp.class2use_sub4;
        MCconfig.sub_default_class = 'Ciliate_mix';
        MCconfig.classstr = 'ciliate';
        MCconfig.class2view2 = MCconfig.class2use_sub; %example to view all
        MCconfig.class2view2 = {}; %example to skip view2
        %MCconfig.class2view2 = {'Laboea' 'Tintinid' };
        MVCOfilelisttype ='loadfile'; %manual_list, loadfile, dirlist
        switch MVCOfilelisttype
            case 'manual_list' %MVCO batch system
                MCconfig.filelist = get_filelist_manual([MCconfig.resultpath 'manual_list'],5,[2012], 'all'); %manual_list, column to use, year to find
            case 'loadfile'
                load cael_filelist2.mat
                MCconfig.filelist = filelist; 
            case 'dirlist' %other MVCO cases
                temp = dir('\\Queenrose\ifcb2_c211a_sea2007\data\class2007_v1\*'); temp = char(temp.name);
                MCconfig.filelist = cellstr(temp(3:end,1:end-13)); clear temp
        end
        [MCconfig.filelist, MCconfig.classfiles] = resolve_files_SEA2007(MCconfig.filelist, MCconfig.basepath, MCconfig.classpath, MCconfig.class_filestr);
        %pick one
        MCconfig.class2view1 = MCconfig.class2use; %case to view all
        MCconfig.class2view1 = intersect(MCconfig.class2use, {'detritus'}); %example to select a few
    case 'GEOCAPE'
        MCconfig.resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\'; %USER set
        temp = load('class2use_MVCOmanual3', 'class2use'); %USER load yours here
        MCconfig.pick_mode = 'correct_classifier';
        MCconfig.displayed_ordered = 'size'; %CHOICES 'size' (images appear by decreasing size) or 'roi_index' (images in order acquired)
        MCconfig.alphabetize='no' ; %CHOICES yes= alphabetize the list in the identification window, no = do not alphabetize the list.
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
                temp = dir('\\queenrose\IFCB101_GEOCAPE_GOMEX20132\data\IFCB2_2007_176_071823*.adc'); temp = char(temp.name);
                MCconfig.filelist = cellstr(temp(:,1:end-4)); clear temp
        end
        [MCconfig.filelist, MCconfig.classfiles, MCconfig.stitchfiles] = resolve_MVCOfiles(MCconfig.filelist, MCconfig.class_filestr);
        %pick one
        MCconfig.class2view1 = MCconfig.class2use; %case to view all
      case 'Ditylum_culture'
        MCconfig.resultpath = '\\QUEENROSE\IFCB14_Dock\ditylum\Manual\'; %USER set
        MCconfig.basepath = '\\QUEENROSE\IFCB14_Dock\ditylum\data\'; %USER set
        %temp = load('class2use_MVCOmanual3', 'class2use'); %USER load yours here
        %MCconfig.class2use = temp.class2use;
        MCconfig.pick_mode = 'raw_roi';
        MCconfig.displayed_ordered = 'roi_index'; %CHOICES 'size' (images appear by decreasing size) or 'roi_index' (images in order acquired)
        MCconfig.alphabetize='no' ; %CHOICES yes= alphabetize the list in the identification window, no = do not alphabetize the list.
        MCconfig.class2use = {'Ditylum', 'Ditylum_with_sperm', 'sperm_free', 'possible_eggs', 'detritus', 'other'};
        MCconfig.class_filestr = '_class_v1'; %USER set, string appended on roi name for class files
        MCconfig.classpath = ''; 
        MCconfig.default_class = 'Ditylum';
        MCconfig.class2view2 = {}; %example to skip view2
        %MCconfig.class2view2 = {'Laboea' 'Tintinid' };
        filelisttype ='dirlist'; %manual_list, loadfile, dirlist
        switch filelisttype
            case 'loadfile'
                load cael_filelist2.mat
                MCconfig.filelist = filelist; 
            case 'dirlist' %other MVCO cases
                temp = dir('\\QUEENROSE\IFCB14_Dock\ditylum\data\D20140715*.roi'); temp = char(temp.name);
                %MCconfig.filelist = cellstr(temp(3:end,1:end-13)); clear temp
                MCconfig.filelist = cellstr(temp(:,1:end-4)); clear temp
        end
        [MCconfig.filelist, MCconfig.classfiles] = resolve_files_SEA2007(MCconfig.filelist, MCconfig.basepath, MCconfig.classpath, MCconfig.class_filestr);
        %pick one
        MCconfig.class2view1 = MCconfig.class2use; %case to view all
        %MCconfig.class2view1 = intersect(MCconfig.class2use, {'detritus'}); %example to select a few
        
        case 'TAMUG'
            MCconfig.resultpath = 'c:\ifcb\manual\'; %USER set
            MCconfig.basepath = 'c:\ifcb\data\'; %USER set
            MCconfig.pick_mode = 'raw_roi';
            MCconfig.displayed_ordered = 'size'; %CHOICES 'size' (images appear by decreasing size) or 'roi_index' (images in order acquired)
            MCconfig.alphabetize='no' ; %CHOICES yes= alphabetize the list in the identification window, no = do not alphabetize the list.
            %temp = load('class2use_MVCOmanual3', 'class2use'); %USER load yours here
            %MCconfig.class2use = temp.class2use;
            MCconfig.class2use = {'dinoflagellates', 'diatoms', 'misc_nano', 'detritus', 'other', 'ciliates'};
            MCconfig.class_filestr = '_class_v1'; %USER set, string appended on roi name for class files
            MCconfig.classpath = ''; 
            MCconfig.default_class = 'other';
            MCconfig.class2view2 = {}; %example to skip view2
            %MCconfig.class2view2 = {'Laboea' 'Tintinid' };
            filelisttype ='dirlist'; %manual_list, loadfile, dirlist
            switch filelisttype
                case 'loadfile'
                    load cael_filelist2.mat
                    MCconfig.filelist = filelist; 
                case 'dirlist' %other MVCO cases
                    temp = dir('c:\ifcb\data\D2014\D20140811\D2014*.roi'); temp = char(temp.name);
                    %MCconfig.filelist = cellstr(temp(3:end,1:end-13)); clear temp
                    MCconfig.filelist = cellstr(temp(:,1:end-4)); clear temp
            end
            [MCconfig.filelist, MCconfig.classfiles] = resolve_files(MCconfig.filelist, MCconfig.basepath, MCconfig.classpath, MCconfig.class_filestr);
            %pick one
            MCconfig.class2view1 = MCconfig.class2use; %case to view all
            %MCconfig.class2view1 = intersect(MCconfig.class2use, {'detritus'}); %example to select a few
        case 'VPR'
            %MCconfig.resultpath = '\\SosikNAS1\Lab_data\VPR\NBP1201\vpr3\manual_fromClass\'; %USER set
            %MCconfig.basepath = '\\SosikNAS1\Lab_data\VPR\NBP1201\vpr3\'; %USER set
            MCconfig.dataformat = 2; %VPR specific value
            MCconfig.resultpath = 'C:\work\vpr\vpr3\manual\'; %USER set
            MCconfig.basepath = 'C:\work\vpr\vpr3\'; %USER set
            MCconfig.pick_mode = 'correct_classifier';
            MCconfig.displayed_ordered = 'size'; %CHOICES 'size' (images appear by decreasing size) or 'roi_index' (images in order acquired)
            MCconfig.alphabetize='no' ; %CHOICES yes= alphabetize the list in the identification window, no = do not alphabetize the list.
            temp = load('C:\work\IFCB\code_svn\VPR\misc\class2use_vpr', 'class2use'); %USER load yours here
            MCconfig.class2use = temp.class2use;
            MCconfig.class_filestr = '_class_v1'; %USER set, string appended on roi name for class files
            %MCconfig.classpath = '\\SosikNAS1\Lab_data\VPR\NBP1201\vpr3\class_RossSea_Trees_09Mar2015\';
            MCconfig.classpath = 'C:\work\vpr\vpr3\class_RossSea_Trees_09Mar2015\';
            MCconfig.default_class = 'unknown';
            MCconfig.class2view2 = {}; %example to skip view2
            MCconfig.setsize = 200; %how many images to read before displaying 
            MCconfig.imresize_factor = 0.2; %image display scale factors
            MCconfig.bar_length_micron = 0; %scale bar length in microns, enter 0 for no bar displayed
            filelisttype ='dirlist'; %manual_list, loadfile, dirlist
            switch filelisttype
                case 'loadfile'
                    load mylist.mat
                    MCconfig.filelist = filelist; 
                case 'dirlist' 
                    temp = dir('C:\work\vpr\vpr3\class_RossSea_Trees_09Mar2015\N*.mat'); temp = char(temp.name);
                    MCconfig.filelist = cellstr(temp(:,1:end-13)); clear temp
            end
            [MCconfig.filelist, MCconfig.classfiles] = resolve_files_VPR(MCconfig.filelist, MCconfig.basepath, MCconfig.classpath, MCconfig.class_filestr);
           
            %pick one
            MCconfig.class2view1 = MCconfig.class2use; %case to view all
    otherwise
        disp('Invalid configuration case. Check options in get_MCconfig.m')
        return  
end

%default
%switch MCconfig.batchmode
    if isfield(MCconfig, 'batch_class_index') %field only exists if passed in
    %case 'yes'
        if ischar(MCconfig.batch_class_index) %case when the name is given
            MCconfig.class2view1 = MCconfig.batch_class_index; %if you want to see one file by index
        else %case where the number is given
            MCconfig.class2view1 = MCconfig.class2use(MCconfig.batch_class_index); %if you want to see one file by index        
        end
end


%defaults case if class2view1 not specified yet
if ~isfield(MCconfig,'class2view1')
        MCconfig.class2view1 = MCconfig.class2use; %case to view all
end;

if ~exist(MCconfig.resultpath, 'dir'),
    dos(['mkdir ' MCconfig.resultpath]);
end;

[~,f]= fileparts(MCconfig.filelist{1}); 
if isempty(f) & strmatch(MCconfig.group, 'VPR')
    MCconfig.dataformat = 2;
elseif f(1) == 'I',
    MCconfig.dataformat = 0;
elseif f(1) == 'D',
    MCconfig.dataformat = 1;
end;

if strcmp(MCconfig.pick_mode, 'correct_classifier')
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
