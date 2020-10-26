function [bin_id, scores, roi_numbers, class_labels] = load_class_scores(path)

%scores = h5read(path,'/scores')';

%bin_id = h5readatt(path,'/scores','bin_id');
%roi_numbers = h5read(path,'/roi_numbers');
%class_labels = h5readatt(path,'/scores','class_labels');

%Heidi, new format Oct 2020
scores = h5read(path,'/output_scores')';
roi_numbers = h5read(path,'/roi_numbers');
bin_id = h5readatt(path,'/metadata','bin_id');
class_labels = cellstr(h5read(path,'/class_labels'));

end