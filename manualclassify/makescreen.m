function [ figure_handle, listbox_handle1, listbox_handle2, instructions_handle] = makescreen( class2pick1, class2pick2 )
%function [ figure_handle, button_handles, instructions_handle] = makescreen( class2pick )
%For Imaging FlowCytobot roi viewing; Use with manual_classify scripts;
%Sets up a graph window for manual identification from a roi collage (use
%fillscreen.m to add the rois);
%Heidi M. Sosik, Woods Hole Oceanographic Institution, 30 May 2009

%INPUT:
%class2pick - cell array of class labels
%
%OUTPUT:
%figure_handle - handle to figure window
%button_handles - handles to category radio buttons
%instructions_handles - handle to text box for instructions

screen = get(0, 'ScreenSize');
width = screen(3);
height = screen(4);
figure_handle = figure;
x0 = width*.01;
y0 = 105; %starting point for category rb's     %height*.5;
ysp = 15; %spacing between lines
rbwd = width*.09;%.08;
rbht = height*.017;%.0190;

button_handles1 = NaN;
instructions_handle = NaN;
if ~isempty(class2pick1), %edited 1/12/10 to fix typo pick2 --> pick1
%for count = 1:length(class2pick1),
%    button_handles1(count) = uicontrol('style', 'radiobutton', 'string', [num2str(length(class2pick1)-count+1, '%02d') '-' char(class2pick1(end-count+1))], 'position',[x0 y0+(count-5)*ysp rbwd rbht], 'callback', 'select_category');
%end;
%set(button_handles1, 'value', 0, 'foregroundcolor', 'r', 'backgroundcolor', 'w')
str = cellstr([num2str((1:length(class2pick1))', '%02d') repmat(' ',length(class2pick1),1) char(class2pick1)]);
listbox_handle1 = uicontrol('style', 'listbox', 'string', str,'position', [width*.005 height*.006 width/9 height*.95], 'ForegroundColor', 'r', 'callback', 'select_category');
instructions_handle = uicontrol('style', 'text');
tpos = get(instructions_handle, 'position');
%tpos(3) = tpos(3)*10; tpos(2) = tpos(2)*2; tpos(1) = tpos(1)*10;
tpos(3) = tpos(3)*10; tpos(2) = tpos(2)*3; tpos(1) = tpos(1)*10; tpos(4) = tpos(4)*1.5;
set(instructions_handle, 'position', tpos)
set(instructions_handle, 'string', ['Use mouse button to choose category. Then click on ROIs. Hit ENTER key to stop choosing.'])
end;
button_handles2 = NaN; 
if ~isempty(class2pick2),
    %for count = 1:length(class2pick2),
    %    button_handles2(count) = uicontrol('style', 'radiobutton', 'string', [num2str(length(class2pick2)-count+1, '%02d') '-' char(class2pick2(end-count+1))], 'position',[x0*100-rbwd y0+(count-5)*ysp rbwd rbht], 'callback', 'select_category');
    %end;
    %set(button_handles2, 'value', 0, 'foregroundcolor', 'b', 'backgroundcolor', 'w'),
    str = cellstr([num2str((1:length(class2pick2))', '%02d') repmat(' ',length(class2pick2),1) char(class2pick2)]);
    listbox_handle2 = uicontrol('style', 'listbox', 'string', str,'position', [width*.9 height*.006 width/10 height*.95], 'ForegroundColor', 'b', 'callback', 'select_category');
end;


set(figure_handle,'position',[width*0 height*0.04 width*1 height*.96])
set(gcf,'color', [1 1 1]);

