function classTable = load_class_scores(path)
%function [bin_id, scores, roi_numbers, class_labels] = load_class_scores(path)

%scores = h5read(path,'/scores')';

%bin_id = h5readatt(path,'/scores','bin_id');
%roi_numbers = h5read(path,'/roi_numbers');
%class_labels = h5readatt(path,'/scores','class_labels');

%Heidi, new format Oct 2020
classTable.scores = h5read(path,'/output_scores')';
classTable.roi_numbers = h5read(path,'/roi_numbers');
classTable.metadata.bin_id = h5readatt(path,'/metadata','bin_id');
classTable.metadata.version = h5readatt(path,'/metadata','version');
classTable.metadata.model_id = h5readatt(path,'/metadata','model_id');
classTable.metadata.run_timestamp = h5readatt(path,'/metadata','timestamp');
classTable.class_labels = cellstr(h5read(path,'/class_labels'));
classTable.top_class = h5read(path,'/output_classes')';
end