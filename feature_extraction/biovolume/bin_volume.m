function [ ] = bin_volume( in_dir, file, out_dir )
%BIN_BLOBS Summary of this function goes here
%modified from bin_blobs

debug = false;

function log(msg) % not to be confused with logarithm function
    logmsg(['bin_volume ' msg],debug);
end

% load the zip file
log(['LOAD ' file]);
%http://ifcb-data.whoi.edu/mvco/IFCB1_2009_174_055621_blob.zip
targets = get_blob_bin_file([in_dir file]);
%nt = length(targets.targetNumber);
nt = length(targets.pid);
log(['PROCESSING ' num2str(nt) ' target(s) from ' file]);

%png_dir = [out_dir filesep regexprep(file,'.zip','')];
%mkdir(png_dir);
biovol = NaN(nt,1);
eqvdiam = biovol;
minoraxis = biovol;
majoraxis = biovol;
%png_paths = {};
% for each target
for i = 1:nt,
    target = {};
    % configure feature extraction
    %target.config = configure();
    % get the image
    target.blob_image = cell2mat(targets.image(i));
    % compute the blob mask (result in target.blob_image)
    target = biovolume(target);
    biovol(i) = nansum(target.Biovolume);
    eqvdiam(i) = nansum(target.EquivDiameter);
    majoraxis(i) = nansum(target.MajorAxisLength);
    minoraxis(i) = nansum(target.MinorAxisLength);
end
targets = rmfield(targets, 'image');
targets.Biovolume = biovol;
targets.EquivDiameter = eqvdiam;
targets.MajorAxisLength = majoraxis;
targets.MinorAxisLength = minoraxis;
archive = [out_dir regexprep(file,'_blob.zip','')];
save(archive, 'targets');

log(['SAVING ' archive]);

%rmdir(png_dir,'s');

log(['DONE ' file]);

end

