function [ classcount_above_thre, class2useTB, roiid_list, p_list] = summarize_TBclassMVCO_threshlist(classfile, threlist, class2do)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

load(classfile)
classcount_above_thre = NaN(1,length(threlist));

%if exist('adhocthresh', 'var'),
%    classcount_above_adhocthresh = classcount;
[maxscore, winclass] = max(TBscores');
%    if length(adhocthresh) == 1, adhocthres`h = adhocthresh*ones(size(class2useTB)); end;
%end;

%for ii = 1: length(class2useTB),
%    classcount(ii) = size(strmatch(class2useTB(ii), TBclass,'exact'),1);
%    classcount_above_optthresh(ii) = size(strmatch(class2useTB(ii), TBclass_above_threshold),1);
%    if exist('adhocthresh', 'var')
for ii = 1:length(threlist),
    adhocthresh = threlist(ii);
    ind = (strcmp(class2useTB(class2do), TBclass) & maxscore' >= adhocthresh);
    classcount_above_thre(ii) = sum(ind);
    %if ii == class2list,
    temp = find(ind);
    roiid_list = roinum(temp);
    p_list = maxscore(temp);
    %end;
    % end;
end;

end

