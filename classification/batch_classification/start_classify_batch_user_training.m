classifierName = 'C:\work\IFCB\user_training_test_data\manual\summary\UserExample_Trees_06Aug2015'; %USER what classifier do you want to apply
yr = 2014; %USER what is the year of your data set

out_dir = ['C:\work\IFCB\user_training_test_data\class\class' num2str(yr) '_v1\'];% USER what is the base path for output files
%in_dir = 'http://ifcb-data.whoi.edu/mvco/';
%for V2 web services, set fea_dir = in_dir;
fea_dir = ['C:\work\IFCB\user_training_test_data\features\' num2str(yr) filesep]; %USER where are your feature files

filelist = [];

disp('Checking for files to run')
filelist = dir([fea_dir '*.csv']);
filelist = {filelist.name}';
filelist = regexprep(filelist, '_fea_v2.csv', '')';
%filelist = regexprep(filelist, in_dir, '')';
files_done = dir([out_dir 'IFCB*class_v1.mat']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-13));
filelist2 = setdiff(filelist, files_done);
filelist2 = strcat(filelist2,'_fea_v2.csv');  %USER specify v1 or v2 features as appropriate

disp(['processing ' num2str(length(filelist2)) ' files'])
batch_classify( fea_dir, filelist2, out_dir, classifierName );

