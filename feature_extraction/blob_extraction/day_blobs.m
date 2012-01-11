function [ ] = day_blobs( in_dir, out_dir )
% Accept parameters specifying a directory full of .zip files (one for each bin) and a directory in which to place the output .zip files
% Start a matlab pool
% Process the bins in parallel.
% Log progress and errors (so the calling script can monitor progress and detect failures)
% Clean up all temporary storage
% Shut down the pool
% Report completion status

debug = false;

function log(msg) % not to be confused with logarithm function
    logmsg(['day_blobs ' msg],debug);
end

if not(debug),
    try
        matlabpool;
        log('POOL - started');
    catch e %#ok<NASGU>
        log('WARNING - workers cannot start, or already active');
    end;
end

daydir = dir([in_dir filesep '*.zip']);

if not(debug),
    parfor daycount = 1:length(daydir)
        try
            bin_blobs(in_dir, daydir(daycount).name, out_dir);
        catch e
   	    logmsg(['day_blobs FAIL ' daydir(daycount).name],debug);
        end
    end
else
    for daycount = 1:length(daydir)
        bin_blobs(in_dir, daydir(daycount).name, out_dir);
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

