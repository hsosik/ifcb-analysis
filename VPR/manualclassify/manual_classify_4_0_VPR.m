function [  ] = manual_classify_4_0_VPR( MCconfig )
%function [  ] = manual_classify_4_0_VPR( MCconfig )
%manual_classify_2_0.m
%Main script for manual IFCB roi classification
%User selects paths for data and results and sets "pick_mode" for type of
%classification (e.g., starting from scratch with a new list of categories,
%or correcting an automated classifier, etc.)
%
%Requires several scripts / functions:
%   makescreen.m
%   select_category.m
%   get_classlist.m
%   get_roi_indices.mo
%   fillscreen.m
%   selectrois.m
%   stitchrois.m
%
%Heidi M. Sosik, Woods Hole Oceanographic Institution, 8 June 2009
%
%(Version 2.0 heavily modified from manual_classify_stream2b)
%
%Version 2_2 - Heidi 9/29/09. Fixed bug with mark_col when using both class2view1 and
%class2view2 (now shows marks on back one screen within class); also includes previous bug fix for raw_roi mode to avoid
%stopping on no existing class file or result file.
%Version 3 - Heidi 11/5/09. Modified to display overlapping rois as one
%stiched image. Added call to stitchrois.m
%Version 3_1 - Heidi 1/6/10. Modified to handle cases with no stitched rois.
%Also modified to skip saving a result file if no roi categories are changed (includes modifications to get_classlist and selectrois to omit save steps).
%1/12/10 modified fillscreen to skip zero-sized rois
%1/13/10 modified in if change_flag loop so that subdivide ID overrides a previous main manual column ID
%Version 3_2 - Heidi 11/10/11. Modified to address bug with missing class2use_sub? for cases
%with multiple subdivides; added back -append option on save (previously removed in 1/6/10 version)
%includes modifications to get_classlist.m
%Version 4_0 - Heidi 6/13/11. Refactor to run as function with filelist and config structure as input,
%intended to replace both manual_classify_3_2 and manual_classify_3_2_batch,
%no plan to change functions already called by those scripts
%23 Aug 2013, revise to pass filelists in as part of MCconfig structure
% Aug 2014, revise to address bug #3037, where zero-sized ROIs were previously annotated with default class in 'raw_roi' mode


global figure_handle listbox_handle1 listbox_handle2 instructions_handle listbox_handle3
close all
resultpath = MCconfig.resultpath;
filenum2start = MCconfig.filenum2start;
pick_mode = MCconfig.pick_mode;
class2use = MCconfig.class2use;
filelist = MCconfig.filelist;
classfiles = MCconfig.classfiles;
stitchfiles = MCconfig.stitchfiles;
classnum_default = strmatch(MCconfig.default_class, MCconfig.class2use, 'exact'); %USER class for default
class2use_pick1 = MCconfig.class2use; %to set button labels
class2use_manual = MCconfig.class2use;
[~,class2view1] = intersect(class2use, MCconfig.class2view1); %1:length(class2use);
class2use_sub = [];
classstr = [];
classnum_default_sub = [];
class2view2 = [];
class2use_pick2 = class2use_sub; %to set button labels
setsize = MCconfig.setsize; %1000;

switch pick_mode
    case 'raw_roi' %pick classes from scratch
        class2use_auto = [];
    case 'correct_or_subdivide'  %make subcategories starting with an automated class
        class2use_auto = class2use;
    otherwise
        disp('Invalid pick_mode. Check setting in get_MCconfig')
        return
end;

%IFCB largest possible image settings
camx = 1381;  %changed from 1380, heidi 8/18/06
camy = 1035;  %camera image size, changed from 1034 heidi 6/8/09
border = 3; %to separate images

%make the collage window
[figure_handle, listbox_handle1, listbox_handle2, instructions_handle, listbox_handle3] = makescreen(class2use_pick1, class2use_pick2,MCconfig);

for filecount = filenum2start:length(filelist),
    disp(['File number: ' num2str(filecount)])
    [~,outfile] = fileparts(filelist{filecount}); outfile = [outfile '.mat'];
    if ~strcmp(pick_mode, 'raw_roi') & ~exist([filelist{filecount} '.roi']) & ~exist(classfiles{filecount}),
        %if ~exist([resultpath streamfile '.mat']) & ~exist([classpath filelist(filecount).name(1:end-4) class_filestr '.mat']),
        disp('No class file and no existing result file. You must choose pick_mode "raw_roi" or locate a valid class file.')
        return
    end;
    if isempty(classfiles),
        classfile_temp = 'temp';
    else
        classfile_temp = classfiles{filecount};
    end;
    roipath = fileparts(filelist{filecount});
    %    roilist = dir([roipath filesep '*.tif']);
    %    roilist = {roilist.name}';
    eval(['[s,roilist] = dos(''dir ' roipath filesep '*.tif /B'');'])
    tt = strfind(roilist, char(10)); tt = tt(1)-1;
    roilist = regexprep(roilist, char(10), '');
    roilist = cellstr(reshape(roilist,tt,length(roilist)/tt)');
    [ classlist, sub_col, list_titles, newclasslist_flag ] = get_classlistTB( [resultpath outfile],classfile_temp, pick_mode, class2use_manual, class2use_sub, classstr, classnum_default, classnum_default_sub, length(roilist) );
    if isempty(classlist), %indicates bad class2use match
        return
    end;
    
    mark_col = 2; %added back 11 jan 2010
    if ~isempty(sub_col),
        eval(['class2use_sub' num2str(sub_col) '= class2use_sub;'])
        mark_col = sub_col; %reset col for ID in classlist
    end;
    
    disp(filelist{filecount}), disp([num2str(length(roilist)) ' total ROI events'])
    view_num = 1;
    class2view = class2view1;
    class2use_now = class2use;
    class_with_rois = [];
    classcount = 1;
    while classcount <= length(class2view),
        classnum = class2view(classcount);
        roi_ind_all = get_roi_indices(classlist, classnum, pick_mode, sub_col, view_num);
        if ~isempty(roi_ind_all),
            class_with_rois = [class_with_rois classcount]; %keep track of which classes to jump back (i.e., which have ROIs)
            %read roi images
            setnum = ceil(length(roi_ind_all)./setsize);
            imgset = 0;
            while imgset < setnum,
                imgset = imgset + 1
                next_ind = 1; %start with the first roi
                next_ind_list = next_ind; %keep track of screen start indices within a class
                imagedat = {};
                startrange = imgset*setsize-setsize;
                setrange = (startrange+1):min([imgset*setsize, length(roi_ind_all)]);
                roi_ind = roi_ind_all(setrange);
                for imgcount = 1:length(roi_ind)
                    imagedat{imgcount} = imresize(imread(fullfile(roipath,roilist{roi_ind(imgcount)})),MCconfig.imresize_factor);
                end;
                
                if ~isempty(imagedat),
                    
                    %sorts images by size instead of roi_ind 08/06/2013 Yannick
                    
                    switch MCconfig.displayed_ordered
                        case 'size'
                            [nrows, ncols]=cellfun(@size, imagedat); %find the size of each image
                            size_images=[nrows; ncols]';%make a matrix of the sizes
                            [~,II]=sortrows(size_images,[-2,-1]); %Sorted by deacreasing height then width
                            %reorders the roi_ind and the imagedat
                            imagedat=imagedat(II);
                            roi_ind=roi_ind(II);
                        case 'roi_index'
                        otherwise
                    end
                    
                    while next_ind <= length(roi_ind),
                        disp(next_ind)
                        change_col = 2; if view_num > 1, change_col = sub_col;, end; %1/15/10 to replace mark_col in call to fillscreen
                        [next_ind_increment, imagemap] = fillscreen(imagedat(next_ind:end),roi_ind(next_ind:end), camx, camy, border, [class2use_now(classnum) filelist{filecount}], classlist, change_col, classnum);
                        next_ind = next_ind + next_ind_increment - 1;
                        figure(figure_handle)
                        [ classlist, change_flag, go_back_flag ] = selectrois(instructions_handle, imagemap, classlist, class2use_pick1, class2use_pick2, mark_col, MCconfig.maxlist1);
                        set(instructions_handle, 'string', ['Use mouse button to choose category. Then click on ROIs. Hit ENTER key to stop choosing.'], 'foregroundcolor', 'k')
                        disp(change_flag)
                        disp(go_back_flag)
                        %keyboard
                        if change_flag,
                            if ~isempty(sub_col),  %strncmp(pick_mode, 'subdiv',6)
                                %reassign manual column (#2) with relevant sub_col entries
                                % keyboard
                                %next line presumes that a manual column ID should NOT be overridden by a subsequent sub_col ID (e.g., put in main ciliate categoryfirst, then move to subdivided catetory
                                %classlist(~isnan(classlist(:,sub_col)) & ~isnan(classlist(:,2)) & classlist(:,2) ~= strmatch(classstr, class2use_manual), sub_col) = NaN;
                                %1/15/10, recast above so the subdivide ID overrides instead (i.e., just skip above line)
                                classlist(classlist(:,sub_col) >= 1,2) = strmatch(classstr, class2use_manual);  %reassign manual column (#2) with relevant sub_col entries
                                classlist(classlist(:,2) == strmatch(classstr, class2use_manual) & isnan(classlist(:,sub_col)), sub_col) = classnum_default_sub;  % = 2; changed 1/15/10 ??correct??
                                eval(['class2use_sub' num2str(sub_col) '= class2use_sub;'])
                                mark_col = sub_col; %reset col for ID in classlist %comment out 9/29/09 Heidi
                            end;
                            %save([resultpath streamfile], 'classlist', 'class2use_auto', 'class2use_manual', 'class2use_sub*', 'list_titles', '-append'); %omit append option, 6 Jan 2010
                            save([resultpath outfile], 'classlist', 'class2use_auto', 'class2use_manual', 'class2use_sub*', 'list_titles'); %omit append option, 6 Jan 2010
                        end;
                        clear change_flag
                        if go_back_flag,
                            %keyboard
                            if length(next_ind_list) == 1, %start of a set
                                if imgset > 1 %case to go back one set in same class
                                    imgset = imgset - 2;
                                    next_ind_list = [];
                                    next_ind = length(roi_ind)+1; %make sure it leaves on next while
                                else %imgset == 1,%case for back one whole class
                                    if length(class_with_rois) <= 1,  %just go back to start of file
                                        next_ind = 1;
                                        if class_with_rois == 1,
                                            set(instructions_handle, 'string', ['NOT POSSIBLE TO BACKUP PAST THE START OF A FILE! Restart on previous file if necessary.'], 'foregroundcolor', 'r')
                                        end;
                                        classcount = 0;
                                        class_with_rois = [];
                                    else %back up to next class with rois in it
                                        classcount = class_with_rois(end-1) - 1;
                                        class_with_rois(end-1:end) = [];
                                        imgset = setnum; %make sure it leaves on next while
                                    end;
                                end;
                            else %go back one screen in same class
                                next_ind = next_ind_list(end-1);
                                next_ind_list(end-1:end) = [];
                            end;
                        end;
                        next_ind_list = [next_ind_list next_ind]; %keep track of screen starts within a class to go back
                    end;  %
                end; %if ~isempty(imagedat),
                %imgset = imgset + 1;
            end; %for imgset = 1:setnum
        end; %if ~isempty(roi_ind_all)
        classcount = classcount + 1;
    end; %while classcount
end
