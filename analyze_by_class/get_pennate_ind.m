function [ ind_out, class_label ] = get_pennate_ind( class2use, class_label)
%function [ ind_out, class_label ] = get_pennate_ind( class2use, class_label )
% MVCO class list specific to return of indices that correspond to all
% variants of pennate diatoms
%  Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013

class2get = {'Asterionellopsis' 'Cylindrotheca' 'Ephemera' 'Pleurosigma' 'Pseudonitzschia' 'Thalassionema'...
    'pennate' 'Licmophora' 'Bacillaria' 'pennate_morphotype1' 'Delphineis'};
% not sure what to do with 'pennates_on_diatoms'
[~,ind_out] = intersect(class2use, class2get);
ind_out = sort(ind_out);

end

