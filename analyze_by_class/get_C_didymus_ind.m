function [ ind_out, class_label ] = get_C_didymus_ind( class2use, class_label )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

class2get = {'Chaetoceros_didymus' 'Chaetoceros_didymus_flagellate'};

[~,ind_out] = intersect(class2use, class2get);
ind_out = sort(ind_out);

end

