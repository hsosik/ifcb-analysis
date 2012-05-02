function [ ] = day_blobs_heidi( in_dir, out_dir )
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

%daydir = dir([in_dir filesep '*.zip']);
%daydir = dir(['\\demi\ifcbnew\ifcb5_2012_001\*.roi']);
days =  dir(['\\demi\ifcbnew\ifcb5_2012_02*']);
days2 = [dir(['\\demi\ifcbnew\ifcb5_2012_009*']); dir(['\\demi\ifcbnew\ifcb5_2012_029*']); dir(['\\demi\ifcbnew\ifcb5_2012_039*']);...
    dir(['\\demi\ifcbnew\ifcb5_2012_046*']); dir(['\\demi\ifcbnew\ifcb5_2012_052*']); dir(['\\demi\ifcbnew\ifcb5_2012_066*']); dir(['\\demi\ifcbnew\ifcb5_2012_078*'])];
[~,ii] = setdiff({days.name}, {days2.name});
days = days(ii);
daydir = [];
for ii = 1:length(days),
    daydir = [daydir; dir(['\\demi\ifcbnew\' days(ii).name '\*.adc'])];
end;
daydir_done = dir([out_dir '*.zip']);
done = {daydir_done.name}';
done = regexprep(done, '_blobs_v2.zip', '');
daydir = {daydir.name}';
daydir = regexprep(daydir, '.adc', '');
daydir = setdiff(daydir, done);
disp(['processing ' num2str(length(daydir)) ' files'])
if not(debug),
    parfor daycount = 1:length(daydir)
        try
            %bin_blobs_heidi(in_dir, daydir(daycount).name, out_dir);
            bin_blobs_heidi(in_dir, [char(daydir(daycount)) '.zip'], out_dir);
        catch e
   	    logmsg(['day_blobs FAIL ' daydir(daycount).name],debug);
        end
    end
else
    for daycount = 1:length(daydir)
        %bin_blobs_heidi(in_dir, daydir(daycount).name, out_dir);
        bin_blobs_heidi(in_dir, [char(daydir(daycount)) '.zip'], out_dir);
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

