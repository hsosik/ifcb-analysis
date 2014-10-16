function [ ] = organize_daydir( inpath, outpath )
%function [ ] = organize_daydir( inpath, outpath )
%   Move IFCB data files from location specified by 'inpath' into daily
%   sub-directories created (if needed) under 'outpath'
%   If only one path is specified, outpath = inpath
%example: organize_daydir( '\\sosiknas1\IFCB_data\IFCB2_C211A_SEA2007\data\', '\\sosiknas1\IFCB_data\IFCB2_C211A_SEA2007\data\' )
%equivalent to organize_daydir( '\\sosiknas1\IFCB_data\IFCB2_C211A_SEA2007\data\' )

if ~exist('outpath', 'var'),
    outpath = inpath;
end;

filelist = dir(fullfile(inpath, '*.roi'));
if isempty(filelist),
    disp('no roi files found')
    return
end;
filenames={filelist.name}';

if strmatch('I', filenames{1}(1)),
    dirstrlength = 14;
elseif strmatch('D', filenames{1}(1)),
    dirstrlength = 9;
else
    disp('no IFCB* or D* files detected')
    return
end;

filename_char = char(filenames);
day_filenames = filename_char(:,1:dirstrlength);
filenames_unique = unique(day_filenames,'rows');

for ii = 1:size(filenames_unique,1);
    dirname = fullfile(outpath,filenames_unique(ii,:));
    if ~exist(dirname,'dir')
        mkdir(dirname);
    end
    source_str = [fullfile(inpath, filenames_unique(ii,:)) '*'];
    movefile(source_str, dirname)
end