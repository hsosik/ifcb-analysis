%Example code to set up and run through remapping class labels in a set of
%manual annotation result files
%   Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013

config = load('class2use_test', 'class2use'); %USER load YOUR class2use list from a file; format class2use = {'classstr1', 'classstr2', ...};
config.remappath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\Manual_fromClasstemp\'; %USER indicate path that contains all manual annotation files to be remapped
config.remapfunc = 'example_class_map'; %USER specify YOUR function that defines how classes are mapped from old to new
remap_class2use_manual(config)


