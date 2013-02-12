function [ ] = apply_TBclassifierMVCO(feafile, feaorder, classifierName ) % TBclassifier, TBmaxthre);
%function [roinum, class, scores, class_above_threshold] = apply_TBclassifierMVCO(feafile, feaorder ) % TBclassifier, TBmaxthre);
%function [roi_num, class, scores, above_threshold] = apply_TBclassifierMVCO(feafiles{filecount}, feaorder, b, maxthre);
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

persistent TBclassifier TBmaxthre class2useTB

if isempty(TBclassifier),
    disp('loading classifier...')
    load(classifierName)
    class2useTB = b.ClassNames;
    TBclassifier = b; TBmaxthre = maxthre;
    class2useTB = [class2useTB; 'unclassified'];
end;

features = textread(feafile, '', 'delimiter', ',', 'headerlines', 1);
roinum = features(:,1);
features = features(:,feaorder);
[ TBclass, TBscores] = predict(TBclassifier, features);

t = repmat(TBmaxthre,length(TBclass),1);
win = (TBscores > t);
[i,j] = find(win);
TBclass_above_threshold = cell(size(TBclass));
TBclass_above_threshold(:) = deal(repmat({'unclassified'},1,length(TBclass)));
TBclass_above_threshold(i) = TBclassifier.ClassNames(j); %most are correct his way (zero or one case above threshold)
ind = find(sum(win')>1); %now go back and fix the conflicts with more than one above threshold
for count = 1:length(ind),
    %ii = find(win(ind(count),:));
    [~,ii] = max(TBscores(ind(count),:));
    TBclass_above_threshold(ind(count)) = TBclassifier.ClassNames(ii);
end;
outfile = regexprep(feafile, 'features', 'class');
outfile = regexprep(outfile, 'fea', 'class');
outfile = regexprep(outfile, '.csv', '');
outfile = regexprep(outfile, 'v2', 'v1'); %TEMPORARY work around for v2 features, still v1 class files
save(outfile, 'class2useTB', 'TBclass', 'roinum', 'TBscores', 'TBclass_above_threshold', 'classifierName')

end

