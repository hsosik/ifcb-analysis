function [classcount, classbiovol, class2useTB] = summarize_TBclassMVCO(classfile, biovolfile)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

load(classfile)
classcount = NaN(length(class2useTB),1);
classcount_above_optthresh = classcount;
classcount_above_adhocthresh = classcount;
load(biovolfile)

for ii = 1: length(class2useTB),
    ind = strmatch(class2useTB(ii), TBclass,'exact');
    classcount(ii) = size(ind,1);
    classbiovol(ii) = sum(targets.Biovolume(ind));
end;
end

