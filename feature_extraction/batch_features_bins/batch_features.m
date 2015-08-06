
function [ ] = batch_features(in_dir, filelist, out_dir, in_dir_blob, parflag )
% Accept a list of bin files to process and a directory in which to place the output volume files
% Start a matlab pool
% Process the bins in parallel.
% Log progress and errors (so the calling script can monitor progress and detect failures)
% Clean up all temporary storage
% Shut down the pool
% Report completion status
% batch_volume modified by Heidi Sosik from day_blobs.m (by Joe Futrelle)
% revised input to include optional in_dir_blob = list of directory
% locations for case for local access (not web services), Heidi M. Sosik, March 2015

debug = true; %false for parallel processing, true for sequential on one process
if exist('parflag', 'var')
    if parflag
        debug = false; %use parallel processing
    end
end

function log(msg) % not to be confused with logarithm function
    logmsg(['day_blobs ' msg],debug);
end

if not(debug),
    try
        pool = parpool;
        %pool = parpool(4);
        log('POOL - started');
    catch e %#ok<NASGU>
        log('WARNING - workers cannot start, or already active');
    end;
end

%daydir = dir([in_dir filesep '*.zip']);

if not(debug),
    if exist('in_dir_blob', 'var')
        parfor filecount = 1:length(filelist)
             bin_features(in_dir{filecount}, [char(filelist(filecount)) '.roi'], out_dir, [], in_dir_blob{filecount});
        end
    else
        parfor filecount = 1:length(filelist)
           bin_features(in_dir, [char(filelist(filecount)) '.roi'], out_dir, []);
        end;
    end
else
    for filecount = 1:length(filelist)
        if exist('in_dir_blob', 'var')
            bin_features(in_dir{filecount}, [char(filelist(filecount)) '.roi'], out_dir, [], in_dir_blob{filecount});
        else
            bin_features(in_dir, [char(filelist(filecount)) '.roi'], out_dir, []);
        end;
    end
end


if not(debug),
    try
        delete(pool)
        log('POOL - stopped');
    catch e %#ok<NASGU>
        log('WARNING - workers cannot stop, or already stopped');
    end;
end

end

