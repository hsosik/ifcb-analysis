function [ ] = start_classify_batch_user_training(classifierName , in_dir_feature, out_dir_class)
%function [ ] = start_classify_batch_user_training(classifierName , in_dir_feature, out_dir_class)
%For example:
%   start_classify_batch_user_training('C:\work\IFCB\user_training_test_data\manual\summary\UserExample_Trees_06Aug2015' , 'C:\work\IFCB\user_training_test_data\features\2014\', 'C:\work\IFCB\user_training_test_data\class\class2014_v1\')
%
%IFCB image classification: configure and initiate batch classification from extracted features and input classifier
% run make_TreeBaggerClassifier_user_training.m first to produce random forest classifier stored in file (classiferName)
%Heidi M. Sosik, Woods Hole Oceanographic Institution, August 2015
%
%Example input:
%   classifierName = 'C:\work\IFCB\user_training_test_data\manual\summary\UserExample_Trees_06Aug2015'; USER what classifier do you want to apply (full path)
%   in_dir_features = 'C:\work\IFCB\user_training_test_data\features\2014\'; %USER where are your feature files
%   out_dir_class = 'C:\work\IFCB\user_training_test_data\class\class2014_v1\';% USER what is the base path for output files

disp('Checking for files to run')
filelist = dir([in_dir_feature '*.csv']);
filelist = {filelist.name}';
filelist = regexprep(filelist, '_fea_v2.csv', '')';
files_done = dir([out_dir_class 'D*class_v1.mat']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-13));
filelist2 = setdiff(filelist, files_done);
filelist2 = strcat(filelist2,'_fea_v2.csv');  %USER specify v1 or v2 features as appropriate

disp(['processing ' num2str(length(filelist2)) ' files'])
batch_classify( in_dir_feature, filelist2, out_dir_class, classifierName );

end

