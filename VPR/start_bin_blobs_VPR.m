function [ ] = start_bin_blobs_VPR (day_in_path, blob_out_path, parflag)
%function [ ] = start_bin_blobs_VPR (day_in_path, blob_out_path, parflag)
%e.g., start_bin_blobs_VPR ('\\maddie\work\VPR\vpr3\', '\\maddie\work\VPR\vpr3\blobs\')
% produce IFCB style blob masks for VPR images,
% assumes tiff files organized in folders by day, then hour
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2014

daylist = dir([day_in_path filesep 'd*']);
daylist = {daylist([daylist.isdir]).name};
hrlist = [];
bloblist = [];
ji = findstr(filesep, day_in_path);
vprstr = day_in_path(ji(end-1)+1:ji(end)-1);
cruisestr = day_in_path(ji(end-2)+1:ji(end-1)-1);

for ii = 1:length(daylist)
    junk = dir([day_in_path filesep daylist{ii} filesep 'h*']);
    junk = {junk([junk.isdir]).name};
    hrlist = [hrlist; fullfile(day_in_path,daylist{ii},junk)'];
    %bloblist = [bloblist; fullfile(blob_out_path, cellstr([repmat([cruisestr vprstr  daylist{ii}], length(junk),1) char(junk)]))];
    bloblist = [bloblist; fullfile(blob_out_path, cellstr([repmat([daylist{ii}], length(junk),1) char(junk)]))];
end;
clear junk

if ~exist('parflag', 'var')
    parflag = 0;
end;

if parflag
    try
        mypool = parpool('IdleTimeout', 360);
        disp('POOL - started');
    catch e %#ok<NASGU>
        log('WARNING - workers cannot start, or already active');
    end;
    parfor bincount = 1:length(hrlist)
        if ~exist([bloblist{bincount} '.zip'], 'file')
            bin_blobs_VPR(hrlist{bincount}, bloblist{bincount});
        else
            disp([bloblist{bincount} ' already done'])
        end;
    end;
    delete(mypool)
else
    for bincount = 1:length(hrlist)
        if ~exist([bloblist{bincount} '.zip'], 'file')
            bin_blobs_VPR(hrlist{bincount}, bloblist{bincount});
        else
            disp([bloblist{bincount} ' already done'])
        end;
    end;
end;

return



