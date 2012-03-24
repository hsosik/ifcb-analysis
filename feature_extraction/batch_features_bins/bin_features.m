function [ ] = bin_volume( in_dir, file, out_dir )
%BIN_BLOBS Summary of this function goes here
%modified from bin_blobs

debug = false;

function log(msg) % not to be confused with logarithm function
    logmsg(['bin_features ' msg],debug);
end

% load the zip file
log(['LOAD ' file]);
%http://ifcb-data.whoi.edu/mvco/IFCB1_2009_174_055621_blob.zip
targets = get_bin_file([in_dir file]);
nt = length(targets.pid);
log(['PROCESSING ' num2str(nt) ' target(s) from ' file]);

config = configure();
target.config = config;
output.config = config;
empty_target = target;

for i = 1:nt,
    target = empty_target;
    % get the image
    target.image = cell2mat(targets.image(i));
    target = blob(target);
    target = apply_blob_min( target ); %get rid of blobs < blob_min

    target = blob_rotate(target);
    target = blob_geomprop(target); 
    target = blob_texture(target);
    target = blob_invmoments(target);
    target = blob_shapehist_stats(target);
    target = blob_RingWedge(target);
    target = blob_sumprops(target);
    target = blob_Hausdorff_symmetry(target);
    target = image_HOG(target);
    target = blob_rotated_geomprop(target);
    temp.features(i) = merge_structs(target.blob_props, target.image_props);
%        temp.images(i).blob_image = target.blob_image;
%        temp.images(i).blob_image_rotated = target.blob_image_rotated;
%        temp.images(i).image = target.image;
end

out = temp;
fileout = regexprep(file, 'zip', 'mat')
save([out_dir fileout], 'out')

log(['SAVING ' fileout]);

%rmdir(png_dir,'s');

log(['DONE ' file]);

end

