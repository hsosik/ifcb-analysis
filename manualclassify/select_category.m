function [  ] = select_category( hOBj, eventdata )
%function [  ] = select_category( hOBj, eventdata )
%For Imaging FlowCytobot roi identification; Use with manual_classify scripts;
%Sets up uicontrol for picking categories;
% callback for class listboxes

%new version that makes rb vector automatically
%Heidi Sosik, Woods Hole Oceanographic Institution, 27 May 06 
%
%Revised 31 May 2009 for use with new manual_classify scripts (_2_0.m and
%after); %figure_handle in place of h2
%April 2015, revised to remove subdivide functionality and recast for manual_classify_4_1

global category MCflags figure_handle listbox_handle1 listbox_handle3 instructions_handle 

if gco == listbox_handle1,
    MCflags.button = 1;
elseif gco == listbox_handle3,
    MCflags.button = 3;
else
    MCflags.button = NaN;
end;

str = get(gco, 'string');
category = char(str(get(gco, 'value')));
set(instructions_handle, 'string', ['Click on ' category...
    ' images; then ENTER key to save results before changing categories. ENTER key for new page.'], 'foregroundcolor', 'k')

xl = xlim; yl = ylim;
h = fill([xl([1,2,2,1])]', yl([1,1,2,2])', 'w', 'facealpha', .7);
ReleaseFocus(gcf)
robot_pressCR(1)
delete(h)

