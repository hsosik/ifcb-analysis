function  [groupcount, groupbiovol, groupC, groupcount_above_optthresh, groupbiovol_above_optthresh, groupC_above_optthresh, groupcount_above_adhocthresh, groupbiovol_above_adhocthresh, groupC_above_adhocthresh, all_group_labels, groupFeaList, groupPidList] = summarize_biovol_classGroup_h5_hierarchy(classfile, feafile, adhocthresh, optthresh, pidlist_flag, groupXclass, groupXgroup)
%UNTITLED modified summarize_biovol_classGroup_h5.m to create same products
% for groups of IFCB classes using sum of CNN scores as a classification 
% guide with a hierarchical grouping scheme.
%   Same inputs except addition of groupXgroup, a table 
%   that denotes which groups to consider as "primary groups" (column
%   variable names) and the subgroups placed in each of those groups 
%   (logical along rows). For example, protist could be a primary group
%   that includes diatoms, dino's, ciliates, and nanoplankton.

% D. Catlett Apr. 2023 

persistent class2use
%micron_factor = 1/3.4; %microns per pixel
micron_factor = 1/2.77; %microns per pixel

%load(classfile)
%[bin_id, scores, roi_numbers, class_labels] = load_class_scores(classfile);
classTable = load_class_scores(classfile);

groupcount = nan(length(setdiff(groupXclass.Properties.VariableNames, {'CNN_classlist'})),1);
groupcount_above_optthresh = groupcount;
groupcount_above_adhocthresh = groupcount;
groupbiovol = groupcount;
groupbiovol_above_optthresh = groupcount;
groupbiovol_above_adhocthresh = groupcount;
groupC = groupcount;
groupC_above_optthresh = groupcount;
groupC_above_adhocthresh = groupcount;
feastruct = importdata(feafile);
%ind = strmatch('Biovolume', feastruct.colheaders);
ind = strmatch('summedBiovolume', feastruct.textdata);
targets.Biovolume = feastruct.data(:,ind)*micron_factor.^3;
%targets.esd = (targets.Biovolume*3/4/pi).^(1/3)*2; 
targets.esd = biovol2esd(targets.Biovolume);
ind = strmatch('summedSurfaceArea', feastruct.textdata);
targets.SurfaceArea = feastruct.data(:,ind)*micron_factor.^2;
ind = strmatch('maxFeretDiameter', feastruct.textdata);
targets.maxFeretDiameter = feastruct.data(:,ind)*micron_factor;
ind = strmatch('summedMajorAxisLength', feastruct.textdata);
targets.summedMajorAxisLength = feastruct.data(:,ind)*micron_factor;
ind = strmatch('RepresentativeWidth', feastruct.textdata);
targets.RepresentativeWidth = feastruct.data(:,ind)*micron_factor;
ind = strmatch('summedArea', feastruct.textdata);
targets.summedArea = feastruct.data(:,ind)*micron_factor.^2;
ind = strmatch('numBlobs', feastruct.textdata);
targets.numBlobs = feastruct.data(:,ind);
targets.roi_numbers = feastruct.data(:,1);
targets.pid = cellstr(strcat(classTable.metadata.bin_id, '_', num2str(feastruct.data(:,1), '%05.0f')));

%%
adcfile = regexprep(feafile, '_fea_v4.csv', '.adc');
adcfile = regexprep(adcfile, 'IFCB_products', 'IFCB_data');
adcfile = regexprep(adcfile, 'IFCB_products', 'IFCB_data');
adcfile = regexprep(adcfile, 'features\\D', 'data\');
adcfile = regexprep(adcfile, 'features_v4\\D', 'data\'); %MVCO case

%add opts to address adc files with only 1 row of data
opts = delimitedTextImportOptions("NumVariables", 24);
opts.VariableTypes = repmat("double", 1,24); %["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
adc = readtable(adcfile, opts);
%adc = readtable(adcfile, 'FileType', 'text');
targets.adc = adc{feastruct.data(:,1), 3:11};

%make sure the roi_numbers match
[~,ia,ib] = intersect(feastruct.data(:,1), classTable.roi_numbers);
classTable.scores_feamatch(ia,:) = classTable.scores(ib,:);

%% primary group classification
scomat = array2table(classTable.scores_feamatch, "VariableNames", classTable.class_labels);

% grouperize score tables:
scomat_group_prim = grouperize_cnn_score_table(scomat, 'sum', groupXclass(:, cat(2, 'CNN_classlist', groupXgroup.Properties.VariableNames)));
group_labels_prim = scomat_group_prim.Properties.VariableNames;
scomat_group_prim = table2array(scomat_group_prim);
optthresh_prim = table2array(optthresh(:, group_labels_prim));
groupXgroup = groupXgroup(: , group_labels_prim); % just in case

%% primary groups with application of adhocthresh
if length(adhocthresh) == 1
    t = ones(size(scomat_group_prim))*adhocthresh;
else
    t = repmat(adhocthresh,length(Predicted_class),1);
end
win = (scomat_group_prim > t);
[i,j] = find(win);
[targets.maxscore_prim, Predicted_class] = max(scomat_group_prim');
Predicted_class((targets.maxscore_prim==0)) = NaN;
Predicted_class_above_adhocthresh = zeros(size(Predicted_class));
Predicted_class_above_adhocthresh(i) = j; %most are correct his way (zero or one case above threshold)

ind = find(sum(win')>1); %now go back and fix the conflicts with more than one above threshold
for count = 1:length(ind)
    [~,ii] = max(scomat_group_prim(ind(count),:));
    Predicted_class_above_adhocthresh(ind(count)) = ii;
end

Predicted_class_above_adhocthresh(isnan(Predicted_class)) = NaN; %these are the no ROI triggers

%% and primary groups with application of optthresh:
[~, topclassidx] = max(scomat_group_prim, [], 2); % col index of top class in scomat
topclassidx_lin = sub2ind(size(scomat_group_prim), (1:size(scomat_group_prim,1)).', topclassidx);
topclasssco = scomat_group_prim(topclassidx_lin);

% here's the top-scoring class with score > optthresh(1):
tmp = optthresh_prim(topclassidx)'; % this creates a vector of opt thresh X roi 
% where opt thresh is for the top-scoring class of each roi.
keepers = topclasssco > tmp; % =1 where the top-scoring class exceeded it's opt thresh
Predicted_class_above_optthresh = zeros(1, length(keepers));
Predicted_class_above_optthresh(keepers) = topclassidx(keepers); 

% Predicted_class_above_optthresh is a 1 x roi vector of the column index of 
% the "winning class". 0 indicates no winning class.
Predicted_class_above_optthresh(isnan(Predicted_class)) = NaN; %these are the no ROI triggers

% make an all_group_labels to combine primary and secondary:
all_group_labels = group_labels_prim;
for i = 1:size(groupXgroup, 2)
    tmp = table2array(groupXgroup(:,i));
    if iscell(tmp)
        all_group_labels = cat(2, all_group_labels, tmp);
    end
end

%% secondary classifications:
counter = length(group_labels_prim);
for i = 1:size(groupXgroup, 2)

    prim_group_tracker(i) = i; % tracking for easy data-wrangling later

    % get 2ndary group score matrix:
    group_labels_sec = groupXgroup.(group_labels_prim{i});
    if iscell(group_labels_sec)
        bob = counter+1:counter+length(group_labels_sec);
        prim_group_tracker(bob) = repmat(i, 1, length(bob)); % tracking for easy data-wrangling later

        % do secondary classifications:
        scomat_group_sec = grouperize_cnn_score_table(scomat, 'sum', groupXclass(:, cat(2, 'CNN_classlist', group_labels_sec)));
        group_labels_sec = scomat_group_sec.Properties.VariableNames;
        scomat_group_sec = table2array(scomat_group_sec);
        optthresh_sec = table2array(optthresh(:, group_labels_sec));

        % do classifications:
        [targets.maxscore_sec(i,:), topclassidx] = max(scomat_group_sec, [], 2); % col index of top class in scomat
        topclassidx_lin = sub2ind(size(scomat_group_sec), (1:size(scomat_group_sec,1)).', topclassidx);
        topclasssco = scomat_group_sec(topclassidx_lin);
        tmp_class = topclassidx';
        
        % here's the top-scoring class with score > optthresh:
        tmp = optthresh_sec(topclassidx)'; % this creates a vector of opt thresh X roi 
        % where opt thresh is for the top-scoring class of each roi.
        keepers = topclasssco > tmp; % =1 where the top-scoring class exceeded it's opt thresh
        tmp_class_above_optthresh = zeros(1, length(keepers));
        tmp_class_above_optthresh(keepers) = topclassidx(keepers); 

        % adhoc:
        keepers2 = topclasssco > adhocthresh;
        tmp_class_above_adhocthresh = zeros(1, length(keepers2));
        tmp_class_above_adhocthresh(keepers2) = topclassidx(keepers2); 
        
        % Predicted_class_above_optthresh is a 1 x roi vector of the column index of 
        % the "winning class". 0 indicates no winning class.
        tmp_class_above_adhocthresh(isnan(Predicted_class)) = NaN; %these are the no ROI triggers
        tmp_class(isnan(Predicted_class)) = NaN; %these are the no ROI triggers
        tmp_class_above_optthresh(isnan(Predicted_class)) = NaN; %these are the no ROI triggers
        % ^that has the secondary group classifications as numbers.
        % need to incorporate primary classifications from 
        % Predicted_class_above_optthresh to block out non-primaries

        % this approach means protists MUST be classified to one of the
        % sub-groups to be counted:
%         idx = tmp_class_above_optthresh > 0 & ~isnan(tmp_class_above_optthresh);
%         tmp_class_above_optthresh(idx) = tmp_class_above_optthresh(idx) + counter;
%         Predicted_class_above_optthresh(Predicted_class_above_optthresh == i) = ...
%             tmp_class_above_optthresh(Predicted_class_above_optthresh == i);

        % this approach allows some roi's to be counted as protists even if
        % they're not counted as a subgroup:
        idx = tmp_class_above_optthresh > 0 & ~isnan(tmp_class_above_optthresh);
        tmp_class_above_optthresh(idx) = tmp_class_above_optthresh(idx) + counter;

        idx = Predicted_class_above_optthresh == i & tmp_class_above_optthresh > 0;
        Predicted_class_above_optthresh(idx) = tmp_class_above_optthresh(idx);

        % repeat for adhoc:
        idx = tmp_class_above_adhocthresh > 0 & ~isnan(tmp_class_above_adhocthresh);
        tmp_class_above_adhocthresh(idx) = tmp_class_above_adhocthresh(idx) + counter;

        idx = Predicted_class_above_adhocthresh == i & tmp_class_above_adhocthresh > 0;
        Predicted_class_above_adhocthresh(idx) = tmp_class_above_adhocthresh(idx);

        % and no thresh:
        idx = tmp_class > 0 & ~isnan(tmp_class);
        tmp_class(idx) = tmp_class(idx) + counter;

        idx = Predicted_class == i & tmp_class > 0;
        Predicted_class(idx) = tmp_class(idx);

        % add to counter:
        counter = counter + length(group_labels_sec);
    else
        % do nothing.. no subgroups.
        % do nan out the secondary max score field though
        targets.maxscore_sec(i,:) = nan(1, size(scomat,1));
    end

end



%% biovolume and biomass calculations:

%[ind_diatom] = get_diatom_ind(class_labels,class_labels);
diatom_flag = zeros(size(all_group_labels));
diatom_flag(contains(all_group_labels, 'Diatom')) = 1;
cellC_diatom = biovol2carbon(targets.Biovolume,1);
cellC_notdiatom = biovol2carbon(targets.Biovolume,0);
all_optthresh = [optthresh_prim, optthresh_sec];
for ii = 1:length(all_group_labels)
    if diatom_flag(ii)
        cellC = cellC_diatom;
    else
        cellC = cellC_notdiatom;
    end
    %ind = strmatch(class_labels(ii), Predicted_class,'exact');
    ind = find(Predicted_class == ii);
    groupcount(ii) = length(ind);
    groupbiovol(ii) = sum(targets.Biovolume(ind));
    groupC(ii) = sum(cellC(ind));
    if ~isempty(ind)
        groupFeaList{ii} = [targets.esd(ind) targets.maxFeretDiameter(ind) targets.summedMajorAxisLength(ind) targets.RepresentativeWidth(ind) targets.summedArea(ind) targets.SurfaceArea(ind) targets.Biovolume(ind) cellC(ind) targets.numBlobs(ind) targets.adc(ind,:) targets.roi_numbers(ind) targets.maxscore_prim(ind)' targets.maxscore_sec(prim_group_tracker(ii), ind)'];
    else
        groupFeaList{ii} = single.empty(0,size(targets.adc,2)+12); % 12 used to be 11
    end
    if pidlist_flag
        groupPidList{ii} = targets.pid(ind);
    end
    if exist('Predicted_class_above_optthresh', 'var') && ~isnan(all_optthresh(ii))
        %ind = strmatch(class_labels(ii), Predicted_class_above_threshold, 'exact');
        ind = find(Predicted_class_above_optthresh==ii);
        groupcount_above_optthresh(ii) = length(ind);
        groupbiovol_above_optthresh(ii) = sum(targets.Biovolume(ind));
        groupC_above_optthresh(ii) = sum(cellC(ind));
    else 
        groupcount_above_optthresh(ii) = NaN;
        groupbiovol_above_optthresh(ii) = NaN; 
        groupC_above_optthresh(ii) = NaN; 
    end
    %ind = strmatch(class_labels(ii), Predicted_class_above_adhocthresh, 'exact');
    ind = find(Predicted_class_above_adhocthresh==ii);
    groupcount_above_adhocthresh(ii) = length(ind);
    groupbiovol_above_adhocthresh(ii) = sum(targets.Biovolume(ind));
    groupC_above_adhocthresh(ii) = sum(cellC(ind));
end

% now loop back over groupXgroup to add secondary groups to primary:
for i = 1:size(groupXgroup, 2)

    gp = group_labels_prim(i); % for finding index of primary group
    gs = groupXgroup.(group_labels_prim{i});
    if iscell(gs)
        gg = cat(2, gp, gs); % indices to sum over

        % do the sums:
        groupcount_above_optthresh(ismember(all_group_labels, gp)) = ...
            sum(groupcount_above_optthresh(ismember(all_group_labels, gg)));
        groupbiovol_above_optthresh(ismember(all_group_labels, gp)) = ...
            sum(groupbiovol_above_optthresh(ismember(all_group_labels, gg)));
        groupC_above_optthresh(ismember(all_group_labels, gp)) = ...
            sum(groupC_above_optthresh(ismember(all_group_labels, gg)));

        groupcount(ismember(all_group_labels, gp)) = ...
            sum(groupcount(ismember(all_group_labels, gg)));
        groupbiovol(ismember(all_group_labels, gp)) = ...
            sum(groupbiovol(ismember(all_group_labels, gg)));
        groupC(ismember(all_group_labels, gp)) = ...
            sum(groupC(ismember(all_group_labels, gg)));

        groupcount_above_adhocthresh(ismember(all_group_labels, gp)) = ...
            sum(groupcount_above_adhocthresh(ismember(all_group_labels, gg)));
        groupbiovol_above_adhocthresh(ismember(all_group_labels, gp)) = ...
            sum(groupbiovol_above_adhocthresh(ismember(all_group_labels, gg)));
        groupC_above_adhocthresh(ismember(all_group_labels, gp)) = ...
            sum(groupC_above_adhocthresh(ismember(all_group_labels, gg)));

        % feature list too:
        catme = groupFeaList(ismember(all_group_labels, gg));
        groupFeaList{i} = cat(1, catme{:});
    else
    end

end

if ~pidlist_flag
    groupPidList = NaN;
end
end