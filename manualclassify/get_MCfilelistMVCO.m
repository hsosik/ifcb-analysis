function [MCconfig, filelist, classfiles, stitchfiles ] = get_MCfilelistMVCO( MCconfig )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

classfiles = [];
stitchfiles = [];
%%MVCO batch system
if true,
    filelist = get_filelist_manual([MCconfig.resultpath 'manual_list'],3,[2007:2012], 'all'); %manual_list, column to use, year to find
end;

%%other MVCO cases
if false,
    %basepath = '\\demi\vol2\';
    %filelist = dir([basepath '\IFCB5_2011_063\IFCB5_2011_063_2120*.adc']);    
    filelist = {'IFCB1_2012_151_152004' 'IFCB1_2012_151_154317'}; 
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

