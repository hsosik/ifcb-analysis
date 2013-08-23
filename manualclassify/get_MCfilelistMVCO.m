function [MCconfig, filelist, classfiles, stitchfiles ] = get_MCfilelistMVCO( MCconfig )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

classfiles = [];
stitchfiles = [];
%%MVCO batch system
if true,
    filelist = get_filelist_manual([MCconfig.resultpath 'manual_list'],3,[2006:2012], 'all'); %manual_list, column to use, year to find
end;

%%other MVCO cases
if false,
    basepath = '\\demi\vol1\';
    filelist = dir([basepath 'IFCB5_2013_064\*.adc']);    
end;

if isempty(filelist),
%    disp('No files found. Check paths or file specification in get_MCconfig.')
    return
end;

[filelist, classfiles, stitchfiles] = resolve_MVCOfiles(filelist, MCconfig.class_filestr);

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

