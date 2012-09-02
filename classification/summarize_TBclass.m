function [classcount, classcount_above_optthresh, classcount_above_adhocthresh] = summarize_TBclassMVCO(classfile, adhocthresh)
% function [class2useTB, classcount, classcount_above_optthresh, classcount_above_adhocthresh] = summarize_TBclassMVCO(classfile)
% read treebagger classifier result file and summarize number of targets in each class
% classcount = result for case considering each target placed in winning class
% classcount_above_optthresh = result for case considering only classifications that
% are above the threshold for maximum accuracy for each class (some targets
% will have no class)
% classcount_above_adhocthresh = result for counts above specified decision
% threshold (optional output depending on whether adhocthresh vectror is passed in)
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2012

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
    end;
end;

end

