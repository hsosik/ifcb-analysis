function [  ] = jump_class( hOBj, eventdata, amount )
%function [  ] = class_change_amount( hOBj, eventdata, direction )
% callback function for 'jump to selected class' menu option in
% manual_classify for IFCB
% Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2015

global category new_classcount

new_classcount = str2num(category(1:3));

robot = java.awt.Robot;
pause(.1)  %pause seems to be necessary for the key stroke to be reliably recorded by ginput
robot.keyPress (java.awt.event.KeyEvent.VK_ENTER); %// press "enter" key
robot.keyRelease (java.awt.event.KeyEvent.VK_ENTER); %// release "enter" key
robot.keyPress (java.awt.event.KeyEvent.VK_ENTER); %// press "enter" key
robot.keyRelease (java.awt.event.KeyEvent.VK_ENTER); %// release "enter" key

end

