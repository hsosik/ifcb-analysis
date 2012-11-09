function [classcount, classcount_above_optthresh, classcount_above_adhocthresh, class2useTB, roiid_list, p_list] = summarize_TBclassMVCO(classfile, adhocthresh, class2list)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

load(classfile)
classcount = NaN(length(class2useTB),1);
classcount_above_optthresh = classcount;
classcount_above_adhocthresh = classcount;

if exist('adhocthresh', 'var'),
    classcount_above_adhocthresh = classcount;
    [maxscore, winclass] = max(TBscores');
    if length(adhocthresh) == 1, adhocthresh = adhocthresh*ones(size(class2useTB)); end;
end;
classcount_weighted = [sum(TBscores,1)'; NaN];
for ii = 1: length(class2useTB),
    classcount(ii) = size(strmatch(class2useTB(ii), TBclass,'exact'),1);
    classcount_above_optthresh(ii) = size(strmatch(class2useTB(ii), TBclass_above_threshold),1);
    if exist('adhocthresh', 'var')
        ind = (strcmp(class2useTB(ii), TBclass) & maxscore' >= adhocthresh(ii));
        classcount_above_adhocthresh(ii) = sum(ind);
        if ii == class2list, 
            temp = find(ind);
            roiid_list = roinum(temp);
            p_list = maxscore(temp);
        end;
    end;
end;

end

