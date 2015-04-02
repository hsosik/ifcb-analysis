function [ figure_handle, listbox_handle1, listbox_handle3, instructions_handle] = makescreen( class2pick1, MCconfig)
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

screen = get(0, 'ScreenSize');

figure_handle = figure;
set(figure_handle, 'outerposition', screen, 'color', [1 1 1])
set(figure_handle, 'units', 'inches')
tpos = get(figure_handle, 'position');
lwdth = .8/tpos(4); %.8 inches as fraction of screen, listbox width
lmargin = .3/tpos(4); %.2 inches as fraction of screen, bottom margin below list boxes
instructions_handle = NaN;

if ~isempty(class2pick1), %edited 1/12/10 to fix typo pick2 --> pick1
    
    switch MCconfig.alphabetize
        case 'yes'
            [~, ix] = sort(lower(class2pick1));%sorting class2pick1
            numstr_to_display = (1:length(class2pick1))';%sorting the indexes class2pick1
            str = cellstr([num2str(numstr_to_display(ix), '%03d') repmat(' ',length(class2pick1),1) char(class2pick1{ix})]);
        case 'no'
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
        listbox_handle3 = uicontrol('style', 'listbox', 'string', str2, 'ForegroundColor', 'r', 'callback', 'select_category');
        set(listbox_handle3, 'units', 'normalized', 'position',[1-lwdth lmargin lwdth 1-lmargin])
    end;
    listbox_handle1 = uicontrol('style', 'listbox', 'string', str1, 'ForegroundColor', 'r', 'callback', 'select_category');
    set(listbox_handle1, 'units', 'normalized', 'position', [0 lmargin lwdth 1-lmargin]);
    instructions_handle = uicontrol('style', 'text');
    set(instructions_handle, 'units', 'normalized', 'position', [lwdth*3 lmargin lwdth*4 lmargin]);% tpos)
    set(instructions_handle, 'string', ['Use mouse button to choose category. Then click on ROIs. Hit ENTER key to stop choosing.'])    
end;

set(figure_handle, 'menubar', 'none')
%step_flag  = 0;
%file_jump_flag = 0;
change_menu_handle =  uimenu(figure_handle, 'Label', 'Change &Class');
next_menu_handle =  uimenu(change_menu_handle, 'Label', '&Next Class', 'callback', {'class_step_amount', 1}, 'Accelerator', 'n');
prev_menu_handle =  uimenu(change_menu_handle, 'Label', '&Previous Class', 'callback', {'class_step_amount', -1}, 'Accelerator', 'p');
jump_menu_handle = uimenu(change_menu_handle, 'Label', '&Jump to Selected Class', 'callback', {'jump_class'}, 'Accelerator', 'j');
file_change_menu_handle =  uimenu(figure_handle, 'Label', 'Change &File');
file_next_menu_handle =  uimenu(file_change_menu_handle, 'Label', '&Next File', 'callback', {'jump_file', 1}, 'Accelerator', 'l');
file_prev_menu_handle =  uimenu(file_change_menu_handle, 'Label', '&Previous File', 'callback', {'jump_file', -1}, 'Accelerator', 'k');
file_jump_menu_handle = uimenu(file_change_menu_handle, 'Label', '&Jump to Selected File', 'callback', {'jump_file', 0}, 'Accelerator', 'm');
configure_menu_handle = uimenu(figure_handle, 'Label', '&Options', 'callback', {'change_config'});
quit_menu_handle =  uimenu(figure_handle, 'Label', '&Quit');
quit_script_menu_handle =  uimenu(quit_menu_handle, 'Label', '&Quit manual_classify', 'callback', 'stopMC', 'Accelerator', 'q');
exit_menu_handle =  uimenu(quit_menu_handle, 'Label', 'E&xit MATLAB', 'callback', 'exit', 'Accelerator', 'x');
u = uicontrol(gcf, 'style', 'radiobutton', 'units', 'normalized');
set(u, 'position', [lwdth*1.1 lmargin*1.5 lwdth*1.25 lmargin], 'string', 'SELECT remaining in class', 'callback', {'select_remaining'}, 'fontsize', 10)

end

