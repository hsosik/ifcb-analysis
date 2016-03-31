function [ feature_mat, featitles ] = format_features( bin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

s_temp = bin.features;
Rings = [s_temp.Rings];
Wedges = [s_temp.Wedges];
HOG = [s_temp.HOG];
s_temp = rmfield(s_temp, {'Rings' 'Wedges' 'HOG'});
%n = [s_temp.numBlobs];
n = zeros(1,length(s_temp));
for i = 1:length(s_temp),
    n(i) = size(s_temp(i).Area,2);
end;
%assumes first is the largest (as sorted in blob_geomprop)
largest_ind = [1 cumsum(n(1:end-1))+1];

fields = sort(fieldnames(s_temp));
for i = 1:length(fields),
    field = char(fields(i));
    list = [s_temp.(field)];
    if length(list) > length(n),
        s_largest.(field) = list(largest_ind);
    else
        s_largest.(field) = list;
    end;
end;

output_largest.features = s_largest;
temp = struct2cell(s_largest);    
feature_mat = [cell2mat(temp); Wedges; Rings; HOG];
feature_mat(isnan(feature_mat)) = 0;
  
featitles = fieldnames(output_largest.features);
nring = size(Rings,1); nwedge = size(Wedges,1); nhog = size(HOG,1);
featitles = [featitles; cellstr([repmat('Wedge',nwedge,1) num2str((1:nwedge)','%02d')]); cellstr([repmat('Ring',nring,1) num2str((1:nring)','%02d')]); cellstr([repmat('HOG',nhog,1) num2str((1:nhog)','%02d')])];

end

