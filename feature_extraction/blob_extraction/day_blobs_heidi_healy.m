function [ ] = day_blobs_heidi( in_dir, out_dir )
% Accept parameters specifying a directory full of .zip files (one for each bin) and a directory in which to place the output .zip files
% Start a matlab pool
% Process the bins in parallel.
% Log progress and errors (so the calling script can monitor progress and detect failures)
% Clean up all temporary storage
% Shut down the pool
% Report completion status
%day_blobs_heidi_healy('http://ifcb-data.whoi.edu/Healy1101_underway/', 'G:\work\Healy1101\blobs\');

debug = true;

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

%bins =  dir(['\\floatcoat\LaneyLab\projects\HLY1101\data\IFCB8\sta53_67_casts\ifcb*.adc']);
%bins =  dir(['\\floatcoat\LaneyLab\projects\HLY1101\data\IFCB8\sta55_56_transit\ifcb*.adc']);
%bins =  dir(['\\floatcoat\LaneyLab\projects\HLY1101\data\IFCB8\sta75_76_transit\ifcb*.adc']);
bins =  dir(['\\floatcoat\LaneyLab\projects\HLY1101\data\IFCB8\underway\ifcb*.adc']);
bins = bins(find([bins.bytes]>0));
bins2 = dir([out_dir 'ifcb*']);
bins = regexprep({bins.name}, '.adc', ''); 
%load icelist
bins2 = regexprep({bins2.name}, '_blobs_v2.zip', '');
[~,ii] = setdiff(bins, bins2);
bins = bins(ii);
bins = setdiff(bins, {'IFCB8_2011_177_002813' 'IFCB8_2011_178_025716' 'IFCB8_2011_178_220757' 'IFCB8_2011_178_064346' 'IFCB8_2011_206_131152'}); %gives zip error
bins = {'IFCB8_2011_210_011714'};

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

