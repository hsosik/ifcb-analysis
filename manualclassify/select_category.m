%select_category.m
%For Imaging FlowCytobot roi identification; Use with manual_classify scripts;
%Sets up uicontrol for picking categories;

%new version that makes rb vector automatically
%Heidi Sosik, Woods Hole Oceanographic Institution, 27 May 06 
%
%Revised 31 May 2009 for use with new manual_classify scripts (_2_0.m and
%after); %figure_handle in place of h2

global category button_flag figure_handle listbox_handle1 listbox_handle2 instructions_handle %category button_handles1 button_handles2 category

if gco == listbox_handle1,
    button_flag = 1;
elseif gco == listbox_handle2,
    button_flag = 2;
else
    button_flag = NaN;
end;
str = get(gco, 'string');
category = char(str(get(gco, 'value')));
%rb = gco;
%button_flag = 1;
%if ismember(gco, button_handles2)
%    button_flag = 2;
%end;
%category = get(rb, 'string');
%category = char(category);
%if ~isnan(button_handles2),
%    set(button_handles2, 'value', 0)
%end;
%set(button_handles1, 'value', 0)
%set(rb, 'value', 1),
set(instructions_handle, 'string', ['Click on ' category...
    ' images; then ENTER key to save results before changing categories. ENTER key for new page.'], 'foregroundcolor', 'k')
refresh(figure_handle)
figure(figure_handle);
