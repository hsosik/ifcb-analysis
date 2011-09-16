function [] = main()

%modified from gettrainingfeatures3c_lowres and gettrainingfeatures4, new approach saving
%results by directory and check to update, 2/26/05

%modified from streamfeatures_24jun05 to include stitching of overlapping pairs of rois
%from the same camera field, Heidi 29 Dec 2009
%edited 8 Jan 2010 to convert img_merge to uint8 and to handle case where
%no stitching is required

% modified to use parallel computing toolbox by Joe Futrelle 9/2011.

warning('off')

function log(msg)
    disp([datestr(now,'yyyy-mm-ddTHH:MM:SS') ' streamfeatures ' msg]);
end

roidaypath = '\\Cheese\G on K\IFCB\ifcb_data_MVCO_jun06\ ';
feapath = 'd:\work\IFCB1\ifcb_data_MVCO_jun06\features2009\';
stitchpath = 'd:\work\IFCB1\ifcb_data_MVCO_jun06\stitch2009s\';
path_separator = '\';
%roidaypath = '/Volumes/J_IFCB/ifcb_data_MVCO_jun06/';
%stitchpath = '/Users/jfutrelle/dev/heidiCode1/scratch/stitch/';
%feapath = '/Users/jfutrelle/dev/heidiCode1/scratch/features/fastRW/';
%path_separator = '/';

time_start = now;
daydir = dir([roidaypath 'IFCB1_2011_*']);

try
    matlabpool;
    log('POOL - started');
catch e %#ok<NASGU>
    log('WARNING - workers cannot start, or already active');
end

for daycount = 1:length(daydir)
    roipath = [roidaypath daydir(daycount).name path_separator];
    roifiles = dir([roipath '*.roi']);

    parfor filecount = 1:length(roifiles),
        get_roifile_features(roifiles(filecount), roipath, feapath, stitchpath);
    end; %for filecount
end; %for daycount

matlabpool close

time_end = now;
if time_end-time_start < 10/60/24, %5 minutes as day
    pause_sec = 1*3600;  %1 hour as seconds
    log(['SLEEP - ' num2str(pause_sec) 's']);
    pause(pause_sec);
end;

% clear all


streamfeatures_parallel
end
