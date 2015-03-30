function set_classcount( hOBject, eventdata, num, class2use)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global new_classcount %new_setcount

menu_string = get(hOBject, 'Label');
new_classcount = strmatch(menu_string, class2use, 'exact');

robot = java.awt.Robot;
pause(.5)  %pause seems to be necessary for the key stroke to be reliably recorded by ginput
robot.keyPress (java.awt.event.KeyEvent.VK_ENTER); %// press "enter" key
robot.keyRelease (java.awt.event.KeyEvent.VK_ENTER); %// release "enter" key

end

