function [  ] = select_remaining( hOBj, eventdata )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global select_remaining_flag

select_remaining_flag = 1;

ReleaseFocus(gcf)

robot_pressCR(1)

set(hOBj, 'value',0) %unselect the button

end

