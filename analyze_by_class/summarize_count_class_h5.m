function [classcount, classcount_above_adhocthresh, pid_list, score_list, class_labels] = summarize_count_class_h5(classfile, adhocthresh)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%load(classfile)
[bin_id, scores, roi_numbers, class_labels] = load_class_scores(classfile);

classcount = NaN(length(class_labels),1);
classcount_above_adhocthresh = classcount;

%% get the class labels with application of adhocthresh
if length(adhocthresh) == 1
    t = ones(size(scores))*adhocthresh;
else
    t = repmat(adhocthresh,length(class_labels),1);
end
win = (scores > t);
[i,j] = find(win);
if ~exist('TBclass', 'var')
    [~,class] = max(scores');
    class = class_labels(class)';
end
class_above_adhocthresh = cell(size(class));
class_above_adhocthresh = cell(size(class));
class_above_adhocthresh(:) = deal(repmat({'unclassified'},1,length(class)));
class_above_adhocthresh(i) = class_labels(j); %most are correct his way (zero or one case above threshold)
ind = find(sum(win')>1); %now go back and fix the conflicts with more than one above threshold
for count = 1:length(ind)
    [~,ii] = max(scores(ind(count),:));
    class_above_adhocthresh(ind(count)) = class_labels(ii);
end
%%

for ii = 1:length(class_labels)
    ind = strmatch(class_labels(ii), class,'exact');
    classcount(ii) = size(ind,1);
    if numel(ind) > 0
        pid_list{ii} = strcat(char(bin_id),'_', num2str(roi_numbers(ind), '%05.0f'));
    end
    score_list{ii} = scores(ind,ii);
    ind = strmatch(class_labels(ii), class_above_adhocthresh, 'exact');
    classcount_above_adhocthresh(ii) = size(ind,1);
end
end

