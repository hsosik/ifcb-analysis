function [MCconfig, filelist, classfiles, stitchfiles ] = get_MCfilelistMVCO( MCconfig )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

classfiles = [];
stitchfiles = [];
%%MVCO batch system
if false,
    filelist = get_filelist_manual([MCconfig.resultpath 'manual_list'],7,[2009], 'only'); %manual_list, column to use, year to find
end;

%%other MVCO cases
if true,
    basepath = '\\demi\vol2\';
    filelist = dir([basepath '\IFCB5_2010_360\*.adc']);    
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

end

