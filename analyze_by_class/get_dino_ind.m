function [ ind_out, class_label ] = get_dino_ind( class2use, class_label )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

class2get = {'Ceratium' 'dino30' 'Dinophysis' 'Gyrodinium' 'Prorocentrum' 'Gonyaulax' 'Akashiwo' 'Amphidinium_sp' 'Cochlodinium' 'Heterocapsa_rotundata'...
    'Heterocapsa_triquetra' 'Karenia' 'Katodinium_Torodinium' 'Protoperidinium' 'Proterythropsis_sp' 'dino_large1'};

[~,ind_out] = intersect(class2use, class2get);
ind_out = sort(ind_out);

end

