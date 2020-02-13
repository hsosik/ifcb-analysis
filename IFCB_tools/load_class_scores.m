function [bin_id, scores, roi_numbers, class_labels] = load_class_scores(path)

scores = h5read(path,'/scores')';

bin_id = h5readatt(path,'/scores','bin_id');
roi_numbers = h5read(path,'/roi_numbers');
class_labels = h5readatt(path,'/scores','class_labels');

end