function [ ] = day_blobs_heidi( in_dir, out_dir )
% Accept parameters specifying a directory full of .zip files (one for each bin) and a directory in which to place the output .zip files
% Start a matlab pool
% Process the bins in parallel.
% Log progress and errors (so the calling script can monitor progress and detect failures)
% Clean up all temporary storage
% Shut down the pool
% Report completion status
%day_blobs_heidi_healy('http://ifcb-data.whoi.edu/underway/', 'G:\work\Healy1001\blobs\');

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

%bins =  dir(['\\floatcoat\LaneyLab\projects\HLY1001\data\imager\asb\ifcb*.adc']);
bins =  dir(['\\floatcoat\LaneyLab\projects\HLY1001\data\imager\ice_stations\ice_cores\STA101\Light_Ice\ifcb*.adc']);
bins2 = dir([out_dir 'ifcb*']);
bins = regexprep({bins.name}, '.adc', ''); 
%load icelist
bins2 = regexprep({bins2.name}, '.zip', '');
[~,ii] = setdiff(bins, bins2);
bins = bins(ii);

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

