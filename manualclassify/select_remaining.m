function [  ] = select_remaining( hOBj, eventdata )
%function [  ] = select_remaining( hOBj, eventdata )
%   callback function for 'select remaining in class' radio button in manual_classify
% Heidi M. Sosik, Woods Hole Oceanographic Institution, April 201

global MCflags

MCflags.select_remaining = 1;

ReleaseFocus(gcf)

robot_pressCR(1)

set(hOBj, 'value',0) %unselect the button

end

