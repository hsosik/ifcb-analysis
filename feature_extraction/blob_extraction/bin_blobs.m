function [ ] = bin_blobs( bin_pid, bin_zip_path, out_dir, log_callback )
%BIN_BLOBS Summary of this function goes here

debug = false;

function log(msg) % not to be confused with logarithm function
    m = ['bin_blobs ' char(msg)];
    if exist('log_callback','var')
        log_callback(m);
    else
        disp(m);
    end
end

bin_lid = lid(bin_pid);

archive = [out_dir filesep [bin_lid '_blobs_v2.zip']];
if exist(archive,'file'),
    log(['SKIPPING ' bin_lid]);
    return
end

% load the zip file
log(['LOAD ' bin_pid]);
try
    targets = get_bin_file(bin_zip_path);
    nt = length(targets.targetNumber);
catch ME
    idSegLast = regexp(ME.identifier, '(?<=:)\w+$', 'match');
    if strcmp(idSegLast, 'NoInput')
        log(['WARNING missing data in ' bin_pid]);
    end
    nt = 0;
end

log(['PROCESSING ' num2str(nt) ' target(s) from ' bin_pid]);

png_dir = [out_dir filesep bin_lid];
mkdir(png_dir);

png_paths = {};
% for each target
for i = 1:nt,
    target = {};
    % configure feature extraction
    target.config = configure();
    % get the image
    target.image = cell2mat(targets.image(i));
    % compute the blob mask (result in target.blob_image)
    target = blob(target);
    % now output the blob image as a 1-bit png
    png_path = [png_dir filesep bin_lid sprintf('_%05d.png',targets.targetNumber(i))];
    imwrite(target.blob_image,png_path,'bitdepth',1);
    if rem(i,100) == 0,
        log(['PROCESSED ' char(targets.pid(i)) ' (' num2str(i) ' of ' num2str(nt) ')']);
    end
    png_paths = [png_paths; {png_path}];
end

if nt > 0
    log(['SAVING ' archive]);

    zip(archive, png_paths, png_dir);
else
    log(['NOT SAVING zip file: missing data in ' bin_pid])
end

log(['DELETING temporary files in ' png_dir ' ...'])

rmdir(png_dir,'s');

log(['DONE ' bin_pid]);

end

