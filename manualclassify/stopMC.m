function [  ] = stopMC( hOBj, eventdata )
%function [  ] = stopMC( hOBj, eventdata )
    %   callback for quit from manual_classify menu entry
%Heidi M. Sosik, Woods Hole Oceanographic Institution, April 2015

global filelist new_filecount file_jump_flag

file_jump_flag = 1;
new_filecount = length(filelist)+1;

robot_pressCR(1)

end

