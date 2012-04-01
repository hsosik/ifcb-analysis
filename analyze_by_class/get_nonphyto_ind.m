function [ ind_out, class_label ] = get_nonphyto_ind( class2use, class_label )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

class2get = {'Thalassiosira_dirty' 'bad' 'ciliate' 'detritus' 'not_ciliate' 'ciliate_mix' 'tintinnid' 'Myrionecta' 'Laboea'};

[~,ind_out] = intersect(class2use, class2get);
ind_out = sort(ind_out);

end

