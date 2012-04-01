function [ ind_out, class_label ] = get_phyto_ind( class2use, class_label )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[ ind_out, class_label ] = get_nonphyto_ind( class2use, class_label );
ind_out = setdiff(1:length(class2use), ind_out);

end

