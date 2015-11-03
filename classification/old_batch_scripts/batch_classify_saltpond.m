feature_path = '/ifcb_saltpond/features/';
class_path = '/ifcb_saltpond/data/autoclassify_14May2012/';

filelist = dir([feature_path 'D*.mat']);
%load trees_compact_24Mar2012
load SaltPond_trees_14May2012
class2use={'Alexandrium doublet'; 'Alexandrium fusion'; 'Alexandrium infected'; 'Alexandrium planozygote'; 'Alexandrium quadruplet'; ...
            'Alexandrium tamarense'; 'Alexandrium triplet'; 'Amphidinium'; 'Amylax triacantha'; 'Asterionellopsis'; 'Azadinium'; 'Bacillaria'; 'Ceratium'; ...
            'Chaetoceros'; 'Cochlodinium'; 'Corethron'; 'Coscinodiscus'; 'Cylindrotheca'; 'Dactyliosolen'; 'Dictyocha'; 'Dinobryon'; ...
            'Dinophysis accuminata'; 'Ditylum'; 'Eucampia'; 'Geminogera'; 'Gonyaulax'; 'Guinardia delicatula'; 'Guinardia flaccida'; ...
            'Guinardia striata'; 'Gyrodinium'; 'Laboea'; 'Lauderia'; 'Leptocylindrus'; 'Melosira'; 'Myrionecta rubra'; 'Odontella'; 'Phaeocystis'; ...
            'Pleurosigma'; 'Prorocentrum gracile'; 'Protoperidinium'; 'Pseudo-nitzchia'; 'Rhizosolenia'; 'Skeletonema'; 'Stephanopyxis'; ...
            'Strombidium'; 'Thalassionema'; 'Thalassiosira'; 'Tintinnid'; 'beads'; 'centric'; 'centric chain'; 'ciliate'; 'detritus'; ...
            'flagellate'; 'lg dinoflagellate'; 'lorica'; 'other'; 'pennate'; 'sm dinoflagellate'; 'sm round cell'};
%     
nclass = length(classes);
class2use_auto = class2use;
class2use_manual = class2use;
list_titles = {'roi number'    'manual'    'Trees-auto'}; 

firstfile = 0;
for filecount = 1:length(filelist)
    filename = filelist(filecount).name;
    disp(['load ' filename])
    if ~exist([class_path filename], 'file'), 
        firstfile = firstfile + 1;
        load([feature_path filename])
        t = char(out.pid);
        roi_num = str2num(t(:,end-4:end));
        disp('format features')
        [ feature_mat, featitles ] = format_features( out );
        [ feature_mat, featitles ] = add_derived_features( feature_mat, featitles);
        if firstfile == 1,
            [~,i] = setdiff(featitles, {'FilledArea' 'summedFilledArea' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter'}');
            featitles = featitles(i);
        end;
        feature_mat = feature_mat(i,:)';
        disp('classifying...')
        [Y, scores] = predict(b,feature_mat);
        Y = str2num(char(Y)); %convert to number
        numrois = roi_num(end);
        classlist = NaN(numrois,3);
        classlist(:,1) = 1:numrois;
        for ii = 1:nclass,
            final_classnum = strmatch(classes(ii), class2use, 'exact');
            %need to use roi_num convention to match expected input for
            %previous manual_classify etc.
            classlist(roi_num(Y==ii),3) = final_classnum;            
            %classlist(roi_num(strmatch(class2use(ii), Y, 'exact')),3) = final_classnum; 
        end;
%         for ii = 1:length(class2use_sub4),
%             %need to use roi_num convention to match expected input for
%             %previous manual_classify etc.
%             ind = strmatch(class2use_sub4(ii), Y, 'exact');
%             classlist(roi_num(ind),4) = ii; 
%             classlist(roi_num(ind),3) = ciliate_classnum;  
%         end;
        disp('save results')
        save([class_path filename], 'classlist', 'class2use_auto', 'class2use_manual', 'list_titles', 'scores') 
    else
        disp('already done')
    end;
end;

