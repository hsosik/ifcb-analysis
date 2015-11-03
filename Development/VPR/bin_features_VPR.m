function [ ] = bin_features_VPR( hrname, blobname, feaname, feaname_multi)
%function [ ] = bin_features_VPR( hrname, blobname, feaname, feaname_multi)
% modeled from bin_features.m, with a few details for VPR application
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2014


config = configure();
target.config = config;
output.config = config;
empty_target = target;

disp([hrname '    reading blob images'])
%[targets, imglist] = get_images_fromVPRhr(hrname);
targets_blob = get_blob_bin_file(blobname);
disp([hrname '    computing features...'])
imglist = dir(fullfile(hrname, '*.tif'));
imglist = {imglist.name};
nt = length(imglist);
for ii = 1:nt,
    target = empty_target;
    % get the image
    %target.image = targets(ii).image;
    fullimgname = char(fullfile(hrname,imglist(ii)));
    target.image = imread(fullimgname);
    target.blob_image = cell2mat(targets_blob.image(ii));
    target = blob_geomprop(target); 
    target = blob_rotate(target);
    target = blob_texture(target);
    target = image_texture(target); %test new added texture features for whole image
    target = blob_invmoments(target);
    target = blob_shapehist_stats(target);
    target = blob_RingWedge(target);
    target = biovolume(target);
    target = blob_sumprops(target);
    target = blob_Hausdorff_symmetry(target);
    target = image_HOG(target);
    target = blob_rotated_geomprop(target);
    temp.features(ii) = merge_structs(target.blob_props, target.image_props);
    temp.pid(ii) = regexprep(imglist(ii), '.tif', '');
end

if nt > 0,
    %temp.pid = targets.pid;
    disp([feaname '    writing features...'])
    [ feature_mat, featitles, multiblob_features, multiblob_titles ] = make_feature_matricesVPR(temp);

    %write the compiled feature csv file
    fileout = [char(feaname) '_fea_v3.csv'];
    csvwrite_with_headers( fileout, feature_mat, featitles );
    
    %write the raw multi-blob features to separate csv file
    fileout = [char(feaname_multi) '_multiblob_v3.csv'];

    if ~isempty(multiblob_features),
        csvwrite_with_headers( fileout, multiblob_features, multiblob_titles );
    end; 
    disp([feaname '    done'])
else
    disp(['no targets SKIPPING ' feaname]);
end;

end


