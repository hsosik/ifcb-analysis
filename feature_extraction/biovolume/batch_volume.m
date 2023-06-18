
function [ ] = batch_volume(in_dir, filelist, out_dir )
% Accept a list of bin files to process and a directory in which to place the output volume files
% Start a matlab pool
% Process the bins in parallel.
% Log progress and errors (so the calling script can monitor progress and detect failures)
% Clean up all temporary storage
% Shut down the pool
% Report completion status
% batch_volume modified by Heidi Sosik from day_blobs.m (by Joe Futrelle)

debug = false;

function log(msg) % not to be confused with logarithm function
    logmsg(['day_biovolume ' msg],debug);
end

if not(debug),
    try
        matlabpool;
        log('POOL - started');
    catch e %#ok<NASGU>
        log('WARNING - workers cannot start, or already active');
    end;
end

%daydir = dir([in_dir filesep '*.zip']);

if not(debug),
    parfor filecount = 1:length(filelist)
        bin_volume(in_dir, [char(filelist(filecount)) '_blob.zip'], out_dir);
        %bin_volume(in_dir, [char(filelist(filecount)) '_blobs_v2.zip'], out_dir);
    end
else
    for filecount = 1:length(filelist)
        bin_volume(in_dir, [char(filelist(filecount)) '_blob.zip'], out_dir);
        %bin_volume(in_dir, [char(filelist(filecount)) '_blobs_v2.zip'], out_dir);
    end
end


if not(debug),
    try
        matlabpool close;
        log('POOL - stopped');
    catch e %#ok<NASGU>
        log('WARNING - workers cannot stop, or already stopped');
    end;
end

end

