function [ ] = robot_pressESC( num )
%function [ ] = robot_pressESC( num )
%   perform 'num' robotic ESCAPE key presses (as if from keyboard), for
%   manual_classify GUI performance streamline
% Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2015

robot = java.awt.Robot;
%pause(.5)  %pause seems to be necessary for the key stroke to be reliably recorded by ginput
for ii = 1:num
    robot.keyPress (java.awt.event.KeyEvent.VK_ESCAPE); %// press "enter" key
    robot.keyRelease (java.awt.event.KeyEvent.VK_ESCAPE); %// release "enter" key
end;

end

