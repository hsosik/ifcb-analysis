
in_dir = '\\QUEENROSE\IFCB14_Dock\ditylum\Ben_data\';%USER 
in_dir_blob = '\\QUEENROSE\IFCB14_Dock\ditylum\Ben_blobs\'; %USER main blob output location
out_dir = '\\QUEENROSE\IFCB14_Dock\ditylum\Ben_features\'; %USER

bins = dir([in_dir '*.adc']);
bins = regexprep({bins.name}', '.adc', '');
bins_done = dir([out_dir '*.csv']);
bins_done = regexprep({bins_done.name}', '_fea_v2.csv', '');
bins = setdiff(bins, bins_done);

config = configure();
target.config = config;
output.config = config;
empty_target = target;

for bincount = 1:length(bins),
    disp(bins(bincount))
    %png_path = [out_dir bins{bincount}  filesep];
    png_path = [out_dir filesep];
    png_path2 = [out_dir filesep 'multiblob' filesep ];
    if ~exist('png_path', 'dir'),
        mkdir(png_path)
        mkdir(png_path2)
    end;
    [targets, imglist] = get_images_fromROI([in_dir bins{bincount} '.roi']);
    targets_blob = get_blob_bin_file([in_dir_blob  bins{bincount} '.zip']);

    for i = 1:length(imglist),
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
        target = image_HOG(target);
        target = blob_rotated_geomprop(target);
        temp.features(i) = merge_structs(target.blob_props, target.image_props);
        temp.pid(i) = regexprep(imglist(i), '.png', '');
    end
    
    [ feature_mat, featitles, multiblob_features, multiblob_titles ] = make_feature_matrices(temp);
    clear temp
    
    fileout = [bins{bincount} '_fea_v2.csv'];
    %write the compiled feature csv file
    
    ds = dataset([feature_mat featitles]);
    export(ds, 'file', [out_dir fileout], 'delimiter', ',');
    
    %write the raw multi-blob features to separate csv file
    fileout = [bins{bincount} '_multiblob_v2.csv'];
    if ~isempty(multiblob_features), 
        ds = dataset([multiblob_features multiblob_titles]);
        export(ds, 'file', [out_dir 'multiblob' filesep fileout], 'delimiter', ',');       
    end; 
      
end


