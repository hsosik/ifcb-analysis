function [ ] = robot_pressCR( num )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

robot = java.awt.Robot;
pause(.5)  %pause seems to be necessary for the key stroke to be reliably recorded by ginput
for ii = 1:num
    robot.keyPress (java.awt.event.KeyEvent.VK_ENTER); %// press "enter" key
    robot.keyRelease (java.awt.event.KeyEvent.VK_ENTER); %// release "enter" key
end;

end

