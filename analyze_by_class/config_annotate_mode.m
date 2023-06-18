function [ class_cat, list_col, mode_ind, manual_only ] = config_annotate_mode( annotate_mode, class2use_here, manual_list, mode_list )
%evaluate case details for MVCO IFCB manual_list details
%called by countcells_MVCO_manual.m, biovolume_summary_MVCO_manual.m, biovolume_size_summary_MVCO_manual.m
%Heidi M. Sosik, Woods Hole Oceanographic Institution, Jan 2013
    
    switch annotate_mode
        case 'all categories'
            %use them all
            numclass = length(class2use_here);
            class_cat = 1:numclass;
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)));
        case 'ciliates'
            [~, class_cat] = intersect(class2use_here, {'Ciliate_mix' 'Didinium_sp' 'Euplotes_sp' 'Laboea_strobila' 'Leegaardiella_ovalis' 'Mesodinium_sp' 'Pleuronema_sp' 'Strobilidium_morphotype1'...
                'Strombidium_capitatum' 'Strombidium_conicum' 'Strombidium_inclinatum' 'Strombidium_morphotype1' 'Strombidium_morphotype2' 'Strombidium_oculatum'...
                'Strombidium_wulffi' 'Tiarina_fusus' 'Tintinnid' 'Tontonia_appendiculariformis' 'Tontonia_gracillima'});
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)));
        case 'ditylum'
            [~, class_cat] = intersect(class2use_here, 'Ditylum');
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)) & ~cell2mat(manual_list(2:end,strmatch('diatoms', mode_list)+1)));
        case 'diatoms'
            %all except mix, mix_elongated, and detritus
            [~, class_cat] = setdiff(class2use_here, {'mix' 'detritus' 'unclassified'});
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)));
        case 'big ciliates'
            [~, class_cat] = intersect(class2use_here, {'Tintinnid' 'Laboea_strobila'});
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)) & ~cell2mat(manual_list(2:end,strmatch('ciliates', mode_list)+1)));
        case 'special big only'
            [~, class_cat] = intersect(class2use_here, {'Ceratium' 'Eucampia' 'Ephemera' 'bad' 'Dinophysis' 'Lauderia' 'Licmophora' 'Phaeocystis' 'Stephanopyxis' ...
                'Coscinodiscus' 'Odontella' 'Guinardia_striata' 'Tintinnid' 'Laboea_strobila' 'Hemiaulus' 'Paralia' 'Guinardia_flaccida' 'Corethron' 'Dactyliosolen' 'Dictyocha'...
                'Dinobryon' 'Ditylum' 'Pleurosigma' 'Prorocentrum' 'Rhizosolenia' 'Thalassionema' 'clusterflagellate' 'kiteflagellates' 'Pyramimonas'});
            manual_only = 1;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)));
        case 'ciliate_ditylum'
            [~, class_cat] = intersect(class2use_here, {'Ditylum' 'Ciliate_mix' 'Didinium_sp' 'Euplotes_sp' 'Laboea_strobila' 'Leegaardiella_ovalis' 'Mesodinium_sp' 'Pleuronema_sp' 'Strobilidium_morphotype1'...
                'Strombidium_capitatum' 'Strombidium_conicum' 'Strombidium_inclinatum' 'Strombidium_morphotype1' 'Strombidium_morphotype2' 'Strombidium_oculatum'...
                'Strombidium_wulffi' 'Tiarina_fusus' 'Tintinnid' 'Tontonia_appendiculariformis' 'Tontonia_gracillima'});
            manual_only = 0;
            list_col = NaN;
            mode_ind = find(~cell2mat(manual_list(2:end,2)) & cell2mat(manual_list(2:end,3)) & cell2mat(manual_list(2:end,4)) & ~cell2mat(manual_list(2:end,5)) & cell2mat(manual_list(2:end,6)));   
        case 'parasites'
            [~, class_cat] = intersect(class2use_here, {'Chaetoceros_flagellate' 'Chaetoceros_pennate' 'Cerataulina_flagellate' 'G_delicatula_parasite' ...
                'G_delicatula_external_parasite' 'Chaetoceros_other' 'diatom_flagellate' 'other_interaction' 'Chaetoceros_didymus_flagellate' 'Leptocylindrus_mediterraneus'...
                'pennates_on_diatoms'});
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)));
       case 'chaetoceros'
            [~, class_cat] = intersect(class2use_here, {'Chaetoceros' 'Chaetoceros_flagellate' 'Chaetoceros_pennate' 'Chaetoceros_other' 'Chaetoceros_didymus' 'Chaetoceros_didymus_flagellate'});
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)));
       case 'guinardia'
            [~, class_cat] = intersect(class2use_here, {'Guinardia_delicatula' 'G_delicatula_parasite' 'G_delicatula_external_parasite' 'other_interaction' 'pennates_on_diatoms' 'diatom_flagellate' ...
                'G_delicatula_detritus'});
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)));
    end;

end

