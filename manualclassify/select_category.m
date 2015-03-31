function [  ] = select_category( hOBj, eventdata )
%select_category.m
%For Imaging FlowCytobot roi identification; Use with manual_classify scripts;
%Sets up uicontrol for picking categories;

%new version that makes rb vector automatically
%Heidi Sosik, Woods Hole Oceanographic Institution, 27 May 06 
%
%Revised 31 May 2009 for use with new manual_classify scripts (_2_0.m and
%after); %figure_handle in place of h2

global category button_flag figure_handle listbox_handle1 listbox_handle2 listbox_handle3 instructions_handle 

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

% import java.awt.event.*;
% %set(listbox_handle1, 'enable', 'off')
% %set(listbox_handle1, 'enable', 'on')
% %gco = gca;
% robot = java.awt.Robot;
% %pause(.1)  %pause seems to be necessary for the key stroke to be reliably recorded by ginput
% pos = get(0,'PointerLocation');
% moveptr(handle(gca),'init');
% moveptr(handle(gca),'move',600,1100) %middle of title (so no ROIs)
% robot.mousePress(InputEvent.BUTTON2_MASK);    %//left click press
% robot.mouseRelease(InputEvent.BUTTON2_MASK);
% set(0,'PointerLocation',pos)
% clear robot
% robot = java.awt.Robot;
% pause(.1)  %pause seems to be necessary for the key stroke to be reliably recorded by ginput
% robot.keyPress (java.awt.event.KeyEvent.VK_ENTER); %// press "enter" key
% robot.keyRelease (java.awt.event.KeyEvent.VK_ENTER); %// release "enter" key
% robot.keyPress (java.awt.event.KeyEvent.VK_ENTER); %// press "enter" key
% robot.keyRelease (java.awt.event.KeyEvent.VK_ENTER); %// release "enter" key

ReleaseFocus(gcf)
robot_pressCR(1)
