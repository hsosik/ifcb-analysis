resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
filelist = manual_list(2:end,1);

class2use_sub4new = {'not_ciliate'    'ciliate_mix'    'tintinnid'    'Myrionecta'    'Laboea'    'S_conicum'...
    'tiarina'    'strombidium1'    'Scaudatum'    'Tontonia' 'strombidium2'    'S_wulffi'    'S_inclinatum'...
    'Euplotes'    'Didinium'    'Leegaardiella'    'Sol'    'strawberry'    'S_capitatum'};

for ii = 1:length(filelist),
    disp(filelist{ii})
    clear class2use_sub4
    load([resultpath filelist{ii}], 'class2use_sub4');
    if exist('class2use_sub4', 'var'),
        class2use_sub4 = class2use_sub4new;
        save([resultpath filelist{ii}], 'class2use_sub4', '-append');
    end;
end;
