function [ ind_out, class_label ] = get_G_delicatula_ind( class2use, class_label )
%function [ ind_out, class_label ] = get_G_delicatula_ind( class2use, class_label )
% MVCO class list specific to return of indices that correspond to all variants of Guinardia delicatula
%  Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013

class2get = {'Guinardia_delicatula' 'G_delicatula_parasite' 'G_delicatula_external_parasite'};

[~,ind_out] = intersect(class2use, class2get);
ind_out = sort(ind_out);

end

