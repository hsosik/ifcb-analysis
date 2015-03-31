function [  ] = class_change_amount( hOBj, eventdata, amount )
%function [  ] = class_change_amount( hOBj, eventdata, direction )
% callback function for 'next class' and 'previous class' menu options in
% manual_classify for IFCB
% Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2015

global class_change

class_change = amount;

robot_pressCR(1)
% robot = java.awt.Robot;
% pause(.5)  %pause seems to be necessary for the key stroke to be reliably recorded by ginput
% robot.keyPress (java.awt.event.KeyEvent.VK_ENTER); %// press "enter" key
% robot.keyRelease (java.awt.event.KeyEvent.VK_ENTER); %// release "enter" key

end

