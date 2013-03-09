function [ ind_out, class_label ] = get_ciliate_ind( class2use, class_label )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

class2get = {'ciliate' 'ciliate_mix' 'tintinnid' 'Myrionecta' 'Laboea' 'S_conicum' 'tiarina' 'strombidium_1' 'S_caudatum'...
    'Strobilidium_1' 'Tontonia' 'strombidium_2' 'S_wulffi'  'S_inclinatum' 'Euplotes' 'Didinium' 'Leegaardiella' 'Sol' 'strawberry' 'S_capitatum'};

[~,ind_out] = intersect(class2use, class2get);

end

