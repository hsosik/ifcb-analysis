function [MCconfig, filelist, classfiles, stitchfiles ] = get_MCfilelistDock( MCconfig )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

classfiles = [];
stitchfiles = [];
%basepath = '\\queenrose\e_work\IFCB_dock\data\';
basepath = '\\queenrose\e_work\Emily_Peacock\data\';
%%other MVCO cases
if true,
    %filepath = '\\queenrose\e_work\IFCB_dock\data\D2013\D20130205\';
    filepath = '\\queenrose\e_work\Emily_Peacock\data\D2013\D20130405\';
    filelist = dir([filepath '*.adc']);    
    %filelist = {'IFCB1_2012_151_152004' 'IFCB1_2012_151_154317'}; 
end;
classpath = [];

if isempty(filelist),
%    disp('No files found. Check paths or file specification in get_MCconfig.')
    return
end;

[filelist, classfiles] = resolve_files(filelist, basepath, classpath, MCconfig.class_filestr);
%[filelist, classfiles, stitchfiles] = resolve_MVCOfiles(filelist, MCconfig.class_filestr);

[~,f]= fileparts(filelist{1}); 
if f(1) == 'I',
    MCconfig.dataformat = 0;
elseif f(1) == 'D',
    MCconfig.dataformat = 1;
end;

end

