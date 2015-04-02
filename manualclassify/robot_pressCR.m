function [ ] = robot_pressCR( num )
%function [ ] = robot_pressCR( num )
%   perform 'num' robotic carriage returns (as if from keyboard), for
%   manual_classify GUI performance streamline
% Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2015

robot = java.awt.Robot;
pause(.5)  %pause seems to be necessary for the key stroke to be reliably recorded by ginput
for ii = 1:num
    robot.keyPress (java.awt.event.KeyEvent.VK_ENTER); %// press "enter" key
    robot.keyRelease (java.awt.event.KeyEvent.VK_ENTER); %// release "enter" key
end;

end

