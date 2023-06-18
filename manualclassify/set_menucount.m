function set_menucount( hOBject, eventdata, num )
% function set_menucount( hOBject, eventdata, num )
% callback function for 'set_menu_handle' menu option in
% manual_classify for IFCB
% Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2015
global  new_setcount

new_setcount = num;

robot = java.awt.Robot;
pause(.5)  %pause seems to be necessary for the key stroke to be reliably recorded by ginput
robot.keyPress (java.awt.event.KeyEvent.VK_ENTER); %// press "enter" key
robot.keyRelease (java.awt.event.KeyEvent.VK_ENTER); %// release "enter" key

end

