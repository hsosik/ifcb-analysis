function [ ] = batch_classify(in_dir, filelist, out_dir, classifierName)
% Accept a list of features files to process and a directory in which to place the output class files
% Start a matlab pool
% Process the bins in parallel.
% Log progress and errors (so the calling script can monitor progress and detect failures)
% Clean up all temporary storage
% Shut down the pool
% Report completion status
% batch_volume modified by Heidi Sosik from day_blobs.m (by Joe Futrelle)
% then modified to batch_classify, also by Heidi 

debug = true;

function log(msg) % not to be confused with logarithm function
    logmsg(['day_blobs ' msg],debug);
end

if not(debug),
    try
        %matlabpool;
        matlabpool local;
        log('POOL - started');
    catch e %#ok<NASGU>
        log('WARNING - workers cannot start, or already active');
    end;
end

config = config_classifier(classifierName);
if ~exist(out_dir, 'dir')
    mkdir(out_dir)
end;

if not(debug),
    parfor filecount = 1:length(filelist)
        %bin_classify(in_dir, [char(filelist(filecount)) '.zip'], out_dir);
        bin_classify(in_dir, [char(filelist(filecount))], out_dir, config);
    end
else
    for filecount = 1:length(filelist)
        %bin_classify(in_dir, [char(filelist(filecount)) '.zip'], out_dir);
        bin_classify(in_dir, [char(filelist(filecount))], out_dir, config);
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

