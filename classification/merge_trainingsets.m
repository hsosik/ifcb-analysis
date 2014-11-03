%Pre-existing training set for MVCO (train_04Nov2011_fromWebServices)
%produced on 4 Nov 2011 from manual annotations existing as of that date
%New training set for MVCO (train_08Oct2014) produced the same way
%(make_sets_fromWebServices.m).
%We don't want to lose all the quality control already done on the old set
%by starting from scratch with the new one, but we do want to add more
%recent training examples (collected after Nov. 2011) and add examples to
%classes that didn't previously have enough
%--> produce new merged set here: train_08Oct2014_merge_04Nov2011
%1. Keep everything from train_04Nov2011_fromWebServices
%2. For all classes, include any image in the new set from dates after Nov
%2011
%3. For classes that are still underrepresented, add in more (randomly
%chosen) from the new set with dates pre-Nov 2011. 

%Check number of training images in old set, plus number of recent 
%images in new set; if >400, then move all pre Nov 2011 images 
%in new set into 'extra' subdir. 

olddir = '\\SOSIKNAS1\IFCB_products\MVCO\train_04Nov2011_fromWebServices\';
newdir = '\\SOSIKNAS1\IFCB_products\MVCO\train_08Oct2014_merge_04Nov2011\';

class = dir(olddir);
class = {class([class.isdir]).name}';
class = class(3:end);
classold = class;

class(strmatch('Guinardia', class, 'exact')) = {'Guinardia_delicatula'};
class(strmatch('Laboea', class, 'exact')) = {'Laboea_strobila'};
class(strmatch('Myrionecta', class, 'exact')) = {'Mesodinium_sp'};
class(strmatch('tintinnid', class, 'exact')) = {'Tintinnid'};
classnew = class; clear class

for ii = 1:length(classold),
    disp(classnew{ii})
    listold = dir(fullfile(olddir,classold{ii},'*.png'));
    listnew = dir(fullfile(newdir,classnew{ii},'*.png'));
    listnew = {listnew.name}';
    mdate = IFCB_file2date(listnew);
    ind = find(mdate >= datenum('11-22-2011'));
    num = length(listold) + length(ind);
    if num >= 400, %move all with old dates       
        ind = find(mdate < datenum('11-22-2011'));
        source = fullfile(newdir,classnew{ii},listnew(ind)); 
        for count = 1:length(source),
            movefile(source{count}, fullfile(newdir, classnew{ii}, 'extra\'))
        end;
    else
        disp('nothing to move')
    end;
end;