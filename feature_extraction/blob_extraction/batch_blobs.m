function [ ] = batch_blobs( in_dir, out_dir, bins, parflag)
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

debug = true; %change to true to skip parallel processing
if exist('parflag', 'var')
    if parflag
        debug = false; %use parallel processing
    end
end

function log(msg) % not to be confused with logarithm function
    logmsg(['batch_blobs ' msg],debug);
end

if not(debug),
    try
        parpool;
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
            if length(in_dir) > 1
                bin_blobs_heidi(in_dir{bincount}, [char(bins(bincount)) '.roi'], out_dir{bincount});
            else
                bin_blobs_heidi(in_dir, [char(bins(bincount)) '.zip'], out_dir);
            end;
        catch e
   	    logmsg(['day_blobs FAIL ' bins(bincount).name],debug);
        end
    end
else
    for bincount = 1:length(bins)
        %bin_blobs_heidi(in_dir, daydir(daycount).name, out_dir);
        if length(in_dir) >= length(bins) && ~isequal('http', in_dir{bincount}(1:4))
            bin_blobs_heidi(in_dir{bincount}, [char(bins(bincount)) '.roi'], out_dir{bincount});
        else
            bin_blobs_heidi(in_dir, [char(bins(bincount)) '.zip'], out_dir);
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

