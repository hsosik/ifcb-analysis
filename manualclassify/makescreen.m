function [ figure_handle, listbox_handle1, listbox_handle3, instructions_handle] = makescreen( class2pick1)
%function [ figure_handle, listbox_handle1, listbox_handle3, instructions_handle] = makescreen( class2pick1, MCconfig )
%For Imaging FlowCytobot roi viewing; Use with manual_classify scripts;
%Sets up a graph window for manual identification from a roi collage (use
%fillscreen.m to add the rois);
%Heidi M. Sosik, Woods Hole Oceanographic Institution, 30 May 2009

%INPUT:
%class2pick1 - cell array of class labels
%MCconfig - configuration structure from get_MCconfig.m
%
%OUTPUT:
%figure_handle - handle to figure window
%listbox_handle1 - handle to category list box on left
%listbox_handle3 - handle to category list box on right for long main list
%instructions_handles - handle to text box for instructions
%
%Sept 2014, revised for more robust handling of screen size issues
%April 2015, revised to remove subdivide functionality and recast for manual_classify_4_1

global category MCconfig MCflags new_classcount new_filecount filelist filecount select_remaining_button_handle

screen = get(0, 'ScreenSize');

figure_handle = figure;
set(figure_handle, 'outerposition', screen, 'color', [1 1 1])
set(figure_handle, 'units', 'inches', 'resizefcn', @figure_resize_callback, 'closerequestfcn', @stopMC_callback)
tpos = get(figure_handle, 'position');
lwdth = 1.1/tpos(4); %1.1 inches as fraction of screen, listbox width
lmargin = .28/tpos(4); %.28 inches as fraction of screen, bottom margin below list boxes
instructions_handle = NaN;

if ~isempty(class2pick1), %edited 1/12/10 to fix typo pick2 --> pick1
    switch MCconfig.alphabetize
        case {'yes',  1}
            [~, ix] = sort(lower(class2pick1));%sorting class2pick1
            numstr_to_display = (1:length(class2pick1))';%sorting the indexes class2pick1
            str = cellstr([num2str(numstr_to_display(ix), '%03d') repmat(' ',length(class2pick1),1) char(class2pick1{ix})]);
        case {'no',  0}
            str = cellstr([num2str((1:length(class2pick1))', '%03d') repmat(' ',length(class2pick1),1) char(class2pick1)]);
        otherwise
            warning('You should choose ''yes'' or ''no'' for the variable MCconfig.alphabetize_list. The list will not be alphabetized for now')
            str = cellstr([num2str((1:length(class2pick1))', '%03d') repmat(' ',length(class2pick1),1) char(class2pick1)]);
    end
    str1 = str; 
    listbox_handle3 = NaN;
    if length(str) > MCconfig.maxlist1,
        str1 = str(1:MCconfig.maxlist1);
        str2 = str(MCconfig.maxlist1+1:end);
        listbox_handle3 = uicontrol('style', 'listbox', 'string', str2, 'ForegroundColor', 'r', 'min', -1, 'max', 1, 'value', [], 'callback', @select_category_callback, 'fontsize', MCconfig.list_fontsize);
        set(listbox_handle3, 'value', [])
        set(listbox_handle3, 'units', 'normalized', 'position',[1-lwdth lmargin lwdth 1-lmargin])
    end;
    listbox_handle1 = uicontrol('style', 'listbox', 'string', str1, 'ForegroundColor', 'r', 'min', -1, 'max', 1, 'callback', @select_category_callback, 'fontsize', MCconfig.list_fontsize);
    set(listbox_handle1, 'units', 'normalized', 'position', [0 lmargin lwdth 1-lmargin]);
    instructions_handle = uicontrol('style', 'text');
    %set(instructions_handle, 'units', 'normalized', 'position', [lwdth*3 lmargin lwdth*4 lmargin]);% tpos)
    set(instructions_handle, 'units', 'normalized', 'position', [1-lwdth*4 lmargin lwdth*3 lmargin]);% tpos)
    set(instructions_handle, 'string', ['Use mouse button to choose category. Then click on ROIs. Hit ENTER key to stop choosing.'])    
end;
set(figure_handle, 'menubar', 'none')
%step_flag  = 0;
%file_jump_flag = 0;
change_menu_handle =  uimenu(figure_handle, 'Label', 'Change &Class');
next_menu_handle =  uimenu(change_menu_handle, 'Label', '&Next Class', 'callback', {@class_step_amount_callback, 1}, 'Accelerator', 'n');
prev_menu_handle =  uimenu(change_menu_handle, 'Label', '&Previous Class', 'callback', {@class_step_amount_callback, -1}, 'Accelerator', 'p');
jump_menu_handle = uimenu(change_menu_handle, 'Label', '&Jump to Selected Class', 'callback', @jump_class_callback, 'Accelerator', 'j');
file_change_menu_handle =  uimenu(figure_handle, 'Label', 'Change &File');
file_next_menu_handle =  uimenu(file_change_menu_handle, 'Label', '&Next File', 'callback', {@jump_file_callback, 1}, 'Accelerator', 'l');
file_prev_menu_handle =  uimenu(file_change_menu_handle, 'Label', '&Previous File', 'callback', {@jump_file_callback, -1}, 'Accelerator', 'k');
file_jump_menu_handle = uimenu(file_change_menu_handle, 'Label', '&Jump to Selected File', 'callback', {@jump_file_callback, 0}, 'Accelerator', 'm');
configure_menu_handle = uimenu(figure_handle, 'Label', '&Options', 'callback', @change_config_callback);
quit_menu_handle =  uimenu(figure_handle, 'Label', '&Quit');
quit_script_menu_handle =  uimenu(quit_menu_handle, 'Label', '&Quit manual_classify', 'callback', @stopMC_callback, 'Accelerator', 'q');
exit_menu_handle =  uimenu(quit_menu_handle, 'Label', 'E&xit MATLAB', 'callback', 'exit', 'Accelerator', 'x');
select_remaining_button_handle = uicontrol(gcf, 'style', 'radiobutton', 'units', 'normalized', 'backgroundcolor', 'w');
set(select_remaining_button_handle, 'position', [lwdth*1.1 lmargin*1.3 lwdth*1.5 lmargin], 'string', 'SELECT remaining in class', 'callback', @select_remaining_callback, 'fontsize', 10)

function select_category_callback( hOBj, eventdata )
%Sets up uicontrol for picking categories; callback for class listboxes
%April 2015, revised to remove subdivide functionality and recast for
%manual_classify_4_1, converted to nested function in makescreen
    if gco == listbox_handle1
        MCflags.button = 1;
        h = listbox_handle1;
        if ishandle(listbox_handle3)
            set(listbox_handle3, 'value', []);
        end
    elseif gco == listbox_handle3,
        MCflags.button = 3;
        h = listbox_handle3;
        set(listbox_handle1, 'value', []);
    else
        MCflags.button = NaN;
    end;
    str = get(h, 'string');
    v = get(h, 'value');
    if length(v) > 1, v = v(1); set(h, 'value', v); end %user can only pick one
    category = char(str(get(h, 'value')));
    set(instructions_handle, 'string', ['Click on ' category...
        ' images; then ENTER key to save results before changing categories. ENTER key for new page.'], 'foregroundcolor', 'k')
    ReleaseFocus(gcf)
    robot_pressESC(1)
end

function class_step_amount_callback( hOBj, eventdata, amount )
% callback function for 'next class' and 'previous class' menu options in
% manual_classify for IFCB
    MCflags.class_step = amount;
    robot_pressCR(1)
end

function jump_class_callback( hOBj, eventdata )
%function [  ] = class_change_amount( hOBj, eventdata, direction )
% callback function for 'jump to selected class' menu option in
% manual_classify for IFCB
% Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2015
    MCflags.class_jump = 1;
    new_classcount = str2num(category(1:3));
%    robot_pressCR(1) % one carriage return
end

function jump_file_callback( hOBj, eventdata, jump_type )
% callback function for 'jump to selected file' menu option in
% manual_classify for IFCB
    MCflags.file_jump = 1;
    if jump_type == 0, %case for jump to selected file
        [new_filecount,v] = listdlg('PromptString','Select a file:', 'SelectionMode','single','ListString',filelist, 'ListSize', [300 400], 'initialvalue', filecount);
        if v == 0 %user cancelled
            new_filecount = NaN;
            MCflags.file_jump = 0;
        end;
    else %case for step forwared or backward
        new_filecount = filecount + jump_type;
        if new_filecount > length(filelist)
            set(instructions_handle, 'string', ['LAST FILE! Use ''Quit'' menu to stop classifying.'], 'foregroundcolor', 'r', 'fontsize', 16)
            new_filecount = filecount;
        end
    end
    robot_pressCR(1)
end

function change_config_callback( hOBj, eventdata )
%   callback function for Options menu in manual_classify
    m = msgbox(''); delete(m) %stupid workaround to make inputdlg work on top of main figure window in MAC OS
    prompt = {'Number of images to display in a set' 'Image resizing factor (1 = none)' 'threshold mode (1=all, 2=larger, 3=smaller)' 'x size threshold (pixels)' 'y size threshold (pixels)'};
    defaultanswer={num2str(MCconfig.setsize) num2str(MCconfig.imresize_factor) num2str(MCconfig.threshold_mode) num2str(MCconfig.x_pixel_threshold) num2str(MCconfig.y_pixel_threshold)};
    user_input = inputdlg(prompt,'Configure', 1, defaultanswer);
    if ~isempty(user_input)
        [val status] = str2num(user_input{1});
        %if status && rem(val,1) ~= 0, status = 0; end
        if (status && (rem(val,1) ~= 0 || val <= 0)), status = 0; end
        while ~status
            uiwait(msgbox(['Set size must be a positive integer']))
            user_input(1) = defaultanswer(1);
            user_input = inputdlg(prompt,'Configure', 1, user_input);
            [val status] = str2num(user_input{1});
            if (status && (rem(val,1) ~= 0 || val <= 0)), status = 0; end
        end
        MCconfig.setsize = str2num(user_input{1});
        [val status] = str2num(user_input{2});
        while ~status
            uiwait(msgbox(['Resize factor must be a number']))
            user_input(2) = defaultanswer(2);
            user_input = inputdlg(prompt,'Configure', 1, user_input);
            [val status] = str2num(user_input{2});
        end
        MCconfig.imresize_factor = str2num(user_input{2});
        [val status] = str2num(user_input{3});
        while ~status || ~ismember(val,[1 2 3])
            uiwait(msgbox(['Mode must be 1 (all), 2 (larger), or 3 (smaller)']))
            user_input(3) = defaultanswer(3);
            user_input = inputdlg(prompt,'Configure', 1, user_input);
            [val status] = str2num(user_input{3});
        end
        MCconfig.threshold_mode = str2num(user_input{3});
        [val status] = str2num(user_input{4});
        while ~status
            uiwait(msgbox(['x size threshold must be a positive integer']))
            user_input(4) = defaultanswer(4);
            user_input = inputdlg(prompt,'Configure', 1, user_input);
            [val status] = str2num(user_input{1});
            if (status && (rem(val,1) ~= 0 || val <= 0)), status = 0; end
        end
        MCconfig.x_pixel_threshold = str2num(user_input{4});
        [val status] = str2num(user_input{5});
        while ~status
            uiwait(msgbox(['y size threshold must be a positive integer']))
            user_input(5) = defaultanswer(5);
            user_input = inputdlg(prompt,'Configure', 1, user_input);
            [val status] = str2num(user_input{1});
            if (status && (rem(val,1) ~= 0 || val <= 0)), status = 0; end
        end
        MCconfig.y_pixel_threshold = str2num(user_input{5});
    end
    if ~isequal(MCconfig.setsize, str2num(defaultanswer{1})) || ~isequal(MCconfig.threshold_mode, str2num(defaultanswer{3}))...
            || ~isequal(MCconfig.x_pixel_threshold, str2num(defaultanswer{4})) || ~isequal(MCconfig.y_pixel_threshold, str2num(defaultanswer{5}))
        class_step_amount_callback( [], [], -0.5 ) %special case to reload current class
    elseif ~isequal(MCconfig.imresize_factor, str2num(defaultanswer{2}))
        MCflags.reload_set = 1;
        robot_pressCR(1)
    end   
end

function stopMC_callback( hOBj, eventdata )
%   callback for quit from manual_classify menu entry
    MCflags.file_jump = 1;
    new_filecount = length(filelist)+1;
    pause(.001)
    robot_pressCR(1)
end

function select_remaining_callback( hOBj, eventdata )
%   callback function for 'select remaining in class' radio button in manual_classify
    MCflags.select_remaining = 1;
    ReleaseFocus(gcf)
    robot_pressCR(1)
end

function figure_resize_callback( hObj, eventdata )
    if ~MCflags.new_figure 
        MCflags.reload_set = 1;
        ReleaseFocus(gcf)
        figure(figure_handle)
        pause(.001)
        robot_pressCR(1)
    else
        MCflags.new_figure = 0;
    end
end

end


