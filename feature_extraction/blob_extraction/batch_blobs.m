function [ ] = batch_blobs( in_dir, out_dir, bins )
% Accept parameters specifying a directory or web service URL full of .zip files (one for each bin) 
% and a directory in which to place the output .zip files, and a list of the files (bins) to process
% Start a matlab pool
% Process the bins in parallel.
% Log progress and errors (so the calling script can monitor progress and detect failures)
% Clean up all temporary storage
% Shut down the pool
% Report completion status
% batch_blobs('http://ifcb-data.whoi.edu/underway/', 'G:\work\Healy1001\blobs\');
% modified from Joe's day_blobs, Heidi Aug 2012

debug = false; %change to true to skip parallel processing

function log(msg) % not to be confused with logarithm function
    logmsg(['batch_blobs ' msg],debug);
end

if not(debug),
    try
        matlabpool;
        log('POOL - started');
    catch e %#ok<NASGU>
        log('WARNING - workers cannot start, or already active');
    end;
end


disp(['processing ' num2str(length(bins)) ' files'])
if not(debug),
    parfor bincount = 1:length(bins)
        try
            %bin_blobs_heidi(in_dir, daydir(daycount).name, out_dir);
            bin_blobs_heidi(in_dir, [char(bins(bincount)) '.zip'], out_dir);
        catch e
   	    logmsg(['day_blobs FAIL ' bins(bincount).name],debug);
        end
    end
else
    for bincount = 1:length(bins)
        %bin_blobs_heidi(in_dir, daydir(daycount).name, out_dir);
        bin_blobs_heidi(in_dir, [char(bins(bincount)) '.zip'], out_dir);
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

