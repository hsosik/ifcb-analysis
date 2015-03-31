function [ ] = robot_pressCR( num )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%ReleaseFocus(gcf) %force focus back to main axes (let go of all uicontrols)

robot = java.awt.Robot;
pause(.5)  %pause seems to be necessary for the key stroke to be reliably recorded by ginput
for ii = 1:num
    robot.keyPress (java.awt.event.KeyEvent.VK_ENTER); %// press "enter" key
%    pause(.05)
    robot.keyRelease (java.awt.event.KeyEvent.VK_ENTER); %// release "enter" key
%    pause(.05)
end;

end

