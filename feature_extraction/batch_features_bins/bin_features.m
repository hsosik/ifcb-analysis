function [ ] = bin_features( in_dir, file, out_dir, opt1 , in_dir_blob, log_callback)
%function [ ] = bin_features( in_dir, file, out_dir )
%BIN_FEATURES Summary of this function goes here
%modified from bin_blobs
%Modified to incorporate biovolume computations (taken from bin_volume.m), Jan 2013
%Heidi M. Sosik, Woods Hole Oceanographic Institution
%
%March 2015, Heidi - updated to handle case for no web services access (local
%access for Rois and blobs)

debug = false;  %USER leave as is, not for parallel processing

function log(msg) % not to be confused with logarithm function
    m = ['bin_features ' msg];
    if exist('log_callback','var')
        log_callback(m);
    else
        logmsg(m,debug);
    end
end

% FIXME for more options, iterate over varags
if ~exist('opt1', 'var') || isempty(opt1),
  chatty = false;
elseif opt1 == 'chatty',
  chatty = true;
end

% load the zip file
log(['LOAD targets ' file]);
%http://ifcb-data.whoi.edu/mvco/IFCB1_2009_174_055621_blob.zip
[~,~,x] = fileparts(file);
roi_flag = strmatch('.roi',x);
if roi_flag
    targets = get_images_fromROI([in_dir file]);
else %assume zip
    targets = get_bin_file([in_dir file]);
end;
nt = length(targets.pid);
if nt > 0,
    log(['LOAD blobs ' file]);
    if roi_flag
        targets_blob = get_blob_bin_file([in_dir_blob regexprep(file, '.roi', '_blobs_v2.zip')]);
    else
        targets_blob = get_blob_bin_file([in_dir regexprep(file, '.zip', '_blob.zip')]);
    end;
end;
log(['PROCESSING ' num2str(nt) ' target(s) from ' file]);

config = configure();
target.config = config;
output.config = config;
empty_target = target;

for i = 1:nt,
    target = empty_target;
    % get the image
    target.image = cell2mat(targets.image(i));
    target.blob_image = cell2mat(targets_blob.image(i));
    target = blob_geomprop(target); 
    target = blob_rotate(target);
    target = blob_texture(target);
    target = blob_invmoments(target);
    target = blob_shapehist_stats(target);
    target = blob_RingWedge(target);
    target = biovolume(target);
    target = blob_sumprops(target);
    target = blob_Hausdorff_symmetry(target);
    target = blob_binary_symmetry(target);
    target = image_HOG(target);
    target = blob_rotated_geomprop(target);
    temp.features(i) = merge_structs(target.blob_props, target.image_props);
    if chatty && rem(i,100) == 0,
      log(['PROCESSED ' char(targets.pid(i)) ' (' num2str(i) ' of ' num2str(nt) ')']);
    end;
end

if nt > 0,
    temp.pid = targets.pid;
    [ feature_mat, featitles, multiblob_features, multiblob_titles ] = make_feature_matrices(temp);

    %write the compiled feature csv file
    fileout = regexprep(file, '.zip', '_fea_v3.csv');
    fileout = regexprep(fileout, '.roi', '_fea_v3.csv');
    log(['SAVING ' fileout]);
   
    csvwrite_with_headers( [out_dir fileout], feature_mat, featitles );
    
    %write the raw multi-blob features to separate csv file
    fileout = regexprep(file, '.zip', '_multiblob_v3.csv');   
    fileout = regexprep(fileout, '.roi', '_multiblob_v3.csv');   
    if ~isempty(multiblob_features),
        mkdir([out_dir filesep 'multiblob']);
        csvwrite_with_headers( [out_dir filesep 'multiblob' filesep fileout], multiblob_features, multiblob_titles );
    end; 
    log(['DONE ' file]);
else
    log(['no targets SKIPPING ' file]);
end;
end

