function [ ind_out, class_label ] = get_ditylum_ind( class2use, class_label )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

class2get = {'Ditylum' 'Ditylum_parasite'};

[~,ind_out] = intersect(class2use, class2get);
ind_out = sort(ind_out);

end