function [ ] = bin_blobs( in_dir, file, out_dir )
%BIN_BLOBS Summary of this function goes here

debug = false;

function log(msg) % not to be confused with logarithm function
    logmsg(['bin_blobs ' msg],debug);
end

archive = [out_dir filesep regexprep(file,'.zip','_blobs.zip')];
if exist(archive,'file'),
    log(['SKIPPING ' file]);
    return
end

% load the zip file
log(['LOAD ' file]);
targets = get_bin_file([in_dir filesep file]);
nt = length(targets.targetNumber);
log(['PROCESSING ' num2str(nt) ' target(s) from ' file]);

png_dir = [out_dir filesep regexprep(file,'.zip','')];
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
    png_path = [png_dir filesep regexprep(file,'.zip',sprintf('_%05d.png',targets.targetNumber(i)))];
    imwrite(target.blob_image,png_path,'bitdepth',1);
    png_paths = [png_paths; {png_path}];
end

zip(archive, png_paths, png_dir);

log(['SAVING ' archive]);

rmdir(png_dir,'s');

log(['DONE ' file]);

end

