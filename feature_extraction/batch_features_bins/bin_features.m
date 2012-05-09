function [ ] = bin_features( in_dir, file, out_dir )
%function [ ] = bin_features( in_dir, file, out_dir )
%BIN_FEATURES Summary of this function goes here
%modified from bin_blobs

debug = true;

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
temp.pid = targets.pid;
[ feature_mat, featitles, multiblob_features, multiblob_titles ] = make_feature_matrices(temp);

%write the compiled feature csv file
fileout = regexprep(file, '.zip', '_fea_v1.csv');
log(['SAVING ' fileout]);
fid = fopen([out_dir fileout], 'w');
for ii = 1:length(featitles)-1, fprintf(fid, '%s,', char(featitles(ii)));, end; 
fprintf(fid, '%s\r\n ', char(featitles(end))); fclose(fid);
dlmwrite([out_dir fileout], feature_mat, '-append')
%write the raw multi-blob features to separate csv file
fileout = regexprep(file, '.zip', '_multiblob_v1.csv');
fid = fopen([out_dir fileout], 'w');
for ii = 1:length(multiblob_titles)-1, fprintf(fid, '%s,', char(multiblob_titles(ii))); end; 
fprintf(fid, '%s\r\n', char(multiblob_titles(end))); fclose(fid);
dlmwrite([out_dir 'multiblob\' fileout], multiblob_features, '-append')

%save([out_dir fileout], 'out')
%rmdir(png_dir,'s');

log(['DONE ' file]);

end

