function [MCconfig, filelist, classfiles ] = get_MCfilelist( MCconfig )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% index=2;
switch MCconfig.batchmode
    case 'no'
        basepath = MCconfig.basepath;
        classpath = MCconfig.classpath;
        %filelist = dir([basepath '\D2012\D20121121\*.adc'])
        filelist = dir([basepath MCconfig.filepath '*.adc'])
    case 'yes'
        classpath = MCconfig.classpath;
       % filelist = dir([basepath '\D2012\D20121121\*.adc'])
        filelist = dir([MCconfig.basepath MCconfig.filepath])
        basepath = MCconfig.basepath;
end


%removing files from the list to start at the required file
% filelist=filelist(index:end);

if isempty(filelist),
%    disp('No files found. Check paths or file specification in get_MCconfig.')
    classfiles = [];
    return
end;

[filelist, classfiles] = resolve_files_OKEX(filelist, basepath, classpath, MCconfig.class_filestr);

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

