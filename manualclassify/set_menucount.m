function set_menucount( hOBject, eventdata, num )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global new_classcount new_setcount

menu_string = get(get(hOBject, 'Parent'), 'Label');
switch menu_string
    case 'Display Class'
        new_classcount = num;
    case 'Set Start'
        new_setcount = num;
end
robot = java.awt.Robot;
pause(.5)  %pause seems to be necessary for the key stroke to be reliably recorded by ginput
robot.keyPress (java.awt.event.KeyEvent.VK_ENTER); %// press "enter" key
robot.keyRelease (java.awt.event.KeyEvent.VK_ENTER); %// release "enter" key

end

