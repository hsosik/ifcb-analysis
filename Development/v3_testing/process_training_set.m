clear;

csv='\\sosiknas1\Lab_data\Futrelle\training_set.csv';
fid=fopen(csv);
ts = textscan(fid,'%s%s','delimiter',',');
fclose(fid);

DIR='\\sosiknas1\IFCB_products\MVCO\MVCO_train_Aug2015\';

chunk_size = 5000;

for chunk=3:11
    clearvars config target output temp classes;
    config = configure();
    target.config = config;
    output.config = config;
    empty_target = target;

    temp.pid = {};
    classes = {};

    total_pixels = 0;
    n = numel(ts{1});
    start = (chunk * chunk_size)+1;
    finish = min(start+chunk_size-1,numel(ts{1}));
    for i=start:finish
        ix = i-start+1;
        cls = char(ts{1}(i));
        classes{ix} = cls;
        roi_lid = char(ts{2}(i));
        roi_pid = ['http://ifcb-data.whoi.edu/mvco/' char(ts{2}(i))];
        temp.pid{ix} = roi_lid;
        roi_path = [DIR cls '\' roi_lid '.png'];
        im = imread(roi_path);
        disp([sprintf('%05d',i) '/' num2str(n) ' ' roi_pid]);
        target = empty_target;
        % get the image
        target.image = im;
        % FIXME debug
        %target.blob_image = cell2mat(targets_blob.image(i));
        target = blob(target);
        % end debug
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
        target = merge_structs(target.blob_props, target.image_props);
        temp.features(ix) = target;
    end

    [ feature_mat, featitles, multiblob_features, multiblob_titles ] = make_feature_matrices(temp);

    outpath = ['\\sosiknas1\Lab_data\Futrelle\' sprintf('mat_v3_ts_%05d_%05d.mat',start,finish)];

    pid = temp.pid;

    disp(['saving in ' outpath]);
    save(outpath,'pid','classes','feature_mat','featitles');
    disp('done');
end



