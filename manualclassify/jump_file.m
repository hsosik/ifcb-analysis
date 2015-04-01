function [  ] = jump_file( hOBj, eventdata )
%function [  ] = class_change_amount( hOBj, eventdata, direction )
% callback function for 'jump to selected class' menu option in
% manual_classify for IFCB
% Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2015

global new_filecount file_jump_flag filelist filecount
file_jump_flag = 1;

[new_filecount,v] = listdlg('PromptString','Select a file:', 'SelectionMode','single','ListString',filelist, 'ListSize', [300 400], 'initialvalue', filecount);

if v == 0 %user cancelled
    new_filecount = NaN;
    jump_flag = 0;
end;

robot_pressCR(1)

end

