function [classcount, classcount_above_thresh, class2useTB] = summarize_TBclassMVCO(classfile)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

load(classfile)
classcount = NaN(length(class2useTB),1);
classcount_above_thresh = classcount;
for ii = 1: length(class2useTB),
    classcount(ii) = size(strmatch(class2useTB(ii), TBclass),1);
    classcount_above_thresh(ii) = size(strmatch(class2useTB(ii), TBclass_above_threshold),1);
end;

end

