function [  ] = manual_classify_4_1( MCconfig )
%function [  ] = manual_classify_4_0( MCconfig )
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

global figure_handle listbox_handle1 listbox_handle2 instructions_handle listbox_handle3 new_classcount new_setcount
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
class2view1 = sort(class2view1); %keep same order as class2use
if isempty(MCconfig.class2view2),
    class2use_sub = [];
    classstr = [];
    classnum_default_sub = [];
    class2view2 = [];
else
    class2use_sub = MCconfig.class2use_sub;
    classnum_default_sub = strmatch(MCconfig.sub_default_class, class2use_sub);
    classstr = MCconfig.classstr;
    [~,class2view2] = intersect(class2use_sub, MCconfig.class2view2);
    class2view1 = setdiff(class2view1, strmatch(classstr, class2use));
end;
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
set(figure_handle, 'menubar', 'none')
class_menu_handle = uimenu(figure_handle, 'Label', 'Display Class' );
for ii = 1:length(class2view1)
    uimenu(class_menu_handle, 'Label', class2use{class2view1(ii)}, 'callback', {'set_menucount', ii});
end;

if MCconfig.dataformat == 0,
    adcxind = 12;
    adcyind = 13;
    startbyteind = 14;
elseif MCconfig.dataformat == 1,
    adcxind = 16;
    adcyind = 17;
    startbyteind = 18;
end;

for filecount = filenum2start:length(filelist),
    new_classcount = 1; %initialize
    disp(['File number: ' num2str(filecount)])
    [~,outfile] = fileparts(filelist{filecount}); outfile = [outfile '.mat'];
    if ~strcmp(pick_mode, 'raw_roi') & ~exist([filelist{filecount} '.roi']) & ~exist(classfiles{filecount}),
        %if ~exist([resultpath streamfile '.mat']) & ~exist([classpath filelist(filecount).name(1:end-4) class_filestr '.mat']),
        disp('No class file and no existing result file. You must choose pick_mode "raw_roi" or locate a valid class file.')
        return
    end;
    adcdata = load([filelist{filecount} '.adc']);
    x_all = adcdata(:,adcxind);  y_all = adcdata(:,adcyind); startbyte_all = adcdata(:,startbyteind);
    stitch_info = [];
    if ~isempty(stitchfiles),
        if exist([stitchfiles{filecount}]), %exist([stitchpath streamfile '_roistitch.mat']),
            %load([stitchpath streamfile '_roistitch.mat']);
            load(stitchfiles{filecount});
        end;
    end;
    fid=fopen([filelist{filecount} '.roi']);
    disp(filelist{filecount}), disp([num2str(size(adcdata,1)) ' total ROI events'])
    if isempty(classfiles),
        classfile_temp = 'temp';
    else
        classfile_temp = classfiles{filecount};
    end;

    [ classlist, sub_col, list_titles, newclasslist_flag ] = get_classlistTB( [resultpath outfile],classfile_temp, pick_mode, class2use_manual, class2use_sub, classstr, classnum_default, classnum_default_sub, length(x_all) );
    if newclasslist_flag,  %only first time creating classlist
        zero_ind = find(x_all == 0);
        classlist(zero_ind,2) = NaN; %mark zero-sized ROIs as NaNs in manual column (needed for raw_roi case where these are put in default class by get_classlistTB
    end;
%special case to segregate dirt spots in Healy1101 data
    if isequal(outfile(1:10), 'IFCB8_2011') && newclasslist_flag,
        classlist((adcdata(:,10) == 1118 & adcdata(:,11) == 290),2) = strmatch('bad', class2use_manual);
    end;
    if isempty(classlist), %indicates bad class2use match
        return
    end;
    if ~isempty(stitch_info),
        classlist(stitch_info(:,1)+1,2:3) = NaN; %force NaN class for second roi in pair to be stitched
    end;
    mark_col = 2; %added back 11 jan 2010
    if ~isempty(sub_col),
        eval(['class2use_sub' num2str(sub_col) '= class2use_sub;'])
        mark_col = sub_col; %reset col for ID in classlist
    end;
    %save([resultpath streamfile], 'list_titles', 'class2use_auto', 'class2use_manual', 'class2use_sub*', 'classlist', '-append'); %make sure initial file has proper list_titles
    for view_num = 1:2,
        if view_num == 1,
            class2view = class2view1;
            class2use_now = class2use;
            %        mark_col = 2; %added 9/29/09 Heidi
        else
            class2view = class2view2;
            class2use_now = class2use_sub;
            %        mark_col = sub_col; %added 9/29/09 Heidi
        end;
       % class_with_rois = [];
        classcount = 1;
        while classcount <= length(class2view),
            new_setcount = 1; %initialize
            classnum = class2view(classcount);
            roi_ind_all = get_roi_indices(classlist, classnum, pick_mode, sub_col, view_num);
            
            if ~isempty(roi_ind_all),
                setnum = ceil(length(roi_ind_all)./setsize);
                if exist('set_menu_handle', 'var'), 
                    delete(set_menu_handle), clear set_menu_handle
                end;
                if setnum > 1
                    set_menu_handle = uimenu(figure_handle, 'Label', 'Set Start' );
                    for ii = 1:setnum
                        uimenu(set_menu_handle, 'Label', num2str(setsize*ii-setsize+1), 'callback', {'set_menucount', ii});
                    end;
                end;
                imgset = 1;
                while imgset <= setnum,
                    next_ind = 1; %start with the first roi
                    next_ind_list = next_ind; %keep track of screen start indices within a class
                    imagedat = {};
                    startrange = imgset*setsize-setsize;
                    setrange = (startrange+1):min([imgset*setsize, length(roi_ind_all)]);
                    roi_ind = roi_ind_all(setrange);
                    startbyte_temp = startbyte_all(classlist(roi_ind,1)); x = x_all(classlist(roi_ind,1)); y = y_all(classlist(roi_ind,1));
                    startbyte = startbyte_all(roi_ind); x = x_all(roi_ind); y = y_all(roi_ind); %heidi 11/5/09
                    if (startbyte_temp - startbyte), disp('CHECK for error!'), keyboard, end;
                    %read roi images
                    for imgcount = 1:length(startbyte),
                        fseek(fid, startbyte(imgcount), -1);
                        data = fread(fid, x(imgcount).*y(imgcount), 'ubit8');
                        imagedat{imgcount} = reshape(data, x(imgcount), y(imgcount));
                    end;
                    indA = [];
                    if ~isempty(stitch_info),
                        [roinum , indA, indB] = intersect(roi_ind, stitch_info(:,1));
                    end;
                    for stitchcount = 1:length(indA), %loop over any rois that need to be stitched
                        startbytet = startbyte_all(roinum(stitchcount)+1); xt = x_all(roinum(stitchcount)+1); yt = y_all(roinum(stitchcount)+1); %heidi 11/5/09
                        fseek(fid, startbytet,-1); %go to the next aroi in the pair
                        data = fread(fid, xt.*yt, 'ubit8');
                        imgB = reshape(data,xt,yt);
                        xpos = stitch_info(indB(stitchcount),[2,4])'; ypos = stitch_info(indB(stitchcount),[3,5])';
                        [ imagedat{indA(stitchcount)}, xpos_merge, ypos_merge ] = stitchrois({imagedat{indA(stitchcount)} imgB},xpos,ypos);
                        clear xt yt startbytet
                        figure(1)
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
                    change_col = 2; if view_num > 1, change_col = sub_col;, end; %1/15/10 to replace mark_col in call to fillscreen
                    [next_ind_increment, imagemap] = fillscreen(imagedat(next_ind:end),roi_ind(next_ind:end), camx, camy, border, [class2use_now(classnum) filelist{filecount}], classlist, change_col, classnum);
                    next_ind = next_ind + next_ind_increment - 1;
                    figure(figure_handle)
                    [ classlist, change_flag, go_back_flag ] = selectrois(instructions_handle, imagemap, classlist, class2use_pick1, class2use_pick2, mark_col, MCconfig.maxlist1);
                    set(instructions_handle, 'string', ['Use mouse button to choose category. Then click on ROIs. Hit ENTER key to stop choosing.'], 'foregroundcolor', 'k') %reset in case activated warning instruction
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
                                                if classcount ~= new_classcount %case for user changed class
                                classcount = new_classcount - 1;
                                imgset = setnum; %make sure it leaves while loop
                                next_ind = length(roi_ind)+1; %make sure it leaves on next while
                            elseif imgset ~= new_setcount; %case for user changed set number
                                imgset = new_setcount - 1;
                                next_ind = length(roi_ind)+1; %make sure it leaves on next while
                            elseif go_back_flag,
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
                                            temp_ind = get_roi_indices(classlist, class2view(classcount-1), pick_mode, sub_col, view_num); %check for rois one class back
                                            classcount = classcount - 2; % go back 2 classes to handle increment below
                                            while isempty(temp_ind) && classcount > 1 %check until find class with rois in it
                                                temp_ind = get_roi_indices(classlist, class2view(classcount), pick_mode, sub_col, view_num);
                                                classcount = classcount - 1; % go back one more
                                            end;
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
            new_classcount = classcount;
        end; %while classcount
    end
end               
                    