function [manual_classcount, class2use_here] = summarize_manualMVCO(manualfile);
%function [manual_classcount(filecount,:), class2use_manual] = summarize_manualMVCO(filelist_manual{filecount});
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

load(manualfile)
if exist('class2use_sub4', 'var')
    class2use_here = [class2use_manual class2use_sub4];
    numclass2 = length(class2use_sub4);
else
    class2use_here = class2use_manual;
    numclass2 = 0;
end;
numclass1 = length(class2use_manual);
numclass = numclass1 + numclass2;
%manual_classcount = NaN(length(class2use_here),1);
for ii = 1: length(class2use_here),
    temp = zeros(1,numclass); %init as zeros for case of subdivide checked but none found, classcount will only be zero if in class_cat, else NaN
    for classnum = 1:numclass1,
        temp(classnum) = size(find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum)),1);
    end;
    for classnum = 1:numclass2,
        temp(classnum+numclass1) = size(find(classlist(:,4) == classnum),1);
    end;
end;
manual_classcount = temp;

end

