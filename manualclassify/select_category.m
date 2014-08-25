%select_category.m
%For Imaging FlowCytobot roi identification; Use with manual_classify scripts;
%Sets up uicontrol for picking categories;

%new version that makes rb vector automatically
%Heidi Sosik, Woods Hole Oceanographic Institution, 27 May 06 
%
%Revised 31 May 2009 for use with new manual_classify scripts (_2_0.m and
%after); %figure_handle in place of h2

global category button_flag figure_handle listbox_handle1 listbox_handle2 listbox_handle3   instructions_handle %category button_handles1 button_handles2 category

if gco == listbox_handle1,
    button_flag = 1;
elseif gco == listbox_handle2,
    button_flag = 2;
elseif gco == listbox_handle3,
    button_flag = 3;
else
    button_flag = NaN;
end;
str = get(gco, 'string');
category = char(str(get(gco, 'value')));
set(instructions_handle, 'string', ['Click on ' category...
    ' images; then ENTER key to save results before changing categories. ENTER key for new page.'], 'foregroundcolor', 'k')
refresh(figure_handle)
figure(figure_handle);
