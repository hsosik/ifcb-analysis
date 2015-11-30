function [  ] = manual_classify_5_0( MCconfig_input )
%function [  ] = manual_classify_5_0( MCconfig )
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
%   get_roi_indices.m
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
% March 2015, begin upgrade transistion from manual_classify_4_0 to manual_classify_4_1, mainly to handle user initiated jumping among classes
% April 2015, upgrade largely complete with many new features including runtime navigation between classes and files
% April 2015, move to manual_classify_5_0 for integration with ManageMCconfig GUI

global figure_handle listbox_handle1 instructions_handle listbox_handle3 new_classcount new_setcount MCflags MCconfig new_filecount filecount filelist category select_remaining_button_handle

%close all
MCconfig = MCconfig_input; clear MCconfig_input %use this so MCconfig can now be global with callback functions
MCflags = struct('class_jump', 0, 'class_step', 0, 'file_jump', 0, 'changed_selectrois', 0, 'select_remaining', 0,...
    'newclasslist', NaN, 'go_back', 0, 'button', 1, 'file_jump_back_again', 0, 'reload_set', 0, 'new_figure', 1);
class2use = MCconfig.class2use;
if MCconfig.dataformat ~= 2, %2 is VPR, should be tif path
    filelist = regexprep(MCconfig.roifiles, '.roi', '');
else
    filelist = MCconfig.roifiles;
end
classnum_default = strmatch(MCconfig.default_class, MCconfig.class2use, 'exact');
class2use_manual = MCconfig.class2use'; %needs to be row vector
[~,class2view1] = intersect(class2use, MCconfig.class2view1);
class2view1 = sort(class2view1); %keep same order as class2use

switch MCconfig.pick_mode
    case 'raw_roi' %pick classes from scratch
        class2use_auto = [];
    case 'correct'  %make subcategories starting with an automated class
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
[figure_handle, listbox_handle1, listbox_handle3, instructions_handle] = makescreen(MCconfig.class2use); %, MCconfig);
str = get(listbox_handle1, 'string');
category = char(str(get(listbox_handle1, 'value'))); %initialize as first in left listbox
if isfield(MCconfig,'bar_length_micron')
    if MCconfig.bar_length_micron > 0
        MCconfig.bar_height_micron = 2;
        scale_bar_image1 = make_scale_bar(MCconfig.pixel_per_micron, MCconfig.bar_length_micron, MCconfig.bar_height_micron);
    else
        scale_bar_image1 = NaN;
    end
end

if MCconfig.dataformat == 0
    adcxind = 12;
    adcyind = 13;
    startbyteind = 14;
elseif MCconfig.dataformat == 1
    adcxind = 16;
    adcyind = 17;
    startbyteind = 18;
elseif MCconfig.dataformat == 2
    if ~exist([MCconfig.resultpath filesep 'roi_info'], 'dir')
        mkdir([MCconfig.resultpath filesep 'roi_info' filesep])
    end
end;

filecount = MCconfig.filenum2start;
threshold_warn = 0;
setpref('graphics','threshold_warning', 'ask') %reinitialize box display state each session
while filecount <= length(filelist),
    new_classcount = NaN; %initialize
    if MCconfig.threshold_mode ~= 1,
        threshold_warn = 1;
    end
    disp(['File number: ' num2str(filecount)])
    %[~,outfile] = fileparts(filelist{filecount}); outfile = [outfile '.mat'];
    if ~strcmp(MCconfig.pick_mode, 'raw_roi') & ~exist([filelist{filecount} '.roi']) & ~exist(MCconfig.classfiles{filecount}),
        disp('No class file and no existing result file. You must choose pick_mode "raw_roi" or locate a valid class file.')
        return
    end;
    
    clear roi_info
    roi_info = get_roi_info;
    stitch_info = [];
    if ~isempty(MCconfig.stitchfiles),
        if exist([MCconfig.stitchfiles{filecount}]), %exist([stitchpath streamfile '_roistitch.mat']),
            temp = load(MCconfig.stitchfiles{filecount}, 'stitch_info');
            stitch_info = temp.stitch_info; clear temp
        end;
    end;
    disp(filelist{filecount}), disp([num2str(numrois) ' total ROI events'])
    if isempty(MCconfig.classfiles),
        classfile_temp = 'temp';
    else
        classfile_temp = MCconfig.classfiles{filecount};
    end;
    
    [ classlist, list_titles, MCflags.newclasslist, default_class_original ] = get_classlistTB2( MCconfig.resultfiles{filecount},classfile_temp, MCconfig.pick_mode, class2use_manual, classnum_default, numrois, roi_info.x_all);
%     if MCconfig.dataformat <= 1 %IFCB only
%         if MCflags.newclasslist,  %only first time creating classlist
%             zero_ind = find(roi_info.x_all == 0);
%             classlist(zero_ind,2) = NaN; %mark zero-sized ROIs as NaNs in manual column (needed for raw_roi case where these are put in default class by get_classlistTB
%         end
%     end
    %special case to segregate dirt spots in Healy1101 data
    if isequal(MCconfig.resultfiles{filecount}(1:10), 'IFCB8_2011') && MCflags.newclasslist,
        classlist((adcdata(:,10) == 1118 & adcdata(:,11) == 290),2) = strmatch('bad', class2use_manual);
    end;
    if isempty(classlist), %indicates bad class2use match
        return
    end;
    if ~isempty(stitch_info),
        classlist(stitch_info(:,1)+1,2:3) = NaN; %force NaN class for second roi in pair to be stitched
    end;
    class2view = class2view1; %make sure resets back to initial for each new file
    switch MCconfig.alphabetize
        case {'yes',  1}
            [~, ix] = sort(lower(MCconfig.class2use(class2view)));
            class2view = class2view(ix);
    end
    classcount = 1;
    while classcount <= length(class2view) && ~MCflags.file_jump
        new_setcount = NaN; %initialize
        classnum = class2view(classcount);
        roi_ind_all = get_roi_indices(classlist, classnum, MCconfig.pick_mode);
        if MCconfig.dataformat == 2 %fudge for now to make VPR analysis subsets
            roi_ind_all = roi_ind_all(roi_ind_all <= 5000);
        end
        if ~isempty(roi_ind_all)
            if MCconfig.threshold_mode > 1
                if MCconfig.dataformat == 2
                    msgbox('Size thresholding not implemented for VPR tif case') %skip for VPR case
                    MCconfig.threshold_mode = 0;
                else    
                    temp_ind = apply_threshold(roi_ind_all);
                    if ~isempty(temp_ind)
                        roi_ind_all = roi_ind_all(temp_ind);
                    else
                        roi_ind_all = [];
                    end;
                end
            end
        end
        if isempty(roi_ind_all)
            if MCconfig.verbose, disp(['No images in class: ' class2use{classnum}]), end
            if ~exist('checking_handle', 'var'), 
                checking_handle = text(0, 1.01, 'Checking for images...', 'fontsize', 20, 'verticalalignment', 'bottom', 'backgroundcolor', [.9 .9 .9]);
                pause(.001) %make sure label displays
            end;
        else %rois exist in current class
            
            if threshold_warn %if first time showing images on this file
                [selectedButton,dlgShown]=uigetpref('graphics','threshold_warning','Threshold Mode Reminder',...
                    'Warning: Image size threshold in effect. You may not be viewing all the images in this file.', {'OK'},...
                    'CheckBoxString', 'Do not display this reminder again.');
                threshold_warn = 0; %only once per file
            end
            if MCflags.file_jump_back_again %successful one step back
                MCflags.file_jump_back_again = 0;
            end;
            setnum = ceil(length(roi_ind_all)./MCconfig.setsize);
            if exist('set_menu_handle', 'var'),
                delete(set_menu_handle), clear set_menu_handle
            end;
            imgset = 1;
            if setnum > 1
                set_menu_handle = uimenu(figure_handle, 'Label', 'Change &Set', 'position', 3);
                for ii = 1:setnum
                    imgset_menu_handles(ii) = uimenu(set_menu_handle, 'Label', num2str(MCconfig.setsize*ii-MCconfig.setsize+1), 'callback', {'set_menucount', ii});
                end;
                set(get(set_menu_handle, 'children'), 'checked', 'off')
                set(imgset_menu_handles(imgset), 'checked', 'on');
            end;
                       
            
            %if appropriate, sort by size before separating into subsets
            if MCconfig.display_order  %1 = 'size'; 0 = 'index'
                if MCconfig.dataformat <= 1
                    [~,ii] = sortrows([roi_info.x_all(roi_ind_all) roi_info.y_all(roi_ind_all) ], [-2,-1]);
                    roi_ind_all = roi_ind_all(ii);
                elseif MCconfig.dataformat == 2 %VPR case
                    [~,temp] = sort(roi_info.disk_size_index(roi_ind_all));
                    roi_ind_all = roi_ind_all(temp);
                end
            end             

            while imgset <= setnum && ~MCflags.file_jump
                if exist('checking_handle', 'var'), delete(checking_handle), clear checking_handle, pause(.001), end;
                loading_handle = text(0, 1.01, 'Loading images...', 'fontsize', 20, 'verticalalignment', 'bottom', 'backgroundcolor', [.9 .9 .9]);
                pause(.01) %make sure label displays
                next_ind = 1; %start with the first roi
                next_ind_list = next_ind; %keep track of screen start indices within a class
                imagedat = {};
                disp(['Set ' num2str(imgset) ' of ' num2str(setnum)])
                if setnum > 1
                    set(get(set_menu_handle, 'children'), 'checked', 'off')
                    set(imgset_menu_handles(imgset), 'checked', 'on');
                end
                startrange = imgset*MCconfig.setsize-MCconfig.setsize;
                setrange = (startrange+1):min([imgset*MCconfig.setsize, length(roi_ind_all)]);
                roi_ind = roi_ind_all(setrange);
               
                imagedat = read_images; %read roi images, one set 
                
                delete(loading_handle)
                if ~isempty(imagedat),
                    while next_ind <= length(roi_ind),
                        change_col = 2; 
                        rendering_handle = text(0, 1.01, 'Rendering images...', 'fontsize', 20, 'verticalalignment', 'bottom', 'backgroundcolor', [.9 .9 .9]);
                        pause(.001)
                        filestr =  regexprep(regexprep(filelist{filecount}, '\\', '\\\'), '_', '\\_');
                        [next_ind_increment, imagemap] = fillscreen(imagedat(next_ind:end),roi_ind(next_ind:end), camx, camy, border, [{[regexprep(class2use{classnum}, '_', '\\_') '  \fontsize{10}']} filestr], classlist, change_col, classnum, MCconfig.dataformat);
                        if ~isnan(scale_bar_image1)
                            scale_bar_image = imresize(scale_bar_image1, MCconfig.imresize_factor);
                            imagesc(camx-size(scale_bar_image,2)-60,1020,scale_bar_image), text(camx-50,1020,[num2str(MCconfig.bar_length_micron) ' \mum'])
                        end;
                        next_ind = next_ind + next_ind_increment - 1;
                        figure(figure_handle)
                        
                        [ classlist ] = selectrois(instructions_handle, imagemap, classlist, MCconfig.class2use, MCconfig.maxlist1 );
                        set(instructions_handle, 'string', ['Click on ' category...
                                ' images; then ENTER key to save results before changing categories. ENTER key for new page.'], 'foregroundcolor', 'k', 'fontsize', 8)
                        if MCflags.select_remaining
                            classlist(roi_ind_all(setrange(next_ind-next_ind_increment+1):end),2) = str2num(category(1:3)); 
                            if imgset == setnum
                                MCflags.select_remaining = 0;
                                MCflags.changed_selectrois = 1;
                            end
                            set(select_remaining_button_handle, 'value', 0)
                        end;
                        if MCflags.changed_selectrois
                            save(MCconfig.resultfiles{filecount}, 'classlist', 'class2use_auto', 'class2use_manual', 'list_titles', 'default_class_original'); %omit append option, 6 Jan 2010
                        end;
                        MCflags.changed_selectrois = 0;
                        if MCflags.reload_set, new_setcount = imgset; MCflags.reload_set = 0; end
                        if MCflags.class_step %case for user stepped to next or previous class, new_classcount OR special case to reload current class (class_step = -0.5)
                            new_classcount = classcount + ceil(MCflags.class_step); %value of flag specifies direction and amplitude of step within class2view, ceil ensures -0.5 ==> 0
                            if MCflags.class_step < 0 %-1 (go back one) or -0.5 (reload current)
                                temp_ind = get_roi_indices(classlist, class2view(new_classcount), MCconfig.pick_mode); %check for rois one class back
                                temp_ind = apply_threshold(temp_ind); 
                                while isempty(temp_ind) && new_classcount > 1 %check until find class with rois in it
                                    new_classcount = new_classcount - 1; % go back one more
                                    temp_ind = get_roi_indices(classlist, class2view(new_classcount), MCconfig.pick_mode);
                                    temp_ind = apply_threshold(temp_ind); 
                                end
                                end;
                                MCflags.class_step = 0;
                            elseif MCflags.class_jump  %case for user jumped to selected class, new_classcount starts as index in class2use
                                temp_ind = get_roi_indices(classlist, new_classcount, MCconfig.pick_mode); %check for rois one class back
                                if ~isempty(temp_ind) %if there are ROIs
                                    if ~ismember(new_classcount, class2view), %add the selected class to class2view, just for this file, in order just after current class
                                        if classcount < length(class2view)
                                            class2view = [class2view(1:classcount); new_classcount; class2view(classcount+1:end)];
                                        else
                                            class2view = [class2view; new_classcount];
                                        end;
                                    end;
                                else %if no ROIs, stay on current class
                                    set(instructions_handle, 'string', ['Class jump skipped; No images in ' class2use{new_classcount}], 'foregroundcolor', 'r', 'fontsize', 16)
                                    new_classcount = class2view(classcount);
                                end;
                                new_classcount = find(class2view==new_classcount);
                                MCflags.class_jump = 0;
                            end;
                            if MCflags.file_jump
                                imgset = setnum; %make sure it leaves while loop
                                next_ind = length(roi_ind)+1; %make sure it leaves on next while
                            elseif ~isnan(new_classcount) %case for user changed class
                                classcount = new_classcount - 1;
                                imgset = setnum; %make sure it leaves while loop
                                next_ind = length(roi_ind)+1; %make sure it leaves on next while
                                new_classcount = NaN;
                            elseif ~isnan(new_setcount) %imgset ~= new_setcount; %case for user changed set number
                                imgset = new_setcount - 1;
                                next_ind = length(roi_ind)+1; %make sure it leaves on next while
                                new_setcount = NaN;
                            elseif MCflags.go_back,
                                if length(next_ind_list) == 1, %start of a set
                                    if imgset > 1 %case to go back one set in same class
                                        imgset = imgset - 2;
                                        next_ind_list = [];
                                        next_ind = length(roi_ind)+1; %make sure it leaves on next while
                                    else %imgset == 1,%case for back one whole class
                                        next_ind = length(roi_ind)+1; %make sure it leaves on next while;
                                        next_ind_list = [];
                                        imgset = setnum;
                                        if classcount == 1, %just go back to start of file
                                            set(instructions_handle, 'string', ['NOT POSSIBLE TO BACKUP PAST THE START OF A FILE! Restart on previous file if necessary.'], 'foregroundcolor', 'r')
                                            classcount = 0;
                                        else
                                            temp_ind = get_roi_indices(classlist, class2view(classcount-1), MCconfig.pick_mode); %check for rois one class back
                                            %keyboard
                                            temp_ind = apply_threshold(temp_ind); 
                                            classcount = classcount - 1; % go back 1 class
                                            while isempty(temp_ind) && classcount > 1 %check until find class with rois in it
                                                temp_ind = get_roi_indices(classlist, class2view(classcount-1), MCconfig.pick_mode);
                                                temp_ind = apply_threshold(temp_ind); 
                                                classcount = classcount - 1; % go back one more
                                            end;
                                            classcount = classcount - 1; % go back one more to handle increment below
                                        end;
                                    end;
                                else %go back one screen in same class
                                    next_ind = next_ind_list(end-1);
                                    next_ind_list(end-1:end) = [];
                                end;
                            end;
                            next_ind_list = [next_ind_list next_ind]; %keep track of screen starts within a class to go back
                    end;  %while next_ind <=length(roi_ind)
                end; %if ~isempty(imagedat),
                imgset = imgset + 1;
            end; %for imgset = 1:setnum
        end; %if isempty(roi_ind_all)
        classcount = classcount + 1;
    end; %while classcount
    filecount = filecount + 1;
    %fclose(fid);
    if MCflags.file_jump_back_again %no images displayed after jump back, go back one more
        new_filecount = filecount - 2;
       if new_filecount < 1 %stay on first file if already there
            set(instructions_handle, 'string', ['FIRST FILE! No previous file change possible.'], 'foregroundcolor', 'r', 'fontsize', 16)
            new_filecount = 1;
        end;
        MCflags.file_jump = 1;
    end;
    if MCflags.file_jump
        if new_filecount < 1 %stay on first file if already there
            set(instructions_handle, 'string', ['FIRST FILE! No previous file change possible.'], 'foregroundcolor', 'r', 'fontsize', 16)
            new_filecount = 1;
        end;
        if filecount-new_filecount == 2 %user asked to go back one
            MCflags.file_jump_back_again = 1; %trip a flag to check in case previous file has nothing to view
        end;
        filecount = new_filecount; 
        MCflags.file_jump = 0;        
    end;
end
%close(figure_handle)
delete(figure_handle)

function imagedat = read_images()
    if MCconfig.dataformat <= 1 || MCconfig.dataformat == 3 %IFCB or FlowCam, Sherbrooke
        startbyte = roi_info.startbyte_all(roi_ind); x = roi_info.x_all(roi_ind); y = roi_info.y_all(roi_ind); %heidi 11/5/09
        fid=fopen([filelist{filecount} '.roi']);
        for imgcount = 1:length(startbyte),
            fseek(fid, startbyte(imgcount), -1);
            data = fread(fid, x(imgcount).*y(imgcount), 'ubit8');
            imagedat{imgcount} = imresize(reshape(data, x(imgcount), y(imgcount)),MCconfig.imresize_factor);
        end;
        indA = [];
        if ~isempty(stitch_info),
            [roinum , indA, indB] = intersect(roi_ind, stitch_info(:,1));
        end;
        for stitchcount = 1:length(indA), %loop over any rois that need to be stitched
            startbytet = roi_info.startbyte_all(roinum(stitchcount)+1); xt = roi_info.x_all(roinum(stitchcount)+1); yt = roi_info.y_all(roinum(stitchcount)+1); %heidi 11/5/09
            fseek(fid, startbytet,-1); %go to the next roi in the pair
            data = fread(fid, xt.*yt, 'ubit8');
            imgB = imresize(reshape(data,xt,yt),MCconfig.imresize_factor);
            xpos = stitch_info(indB(stitchcount),[2,4])'; ypos = stitch_info(indB(stitchcount),[3,5])';
            [ imagedat{indA(stitchcount)}, xpos_merge, ypos_merge ] = stitchrois({imagedat{indA(stitchcount)} imgB},xpos,ypos);
            clear xt yt startbytet
            figure(1)
        end;
        fclose(fid);
    elseif MCconfig.dataformat == 2 %VPR
        for imgcount = 1:length(roi_ind)
            imagedat{imgcount} = imresize(imread(fullfile(roi_info.roipath,roi_info.roilist{roi_ind(imgcount)})),MCconfig.imresize_factor)';
            [roi_info.x_all(roi_ind(imgcount)) roi_info.y_all(roi_ind(imgcount))] = size(imagedat{imgcount});
        end;
    end
end

function roi_info = get_roi_info()
    if MCconfig.dataformat <= 1, %IFCB
        adcdata = load([filelist{filecount} '.adc']);
        roi_info.x_all = adcdata(:,adcxind);  roi_info.y_all = adcdata(:,adcyind); roi_info.startbyte_all = adcdata(:,startbyteind);
        numrois = size(adcdata,1);
    elseif MCconfig.dataformat == 2 %VPR
        [~,f] = fileparts(MCconfig.resultfiles{filecount});
        f = [MCconfig.resultpath filesep 'roi_info' filesep f '.mat'];
        if exist(f, 'file')
            load(f)
            roi_info.roipath = fileparts(filelist{filecount});
        else
            roi_info.roipath = fileparts(filelist{filecount});
            reading_handle = text(0, 1.01, 'Reading image directory...', 'fontsize', 20, 'verticalalignment', 'bottom', 'backgroundcolor', [.9 .9 .9]);
            pause(.01) %make sure label displays
            eval(['[~,roi_info.roilist] = dos(''dir ' roi_info.roipath filesep '*.tif /B /O-S'');']) %bare dir reading, sorted largest to smallest size on disk
            delete(reading_handle)
            tt = strfind(roi_info.roilist, char(10)); tt = tt(1)-1;
            roi_info.roilist = regexprep(roi_info.roilist, char(10), '');
            roi_info.roilist = cellstr(reshape(roi_info.roilist,tt,length(roi_info.roilist)/tt)');
            [roi_info.roilist roi_info.disk_size_index] = sort(roi_info.roilist);
            save(f, 'roi_info')
        end
        numrois = length(roi_info.roilist);
        roi_info.x_all = NaN; %placeholder for passing into get_claslistTB2
    elseif MCconfig.dataformat == 3 %FlowCAM, Sherbrooke
        adcdata = load([filelist{filecount} '_ADC.mat']);
        adcdata = adcdata.data_out;
        roi_info.x_all = adcdata.image_w;  roi_info.y_all = adcdata.image_h; roi_info.startbyte_all = adcdata.start_byte;
        numrois = size(adcdata,1);
    end
end

function ind = apply_threshold(ind) %, x, y, MCconfig)
    if MCconfig.threshold_mode == 2
        ind = find(roi_info.x_all(ind) >= MCconfig.x_pixel_threshold | roi_info.y_all(ind) >= MCconfig.y_pixel_threshold);
    elseif MCconfig.threshold_mode == 3
        ind = find(roi_info.x_all(ind) < MCconfig.x_pixel_threshold & roi_info.y_all(ind) < MCconfig.y_pixel_threshold);
    else
        ind = ind;
    end
end
end

