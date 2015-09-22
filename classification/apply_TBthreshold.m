function [ class_out ] = apply_TBthreshold( class2use, scores, thre )
%function [ class_out ] = apply_TBthreshold( scores, thre )
%
%IFCB random forest classifier interpretation, returns class identification
%considering a threshold score for a positive identification; cases below
%threshold score returned as 'unclassified'
%
%Heidi M. Sosik, Woods Hole Oceanographic Institution

if length(thre) == 1, thre = thre*ones(1,length(class2use)-1); end;
thre = thre(:)';
    
num = size(scores,1); %number of unknowns
t = repmat(thre,num,1);
win = (scores > t); %find scores above thre
[i,j] = find(win);
class_out = deal(repmat({'unclassified'},1,num)); %default to unclassified
%assign wins above thre
class_out(i) = class2use(j); %most are correct his way (zero or one case above threshold)
ind = find(sum(win')>1); %now go back and fix the conflicts with more than one above threshold
for count = 1:length(ind),
    %ii = find(win(ind(count),:));
    [~,ii] = max(scores(ind(count),:));
    class_out(ind(count)) = class2use(ii);
end;

end

