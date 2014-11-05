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
%RUN merge_trainingsets.m to do above
%
%Now need to segregate (or delete?) images that appear in both old and new
%sets; find redundant images in each class subdir of new set, create new
%"repeats" subdir under class, and move them there


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
    newdirclass = fullfile(newdir,classold{ii});
    listnew = dir(fullfile(newdirclass,'*.png'));
    listnew = {listnew.name}';
    for oldcase = 2:3,
        if oldcase == 1,
            olddirclass = fullfile(olddir,classold{ii});
        elseif oldcase == 2,
            olddirclass = fullfile(olddir,classold{ii}, 'somedoubt');
        else % oldcase == 3,
            olddirclass = fullfile(olddir,classold{ii},'confounded');
        end;
        listold = dir(fullfile(olddirclass,'*.png'));
        listold = {listold.name}';
        [~,inew, iold] = intersect(listnew, listold);
        if ~isempty(inew),
            movedir = fullfile(newdirclass, 'repeats');
            if ~exist(movedir, 'dir')
                mkdir(movedir)
            end;
            for count = 1:length(inew),
                movefile(fullfile(newdirclass,listnew{inew(count)}), fullfile(newdirclass, 'repeats\'))
            end;
        else
            disp('nothing to move')
        end;
    end;
end;