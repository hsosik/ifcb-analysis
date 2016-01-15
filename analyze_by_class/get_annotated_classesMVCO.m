function [ classes_byfile, classes_bymode ] = get_annotated_classesMVCO( class2use_here, manual_list)
%function [ classes_bymode ] = get_annotated_classesMVCO( class2use_here, manual_list)
%recast from config_annotate_mode.m to simplify and generalize use not only for count and biovolume summaries, but also training set extraction 
%**TO BE** called by countcells_MVCO_manual.m, biovolume_summary_MVCO_manual.m, biovolume_size_summary_MVCO_manual.m
%Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2014 

mode_list = manual_list(1,2:end-1);
manual_list_col = 1:length(mode_list);
filelist = char(manual_list(2:end,1)); filelist = cellstr(filelist(:,1:end-4));
mode_flags_byfile = cell2mat(manual_list(2:end,2:end-1));

for count = 1:length(mode_list),

    annotate_mode = mode_list{count};

    switch annotate_mode
        case 'all categories'
            %use them all
            class_cat = 1:length(class2use_here);
        case 'ciliates'
            [~, class_cat] = intersect(class2use_here, {'Ciliate_mix' 'Didinium_sp' 'Euplotes_sp' 'Laboea_strobila' 'Leegaardiella_ovalis' 'Mesodinium_sp' 'Pleuronema_sp' 'Strobilidium_morphotype1'...
                'Strombidium_capitatum' 'Strombidium_conicum' 'Strombidium_inclinatum' 'Strombidium_morphotype1' 'Strombidium_morphotype2' 'Strombidium_oculatum'...
                'Strombidium_wulffi' 'Tiarina_fusus' 'Tintinnid' 'Tontonia_appendiculariformis' 'Tontonia_gracillima'});
        case 'ditylum'
            [~, class_cat] = intersect(class2use_here, {'Ditylum' 'Ditylum_parasite'});
        case 'diatoms'
            %all except mix and detritus
            [~, class_cat] = setdiff(class2use_here, {'mix' 'detritus'});
        case 'big ciliates'
            [~, class_cat] = intersect(class2use_here, {'Tintinnid' 'Laboea_strobila'});
        case 'special big only'
            [~, class_cat] = intersect(class2use_here, {'Ceratium' 'Eucampia' 'Ephemera' 'bad' 'Dinophysis' 'Lauderia' 'Licmophora' 'Phaeocystis' 'Stephanopyxis' ...
                'Coscinodiscus' 'Odontella' 'Guinardia_striata' 'Tintinnid' 'Laboea_strobila' 'Hemiaulus' 'Paralia' 'Guinardia_flaccida' 'Corethron' 'Dactyliosolen' 'Dictyocha'...
                'Dinobryon' 'Ditylum' 'Pleurosigma' 'Prorocentrum' 'Rhizosolenia' 'Thalassionema' 'clusterflagellate' 'kiteflagellates' 'Pyramimonas'});
        case 'parasites'
            [~, class_cat] = intersect(class2use_here, {'Chaetoceros_flagellate' 'Chaetoceros_pennate' 'Cerataulina_flagellate' 'G_delicatula_parasite' ...
                'G_delicatula_external_parasite' 'Chaetoceros_other' 'diatom_flagellate' 'other_interaction' 'Chaetoceros_didymus_flagellate' 'Leptocylindrus_mediterraneus'...
                'pennates_on_diatoms'});
       case 'chaetoceros'
            [~, class_cat] = intersect(class2use_here, {'Chaetoceros' 'Chaetoceros_flagellate' 'Chaetoceros_pennate' 'Chaetoceros_other' 'Chaetoceros_didymus' 'Chaetoceros_didymus_flagellate'});
       case 'guinardia'
            [~, class_cat] = intersect(class2use_here, {'Guinardia_delicatula' 'Guinardia_flaccida' 'Guinardia_striata' 'G_delicatula_parasite' 'G_delicatula_external_parasite' 'other_interaction' 'pennates_on_diatoms' 'diatom_flagellate' ...
                'G_delicatula_detritus'});
    end;
    classes_bymode.classes_manual_check{count} = class_cat;
    
end

classes_checked = zeros(length(filelist), length(class2use_here));
for count = 1:length(mode_list),
    classes_checked(mode_flags_byfile(:,count)==1,classes_bymode.classes_manual_check{count}) = 1;
end;

classes_bymode.mode_list = mode_list;
classes_bymode.manual_list_col = manual_list_col;
classes_bymode.class2use = class2use_here;
classes_byfile.filelist = filelist;
classes_byfile.classes_checked = classes_checked;
classes_byfile.class2use = class2use_here;

end

