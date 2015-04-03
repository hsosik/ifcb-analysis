function [  ] = jump_file( hOBj, eventdata, jump_type )
%function [  ] = jump_file( hOBj, eventdata, jump_type )
% callback function for 'jump to selected file' menu option in
% manual_classify for IFCB
% Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2015

global new_filecount MCflags filelist filecount instructions_handle
MCflags.file_jump = 1;

if jump_type == 0, %case for jump to selected file
    [new_filecount,v] = listdlg('PromptString','Select a file:', 'SelectionMode','single','ListString',filelist, 'ListSize', [300 400], 'initialvalue', filecount);
    if v == 0 %user cancelled
        new_filecount = NaN;
        MCflags.file_jump = 0;
    end;
else %case for step forwared or backward
    new_filecount = filecount + jump_type;
    if new_filecount > length(filelist)
        set(instructions_handle, 'string', ['LAST FILE! Use ''Quit'' menu to stop classifying.'], 'foregroundcolor', 'r', 'fontsize', 16)
        new_filecount = filecount;
    end
end

robot_pressCR(1)

end

