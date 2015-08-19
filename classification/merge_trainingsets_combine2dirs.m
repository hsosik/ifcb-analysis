%Pre-existing training set for MVCO (train_04Nov2011_fromWebServices)
%produced on 4 Nov 2011 from manual annotations existing as of that date
%New training set for MVCO (train_08Oct2014) produced the same way
%(make_sets_fromWebServices.m), but only for later times 
%(after running merge_trainingsets.m and merge_trainingsets_move_repeated.m) 
%We don't want to lose all the quality control already done on the old set
%by starting from scratch with the new one, but we do want to add more
%recent training examples (collected after Nov. 2011) and add examples to
%classes that didn't previously have enough
%
%After QC of new images, run this to combine the images in the two
%directories
finaldir = '\\sosiknas1\IFCB_products\MVCO\MVCO_train_Aug2015\'; %this is a renamed copy of the original, add to here
dir2move = '\\SOSIKNAS1\IFCB_products\MVCO\train_08Oct2014_merge_04Nov2011\'; % this is the place to add images from

class = dir(dir2move);
class = {class([class.isdir]).name}';
class = setdiff(class, {'.' '..'});

% !!make sure the oldest training set dirs have these name changes made first!!
%class(strmatch('Guinardia', class, 'exact')) = {'Guinardia_delicatula'};
%class(strmatch('Laboea', class, 'exact')) = {'Laboea_strobila'};
%class(strmatch('Myrionecta', class, 'exact')) = {'Mesodinium_sp'};
%class(strmatch('tintinnid', class, 'exact')) = {'Tintinnid'};

for ii = 1:length(class),
    disp(class{ii})
    dir2 = [finaldir class{ii} filesep];
    if ~exist(dir2, 'dir')
        mkdir(dir2)
    end
    copyfile([dir2move class{ii} filesep '*.png'], dir2)
end;