function [] = get_cnn_score_table2(cnn_result_path, ...
    manual_list, trainlist_path, out_path, groups, classXgroup, ...
    keepTAGs)
% modified 2.13.2023 to integrate TAG'ed annotations here rather than in
% another step of the pipeline
% 
% modified from dylan_get_cnn_score_table.m on 1.31.2023 to speed things up
% and use manual_list rather than count_manual_current more intelligently
% 
% modified 11.21.2022 to remove where skip == 1 in mvco meta data
%
% modified 10.13.2022 to remove bleach damaged bins from all outputs.
% makes and saves a CNN classifier "score table" for validation of
% classifier predictions against manual annotation data
% 
% INPUTS:
% 1) cnn_result_path is the path to CNN class files you want to use
% 2) manual_list is a table summarizing the manual_list.mat results on the
% NAS (the file indicating which bins have completed manual annotations for
% each group)
% 3) trainlist_path is the path to the directory in sosiknas1\training_sets 
% training and validation image list, both of which are flagged as the 
% training set
% 4) out_path is where you want the score table (.mat) file saved 
% 5) groups is a cell array of group names. Should match variable names in
% manual_list. IMPORTANT: GROUPS NEED TO GO FROM BROADEST --> SMALLEST!! 
% the function overwrites score tables of individual classes included in
% multiple groups. So the table for Guinardia delicatula will be written
% 3x, and to ensure you get ALL of the available matchup data the
% "guinardia" group should be placed AFTER protists and diatoms...
% 6) classXgroup is a cell array of length(groups) that includes class labels 
% within each element of groups 
% 7) keepTAGs is a cell array of class-tag labels that should be treated as
% independent classes in CNN-human match-ups. class-tag labels not included
% here are aggregated to the parent class in all downstream analyses.

% todays date to append to file names:
ymd_str = num2str(yyyymmdd(datetime('now')));

% grab manual annotations from MVCO:
class_roi_table = class_roi_list_one_timeseries('mvco');
% class_roi_table = class_roi_list_one_bin('D20170414T165421_IFCB010');
[class_roi_table.file, class_roi_table.roi] = cellfun(@split_roi_id, class_roi_table.roi, "UniformOutput", false);
class_roi_table.roi = cell2mat(class_roi_table.roi);

% grab tag'ed manual annotations:
tag_roi_table = tag_roi_list_one_timeseries('mvco');
[tag_roi_table.file, tag_roi_table.roi] = cellfun(@split_roi_id, tag_roi_table.roi, "UniformOutput", false);
tag_roi_table.roi = cell2mat(tag_roi_table.roi);
bleached_binid = unique(tag_roi_table.file(ismember(tag_roi_table.taglabel, 'bleach damaged')));

% integrate tag'ed annotations with standard:
tag_roi_table.mano_anno = strcat(tag_roi_table.classlabel, '_TAG_', tag_roi_table.taglabel);
tag_roi_table = tag_roi_table(:, ["file", "roi" , "mano_anno"]);
tag_roi_table.mano_anno = strrep(tag_roi_table.mano_anno, ' ', '_');

%% loop over files to grab score data for roi's manually annotated as your 
% class of interest, or CNN false positives...

% read in ifcb metadata:
metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/mvco', weboptions('Timeout', 120));
% get skip bins for later:
skipme = metaT.pid(metaT.skip == 1);

% count roi's:
all_roict_table = table;
all_roict_table.file = metaT.pid;
all_roict_table.roict = metaT.n_images;

% training roi's:
p1 = [trainlist_path, 'training_images.list'];
p2 = [trainlist_path, 'validation_images.list'];
training_ids = readtable(p1, 'FileType', 'text', 'Delimiter', ' ', 'ReadVariableNames', false);
training_ids = convertCharsToStrings(training_ids.Var1);
training_ids = convertStringsToChars(extractAfter(extractAfter(extractAfter(training_ids, '/'), '/'), '/'));
training_ids2 = readtable(p2, 'FileType', 'text', 'Delimiter', ' ', 'ReadVariableNames', false);
training_ids2 = convertCharsToStrings(training_ids2.Var1);
training_ids2 = convertStringsToChars(extractAfter(extractAfter(extractAfter(training_ids2, '/'), '/'), '/'));
training_ids = cat(1, training_ids, training_ids2);

training_ids = strrep(training_ids, '.png', '');
training_ids = training_ids(cellfun(@contains, training_ids, repmat({'IFCB'}, length(training_ids), 1)));
train_roi = table;
[train_roi.file, train_roi.roi] = cellfun(@split_roi_id, training_ids, "UniformOutput", false);
train_roi.roi = cell2mat(train_roi.roi);

% add training to roict_table:
trainct_table = table;
[trainct_table.train_counts , trainct_table.file] = groupcounts(train_roi.file);
all_roict_table = outerjoin(all_roict_table, trainct_table, "Keys", "file", "MergeKeys", true);
all_roict_table.train_counts(isnan(all_roict_table.train_counts)) = 0;

% establish score table meta-data and flag training roi's:
all_meta = class_roi_table(:, ["file", "roi"]);
all_meta.mano_anno = class_roi_table.classname;
all_meta.trainset_flag = ismember(all_meta(:, ["file", "roi"]), ...
    train_roi(:, ["file", "roi"]), "rows");
all_meta = all_meta(ismember(all_meta.file, manual_list.file) , :);
% this is common to all classes and groups and now allows you to just loop
% over class files and subset as needed for each group according to manual
% list.

all_meta.mano_anno = strrep(all_meta.mano_anno, ' ', '_');
% modify mano's to include TAG's from keepTAGs:
for i = 1:length(keepTAGs)
    kt = keepTAGs{i};
    cc = strsplit(kt, '_TAG_');
    primnam = cc{1};

    tmp_tagtab = tag_roi_table(ismember(tag_roi_table.mano_anno, kt) , :);

    matcher = cat(2, tmp_tagtab(:, ["file", "roi"]), ...
        array2table(repmat({primnam}, size(tmp_tagtab, 1), 1), "VariableNames", "mano_anno"));
    all_meta.mano_anno(ismember(all_meta(: , ["file", "roi", "mano_anno"]), matcher, 'rows')) = {kt};
end

for i = 1:length(groups)
    gg = groups{i};
    cxg = classXgroup{i};
    % modify classes in this group to match class_labels:
    cxg_match = strrep(cxg, ' ', '_');
    cxg_match = strrep(cxg_match, 'TAG', '_TAG_');

    % subset where this group is manually annotated:
    grp_manlist = manual_list(manual_list.(gg) == 1, :);

    % get your file names to pull score data for:
    ALLFILES = cellfun(@file2path, grp_manlist.file, repmat({cnn_result_path},...
        length(grp_manlist.file), 1), "UniformOutput",false);

    % subset roict table and all_meta to match these files in grp manlist:
    roict_table = all_roict_table(ismember(all_roict_table.file, grp_manlist.file) , :); % this is ready now...
    all_meta_group = all_meta(ismember(all_meta.file, grp_manlist.file) , :);

    % loop over all files to get cnn scores:
    for j = 1:length(ALLFILES)

        tmp_meta = all_meta_group;
        tmp_meta = tmp_meta(ismember(tmp_meta.mano_anno, cxg_match), :);

        ff = [ALLFILES{j}, '_class.h5'];
        % read in the score data:
        raw = load_class_scores(ff); % Heidi's fcn
        sco = raw.scores; % CNN scores
        rois = raw.roi_numbers; % roi numbers
    
        % cnn score table:
        sco_tab = array2table(sco, "VariableNames", raw.class_labels);
        sco_tab.roi = rois;
        sco_tab.file = repmat(grp_manlist.file(j), length(rois), 1);
            
        % get rois CNN classified to this group:
        [~, topclassidx] = max(sco, [], 2); % CNN top class indices for this bin
        clsidx = find(ismember(raw.class_labels, cxg_match)); % class indices
        prois = sco_tab(ismember(topclassidx, clsidx), :); % rois CNN called your classes

        % get rois manually classified to this group:
        manrois = sco_tab(ismember(sco_tab(:, ["file", "roi"]), tmp_meta(:, ["file", "roi"]), "rows") , :);

        % combine manual and CNN rois:
        addrois = unique(cat(1, prois, manrois), "rows");

        % right join ditches rows in left table that aren't in right...
        tmp_meta = outerjoin(tmp_meta, addrois, "Keys", ["file", "roi"], ...
            "MergeKeys", true, "Type", "right");

        % add these to the big table"
        if j == 1
            all_score_tab = tmp_meta;
        else
            all_score_tab = cat(1, all_score_tab, tmp_meta);
        end
    
        disp(['file ', num2str(j), ' of ', num2str(length(ALLFILES)), ' be done']);
    
    end

    % now polish all_score_tab by:
    % populate any missing annotations with a 'not_annotated' 
    all_score_tab.mano_anno(cellfun(@isempty, all_score_tab.mano_anno)) = {'not_annotated'};

    % some simple QC - remove bleach-damaged:
    all_score_tab = all_score_tab(~ismember(all_score_tab.file, bleached_binid),:);            
    roict_table = roict_table(~ismember(roict_table.file, bleached_binid),:);

    % remove where meta data skip == 1:
    all_score_tab = all_score_tab(~ismember(all_score_tab.file, skipme),:);            
    roict_table = roict_table(~ismember(roict_table.file, skipme),:);

    tmpdir = [out_path, gg];
    if ~exist(tmpdir, 'dir')
        mkdir(tmpdir)
    end
    save([tmpdir, '\', gg, '_CNN_score_data_', ymd_str, '.mat'], ...
        'all_score_tab', 'roict_table', '-v7.3');

    % loop over the classes and pop each out to save
    group_score_tab = all_score_tab; % this one lets you subset by class while preserving other classes
    for j = 1:length(cxg_match)
        cc = cxg_match{j};

        scores = group_score_tab(:, ...
            ~ismember(group_score_tab.Properties.VariableNames, all_meta.Properties.VariableNames));
        [~, topclassidx] = max(table2array(scores), [], 2); % CNN top class indices for this bin
        clsidx = find(ismember(scores.Properties.VariableNames, cc)); % class indices
        prois = group_score_tab(ismember(topclassidx, clsidx), ["file", "roi"]); % rois CNN called your classes

        all_score_tab = group_score_tab(ismember(group_score_tab.mano_anno, cc) | ...
            ismember(group_score_tab(:, ["file", "roi"]), prois, "rows") , :);

        tmpdir = [out_path, cc];
        if ~exist(tmpdir, 'dir')
            mkdir(tmpdir)
        end

        if ~isempty(all_score_tab)
            save([tmpdir, '\', cc, '_CNN_score_data_', ymd_str, '.mat'], ...
                'all_score_tab', 'roict_table', '-v7.3');
        end
    end

    disp(['group ', num2str(i), ' of ', num2str(length(groups)), ' be done']);

end

end


%% helper functions:
function [out] = zero_pad_string(in)
    if length(in) < 5
        out = [repmat('0',1,5-length(in)) , in];
    else
        out = in;
    end
end

function [newf] = file2path(oldf, cnn_result_path)
    if contains(oldf, 'D')
        
        sub1 = oldf(1:5); %DYYYY is sub1 
        tmp = strsplit(oldf, 'T');

        sub2 = tmp{1}; % DYYYYMMDD is sub2
        newf = [cnn_result_path, '\', sub1, '\', sub2, '\', oldf];
    else
        tmp = strsplit(oldf, '_');
        sub1 = ['D' tmp{2}];
        sub2 = [sub1, '_', tmp{3}];
        newf = [cnn_result_path, '\', sub1, '\', sub2, '\', oldf];
    end
end

function [file, roi] = split_roi_id(roiid)

    tmp = convertStringsToChars(roiid);
    idx = max(strfind(tmp, '_'));

    manrois = convertStringsToChars(extractAfter(tmp, idx));
    roi = str2num(manrois);

    file = convertStringsToChars(extractBefore(tmp, idx));

end