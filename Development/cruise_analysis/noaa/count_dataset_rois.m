function [ ] = count_dataset_rois(classDir);
%function [ ] = count_dataset_rois(classDir); classDir = the location of
%autoclass files. Total is the total number of ROIS that were classified
%for the dataset. 
classDir_mat = [classDir '*.mat'];
temp = dir(classDir_mat);
list = {temp.name}';
total = 0;
for i = 1:length(temp);
     load([classDir temp(i).name]);
     num = length(TBclass);
     total = total + num;
end
num_files = length(list)
total

end
