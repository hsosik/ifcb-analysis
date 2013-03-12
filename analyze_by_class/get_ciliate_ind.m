function [ ind_out, class_label ] = get_ciliate_ind( class2use, class_label )
%function [ ind_out, class_label ] = get_ciliate_ind( class2use, class_label )
% MVCO class list specific to return of indices that correspond to all variants of ciliates
%  Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013

class2get = {'ciliate' 'ciliate_mix' 'tintinnid' 'Myrionecta' 'Laboea' 'S_conicum' 'tiarina' 'strombidium_1' 'S_caudatum'...
    'Strobilidium_1' 'Tontonia' 'strombidium_2' 'S_wulffi'  'S_inclinatum' 'Euplotes' 'Didinium' 'Leegaardiella' 'Sol' 'strawberry' 'S_capitatum'};

[~,ind_out] = intersect(class2use, class2get);

end

