%Heidi 9/26/11 work in progress towards new feature extraction incorporating refined blob ID approach;
%starting here with no stitching implemented and just one feature (summed large blob area);
%plan to work with Joe to add back stitching and other features during code "refactoring"

warning('off');

feapath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\features2\';
numfea = 1;
stitch_info_titles = {'first roi#' 'xpos1', 'ypos1', 'xpos2', 'ypos2'};
date = 'now'; % alternatively, could use any ISO 8601 timestamp
bins = list_bins(date);
for bin_ix = 1:1:length(bins),
    pid = char(bins(bin_ix));
    fprintf('Bin %d of %d : %s\n',bin_ix,length(bins),pid);
    tempname = [feapath lid(pid) '_features.mat'];
    if 0, exist(tempname,'file'),
        disp('already done');
        break;
    end
    targets = get_targets(pid);
    n = length(targets.targetNumber); % pick arbitrary column to count
    features = NaN.*zeros(numfea,n);
    for target = 1:n
        if rem(target-1,10) == 0
            fprintf('%d of %d\n',target,n);
        end;
        img = get_image(targets.pid(target));
        [features1, featitles] = getfeatures2(img,1); %combine phasecong3 and kmeans
        if ~isnan(features1(1)),
            if length(features1) ~= numfea, disp('Problem: numfea does not match length of feature vector'),end;
            features(:,target) = features1;
        end;
        %save([feapath filename(1:end-4) '_features'], 'features', 'imgnum', 'featitles');
        clear features Perimeters PixIdx FrDescp Centroid
        pack
    end;
end;
