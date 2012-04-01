function [ ind_out, class_label ] = get_ciliate_ind( class2use, class_label )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

class2get = {'ciliate' 'ciliate_mix' 'tintinnid' 'Myrionecta' 'Laboea'};

[~,ind_out] = intersect(class2use, class2get);

end

