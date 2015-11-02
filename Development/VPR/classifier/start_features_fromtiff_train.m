%start_features_fromtiff_train.m
%configure and initiate batch processing for feature extractio
%VPR case
%Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2014

in_dir= '\\sosiknas1\Lab_data\VPR\NBP1201NewTrain201502\rois\'; %USER 
in_dir_blob = '\\sosiknas1\Lab_data\VPR\NBP1201NewTrain201502\blobs\'; %USER main blob output location
out_dir = '\\sosiknas1\Lab_data\VPR\NBP1201NewTrain201502\features\';

%bins = dir([in_dir '*.adc']);
%bins = regexprep({bins.name}', '.adc', '');

bins = dir([in_dir]);
bins = {bins.name}; 
bins = bins(3:end);

config = configure();
target.config = config;
output.config = config;
empty_target = target;

for bincount = 1:length(bins),
    disp(bins(bincount))
    multi_path = [out_dir 'multiblob' filesep];
    if ~exist(out_dir, 'dir'),
        mkdir(out_dir)
        mkdir(multi_path)
    end;
    imglist = dir([in_dir bins{bincount} filesep '*.tif']);
    imglist = {imglist.name}';
    for i = 1:length(imglist),
        target = empty_target;
        % get the image
        target.image = imread([in_dir bins{bincount} filesep imglist{i}]);
        target.blob_image = imread([in_dir_blob bins{bincount} filesep regexprep(imglist{i}, 'tif', 'png')]);
        target = blob_geomprop(target); 
        target = blob_rotate(target);
        target = blob_texture(target);
        target = blob_invmoments(target);
        target = blob_shapehist_stats(target);
        target = blob_RingWedge(target);
        target = biovolume(target);
        target = blob_sumprops(target);
        target = blob_Hausdorff_symmetry(target);
        target = image_HOG(target);
        target = blob_rotated_geomprop(target);
        temp.features(i) = merge_structs(target.blob_props, target.image_props);
        temp.pid(i) = regexprep(imglist(i), '.tif', '');
    end

    [ feature_mat, featitles, multiblob_features, multiblob_titles ] = make_feature_matricesVPR(temp);
    
    fileout = [bins{bincount} '_fea_v2.csv'];
    %write the compiled feature csv file
    %fileout = regexprep(file, '.zip', '_fea_v2.csv');
    
   % ds = dataset([feature_mat featitles]);
   % export(ds, 'file', [out_dir fileout], 'delimiter', ',');
    
    %write the compiled feature csv file
    %fileout = [char(feaname) '_fea_v2.csv'];
    csvwrite_with_headers( [out_dir fileout], feature_mat, featitles );
    
    
    %write the raw multi-blob features to separate csv file
    %fileout = regexprep(file, '.zip', '_multiblob_v2.csv');
    fileout = [bins{bincount} '_multiblob_v2.csv'];
    if ~isempty(multiblob_features), 
        csvwrite_with_headers( [multi_path fileout], multiblob_features, multiblob_titles );
     %   ds = dataset([multiblob_features multiblob_titles]);
     %   export(ds, 'file', [multi_path fileout], 'delimiter', ',');
    end; 
    
    clear temp

end
