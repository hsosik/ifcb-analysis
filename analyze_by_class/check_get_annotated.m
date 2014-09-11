resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
load class2use_MVCOmanual4 %get the master list to start

[ classes_byfile, classes_bymode ] = get_annotated_classesMVCO( class2use, manual_list)

%check one file at a time
filenum = 10;
disp(classes_byfile.filelist(filenum))
disp('Manually checked: ')
disp(classes_byfile.class2use(classes_byfile.classes_checked(filenum,:)==1)')
disp('NOT manually checked: ')
disp(classes_byfile.class2use(classes_byfile.classes_checked(filenum,:)==0)')