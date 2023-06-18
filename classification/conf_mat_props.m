function [ TP TN FP FN ] = conf_mat_props( c )
%function [ TP TN FP FN ] = conf_mat_props( c )
%IFCB classifier analysis: return number of true positive (TP), true
%negative (TN), false positive (FP), and false negative (FN) instances in
%an input confusion matrix (c), with convention as produced by confusionmat
%Heidi M. Sosik, Woods Hole Oceanographic Institution, Jan 2016

total = sum(c)'; %total actually in class
TP = diag(c);
FP = sum(c)' - TP;
FN = sum(c,2)-TP;
%sum(total)-TP = classified as not in class
TN = sum(total)-TP-FN-FP;

end