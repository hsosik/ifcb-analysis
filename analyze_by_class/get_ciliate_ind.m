function [ ind_out, class_label ] = get_ciliate_ind( class2use, class_label)
%function [ ind_out, class_label ] = get_ciliate_ind( class2use, class_label )
% MVCO class list specific to return of indices that correspond to all variants of ciliates
%  Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013

class2get = {'Ciliate_mix' 'Didinium_sp' 'Euplotes_sp' 'Laboea_strobila' 'Leegaardiella_ovalis' 'Mesodinium_sp'...
    'Pleuronema_sp' 'Strobilidium_morphotype1' 'Strobilidium_morphotype2' 'Strombidium_capitatum' 'Strombidium_caudatum'...
    'Strombidium_conicum' 'Strombidium_inclinatum' 'Strombidium_morphotype1' 'Strombidium_morphotype2' 'Strombidium_oculatum'...
    'Strombidium_wulffi' 'Tiarina_fusus' 'Tintinnid' 'Tontonia_appendiculariformis' 'Tontonia_gracillima'};

[~,ind_out] = intersect(class2use, class2get);
ind_out = sort(ind_out);

end

