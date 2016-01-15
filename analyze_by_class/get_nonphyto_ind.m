function [ ind_out, class_label ] = get_nonphyto_ind( class2use, class_label )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

class2get = {'Thalassiosira_dirty' 'bad' 'amoeba' 'Ciliate_mix' 'Didinium_sp' 'Euplotes_sp' 'Laboea_strobila'...
    'Leegaardiella_ovalis' 'Mesodinium_sp' 'Pleuronema_sp' 'Strobilidium_morphotype1' 'Strombidium_capitatum'...
    'Strombidium_conicum' 'Strombidium_inclinatum' 'Strombidium_morphotype1' 'Strombidium_morphotype2'...
    'Strombidium_oculatum' 'Strombidium_wulffi' 'Tiarina_fusus' 'Tintinnid' 'Tontonia_appendiculariformis' 'Tontonia_gracillima'...
    'bead' 'bubble' 'pollen' 'spore' 'zooplankton' 'unclassified' 'other' 'detritus' 'camera_spot'};

[~,ind_out] = intersect(class2use, class2get);
ind_out = sort(ind_out);

end

