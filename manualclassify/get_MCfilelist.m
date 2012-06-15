function [MCconfig, filelist, classfiles ] = get_MCfilelist( MCconfig )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

basepath = 'C:\work\IFCB11\';
classpath = MCconfig.classpath;
filelist = dir([basepath '\D2012\D20120615\*.adc']);

if isempty(filelist),
%    disp('No files found. Check paths or file specification in get_MCconfig.')
    classfiles = [];
    return
end;

[filelist, classfiles] = resolve_files(filelist, basepath, classpath, MCconfig.class_filestr);

[~,f]= fileparts(filelist{1}); 
if f(1) == 'I',
    MCconfig.dataformat = 0;
elseif f(1) == 'D',
    MCconfig.dataformat = 1;
end;
if strcmp(MCconfig.pick_mode, 'correct_or_subdivide')
    if isempty(classfiles)
        disp('No class files specified. Check path setting in get_MCconfig if you want to load classifier results.')
        disp('Hit enter to continue without classifier results.')
        pause
    else
        if ~exist(classfiles{1}, 'file'),
            disp('First class file not found. Check path setting in get_MCconfig if you want to load classifier results.')
            disp('Hit enter to continue without classifier results.')
            pause
        end;
    end;
end;

end

