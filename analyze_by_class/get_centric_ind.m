
function [ ind_out, class_label ] = get_centric_ind( class2use, class_label)
%function [ ind_out, class_label ] = get_centric_ind( class2use, class_label )
% MVCO class list specific to return of indices that correspond to all
% variants of centric diatoms
%  Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013

class2get = {'Chaetoceros' 'Corethron' 'DactFragCerataul' 'Dactyliosolen' 'Ditylum' 'Eucampia' 'Guinardia_delicatula'...
    'Guinardia_flaccida' 'Leptocylindrus' 'Rhizosolenia' 'Skeletonema' 'Thalassiosira' 'Thalassiosira_dirty'...
   'Lauderia' 'Stephanopyxis' 'Cerataulina' 'Coscinodiscus' 'Odontella' 'Guinardia_striata' 'Paralia' 'Chaetoceros_didymus'...
  'Hemiaulus' 'Leptocylindrus_mediterraneus' 'Ditylum_parasite' 'Bidulphia'...
  'G_delicatula_parasite' 'G_delicatula_external_parasite' 'Chaetoceros_other'...
 'mix_elongated' 'Chaetoceros_didymus_flagellate'...
   'Chaetoceros_flagellate' 'Chaetoceros_pennate' 'Cerataulina_flagellate' 'diatom_flagellate'};
  %categories below here (last two lines above) are questionable, and may not want to be included.

[~,ind_out] = intersect(class2use, class2get);
ind_out = sort(ind_out);

end
