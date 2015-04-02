function [  ] = file_step_amount( hOBj, eventdata, amount )
%function [  ] = file_step_amount( hOBj, eventdata, amount )
% callback function for 'next class' and 'previous class' menu options in
% manual_classify for IFCB
% Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2015

global file_step_amount

file_step_amount = amount;

robot_pressCR(1)

end

