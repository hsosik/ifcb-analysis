function [classcount, classbiovol, classC, classcount_above_optthresh, classbiovol_above_optthresh, classC_above_optthresh, classcount_above_adhocthresh, classbiovol_above_adhocthresh, classC_above_adhocthresh, class_labels] = summarize_biovol_classMVCO_h5(classfile, feafile, adhocthresh)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%micron_factor = 1/3.4; %microns per pixel
micron_factor = 1/2.77; %microns per pixel

%load(classfile)
[bin_id, scores, roi_numbers, class_labels] = load_class_scores(classfile);

classcount = NaN(length(class_labels),1);
classcount_above_optthresh = classcount;
classcount_above_adhocthresh = classcount;
classbiovol = classcount;
classbiovol_above_optthresh = classcount;
classbiovol_above_adhocthresh = classcount;
classC = classcount;
classC_above_optthresh = classcount;
classC_above_adhocthresh = classcount;
feastruct = importdata(feafile);
%ind = strmatch('Biovolume', feastruct.colheaders);
ind = strmatch('Biovolume', feastruct.textdata);
targets.Biovolume = feastruct.data(:,ind)*micron_factor.^3;

%% get the TBclass labels with application of adhocthresh
if length(adhocthresh) == 1
    t = ones(size(scores))*adhocthresh;
else
    t = repmat(adhocthresh,length(TBclass),1);
end
win = (scores > t);
[i,j] = find(win);
if ~exist('TBclass', 'var')
    [~,TBclass] = max(scores');
    TBclass = class_labels(TBclass)';
end
TBclass_above_adhocthresh = cell(size(TBclass));
TBclass_above_adhocthresh = cell(size(TBclass));
TBclass_above_adhocthresh(:) = deal(repmat({'unclassified'},1,length(TBclass)));
TBclass_above_adhocthresh(i) = class_labels(j); %most are correct his way (zero or one case above threshold)
ind = find(sum(win')>1); %now go back and fix the conflicts with more than one above threshold
for count = 1:length(ind)
    [~,ii] = max(scores(ind(count),:));
    TBclass_above_adhocthresh(ind(count)) = class_labels(ii);
end
%%

[ind_diatom] = get_diatom_ind(class_labels,class_labels);
diatom_flag = zeros(size(class_labels));
diatom_flag(ind_diatom) = 1;
cellC_diatom = biovol2carbon(targets.Biovolume,1);
cellC_notdiatom = biovol2carbon(targets.Biovolume,0);
for ii = 1:length(class_labels)
    if diatom_flag(ii)
        cellC = cellC_diatom;
    else
        cellC = cellC_notdiatom;
    end
    ind = strmatch(class_labels(ii), TBclass,'exact');
    classcount(ii) = size(ind,1);
    classbiovol(ii) = sum(targets.Biovolume(ind));
    classC(ii) = sum(cellC(ind));
    if exist('TBclass_above_threshold', 'var')
        ind = strmatch(class_labels(ii), TBclass_above_threshold, 'exact');
        classcount_above_optthresh(ii) = size(ind,1);
        classbiovol_above_optthresh(ii) = sum(targets.Biovolume(ind));
        classC_above_optthresh(ii) = sum(cellC(ind));
    else 
        TBclass_above_threshold = NaN;
    end
    ind = strmatch(class_labels(ii), TBclass_above_adhocthresh, 'exact');
    classcount_above_adhocthresh(ii) = size(ind,1);
    classbiovol_above_adhocthresh(ii) = sum(targets.Biovolume(ind));
    classC_above_adhocthresh(ii) = sum(cellC(ind));
end
end

