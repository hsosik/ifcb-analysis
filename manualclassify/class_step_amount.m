function [  ] = class_step_amount( hOBj, eventdata, amount )
%function [  ] = class_change_amount( hOBj, eventdata, amount )
% callback function for 'next class' and 'previous class' menu options in
% manual_classify for IFCB
% Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2015

global step_flag

step_flag = amount;

robot_pressCR(1)

end

