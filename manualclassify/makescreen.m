function [ figure_handle, listbox_handle1, listbox_handle2, instructions_handle, listbox_handle3] = makescreen( class2pick1, class2pick2, MCconfig )
%function [ figure_handle, listbox_handle1, listbox_handle2, instructions_handle, listbox_handle3] = makescreen( class2pick1, class2pick2, MCconfig )
%For Imaging FlowCytobot roi viewing; Use with manual_classify scripts;
%Sets up a graph window for manual identification from a roi collage (use
%fillscreen.m to add the rois);
%Heidi M. Sosik, Woods Hole Oceanographic Institution, 30 May 2009

%INPUT:
%class2pick1 - cell array of class labels
%class2pick2 - cell array of class labels for subdividing
%MCconfig - configuration structure from get_MCconfig.m
%
%OUTPUT:
%figure_handle - handle to figure window
%listbox_handle1 - handle to category list box on left
%listbox_handle2 - handle to category list box on right for subdivide
%listbox_handle3 - handle to category list box on right for long main list
%instructions_handles - handle to text box for instructions
%
%Sept 2014, revised for more robust handling of screen size issues

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
    if isempty(class2pick2) %can't have split list1 if in subdivide mode with class2view2 not empty
        if length(str) > MCconfig.maxlist1,
            str1 = str(1:MCconfig.maxlist1);
            str2 = str(MCconfig.maxlist1+1:end);
            listbox_handle3 = uicontrol('style', 'listbox', 'string', str2, 'ForegroundColor', 'r', 'callback', 'select_category');
            set(listbox_handle3, 'units', 'normalized', 'position',[1-lwdth lmargin lwdth 1-lmargin])
        end;
    end;
    listbox_handle1 = uicontrol('style', 'listbox', 'string', str1, 'ForegroundColor', 'r', 'callback', 'select_category');
    set(listbox_handle1, 'units', 'normalized', 'position', [0 lmargin lwdth 1-lmargin]);
    instructions_handle = uicontrol('style', 'text');
    set(instructions_handle, 'units', 'normalized', 'position', [lwdth*1.1 lmargin lwdth*4 lmargin]);% tpos)
    set(instructions_handle, 'string', ['Use mouse button to choose category. Then click on ROIs. Hit ENTER key to stop choosing.'])    
end;
if ~isempty(class2pick2),
    str = cellstr([num2str((1:length(class2pick2))', '%03d') repmat(' ',length(class2pick2),1) char(class2pick2)]);
    listbox_handle2 = uicontrol('style', 'listbox', 'string', str,'position', 'ForegroundColor', 'b', 'callback', 'select_category');
    set(listbox_handle2, 'units', 'normalized', 'position',[1-lwdth lmargin lwdth 1-lmargin])
else
    listbox_handle2 = [];
end;


end

