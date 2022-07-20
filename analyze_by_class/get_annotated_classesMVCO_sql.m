function [ classes_byfile, classes_bymode ] = get_annotated_classesMVCO( class2use_here, manual_list)
%function [ classes_bymode ] = get_annotated_classesMVCO( class2use_here, manual_list)
%recast from config_annotate_mode.m to simplify and generalize use not only for count and biovolume summaries, but also training set extraction 
%**TO BE** called by countcells_MVCO_manual.m, biovolume_summary_MVCO_manual.m, biovolume_size_summary_MVCO_manual.m
%Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2014 

mode_list = manual_list(1,2:end-1);
manual_list_col = 1:length(mode_list);

%filelist = char(manual_list(2:end-4,1)); filelist = cellstr(filelist(:,1:end-4));
%filelist = char(manual_list(2:end,1)); filelist = cellstr(filelist(:,1:end-4));
filelist = manual_list(2:end,1); filelist = regexprep(filelist, '.mat', '');

mode_flags_byfile = cell2mat(manual_list(2:end,2:end-1));


for count = 1:length(mode_list)

    annotate_mode = mode_list{count};

    class_cat = {}; %set to no classes if all entries in manual_list are zero
    switch annotate_mode
        case 'all categories'
            %use them all
            class_cat = 1:length(class2use_here);
        case 'ciliates'
            [~, class_cat] = intersect(class2use_here, {'ciliate' 'Didinium' 'Euplotes' 'Euplotes morphotype1' 'Laboea strobila' 'Leegaardiella ovalis' 'Mesodinium' 'Pleuronema' 'Strobilidium'...
                'Strombidium capitatum' 'Strombidium conicum' 'Strombidium inclinatum' 'Strombidium morophotype 1' 'Strombidium morphotype 2' 'Strombidium oculatum'...
                'Strombidium wulffi' 'Tiarina fusus' 'Tintinnida' 'Tontonia appendiculariformis' 'Tontonia gracillima'...
                'Eutintinnus' 'Favella' 'Helicostomella subulata' 'Stenosemella morphotype 1' 'Stenosemella pacifica' 'Tintinnidium mucicola'...
                'Tintinnopsis' 'Balanion' 'Dictyocysta'});
        case 'ditylum'
            [~, class_cat] = intersect(class2use_here, {'Ditylum'  'Ditylum brightwellii_internal parasite'});
        case 'diatoms'
            %all except mix and detritus
            [~, class_cat] = setdiff(class2use_here, {'mix' 'detritus' 'unclassified'});
        case 'big ciliates'
            [~, class_cat] = intersect(class2use_here, {'Tintinnida' 'Laboea strobila' 'Eutintinnus' 'Favella' 'Helicostomella subulata' 'Stenosemella morphotype 1' 'Stenosemella pacifica' 'Tintinnidium mucicola'...
                'Tintinnopsis'});
        case 'special big only'
            [~, class_cat] = intersect(class2use_here, {'Ceratium' 'Eucampia cornuta' 'Ephemera' 'bad' 'Dinophysis' 'Lauderia annulata' 'Licmophora' 'Phaeocystis' 'Stephanopyxis' ...
                'Coscinodiscus' 'Odontella' 'Guinardia striata' 'Tintinnida' 'Laboea strobila' 'Eutintinnus' 'Favella' 'Helicostomella subulata' 'Stenosemella morphotype 1' 'Stenosemella pacifica' 'Tintinnidium mucicola'...
                'Tintinnopsis' 'Hemiaulus' 'Paralia sulcata' 'Guinardia flaccida' 'Corethron hystrix' 'Dactyliosolen fragilissimus' 'Dactyliosolen blavyanus' 'Dictyocha'...
                'Dinobryon' 'Ditylum brightwellii' 'Pleurosigma' 'Prorocentrum' 'Rhizosolenia' 'Thalassionema' 'Corymbellus' 'Chrysochromulina lanceolata' 'Chrysochromulina lanceolata' 'Pyramimonas longicauda'});
        case 'parasites'
            [~, class_cat] = intersect(class2use_here, {'Chaetoceros_external flagellate' 'Chaetoceros_external pennate' 'Cerataulina pelagica_external flagellate' 'Guinardia delicatula_internal parasite' ...
                'Guinardia delicatula_external parasite' 'Chaetoceros_interaction' 'Bacillariophyceae_external flagellate' 'other_interaction' 'Chaetoceros didymus_external flagellate' 'Leptocylindrus mediterraneus'...
                'Bacillariophyceae_external pennate'});
       case 'chaetoceros'
            [~, class_cat] = intersect(class2use_here, {'Chaetoceros' 'Chaetoceros_external flagellate' 'Chaetoceros_external pennate' 'Chaetoceros_interaction' 'Chaetoceros didymus' 'Chaetoceros didymus_external flagellate' 'Chaetoceros peruvianis'});
       case 'guinardia'
            [~, class_cat] = intersect(class2use_here, {'Guinardia delicatula' 'Guinardia flaccida' 'Guinardia striata' 'Guinardia delicatula_internal parasite' 'Guinardia delicatula_external parasite' 'other_interaction' 'Bacillariophyceae_external pennates' 'Bacillariophyceae_external flagellate' ...
                'Guinardia delicatula_bleach damaged'});
       case 'gyrodenoids'
            [~, class_cat] = intersect(class2use_here, {'Gyrodinium'});
    end
    classes_bymode.classes_manual_check{count} = class_cat;
    
end

classes_checked = zeros(length(filelist), length(class2use_here));
for count = 1:length(mode_list)
    if ~isempty(classes_bymode.classes_manual_check{count})
        classes_checked(mode_flags_byfile(:,count)==1,classes_bymode.classes_manual_check{count}) = 1;
    end
end

classes_bymode.mode_list = mode_list;
classes_bymode.manual_list_col = manual_list_col;
classes_bymode.class2use = class2use_here;
classes_byfile.filelist = filelist;
classes_byfile.classes_checked = classes_checked;
classes_byfile.class2use = class2use_here;

end

