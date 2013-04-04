load class2use_MVCOciliate

%remappath1 = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
%remappath2 = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Copy_Manual_fromClass_Apr2013\';
remappath1 = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\Manual_fromClass_bad\';
remappath2 = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Copy_Manual_fromClass_Apr2013\Manual_fromClass_bad\';
remapfunc = 'ciliate_class_map';

%disp(['WARNING: you are about to remap classes in ' remappath ' to correspond to the following master list'])
%disp(class2use)

%flag = input('Are you sure you want to do this? Type ''yes'' to proceed. ', 's');
%if strmatch(flag, 'yes'),

disp('Remapping: ')
filelist = dir([remappath2 'IFCB*.mat']);

type2map = 'ciliate'; %'manual', 'auto', etc. from list_titles
files_nosub = [];
for filecount = 1:length(filelist),
    fname = filelist(filecount).name;
    disp(fname)
    temp = load([remappath2 fname]);
    
    col2remap = strmatch(type2map, temp.list_titles); %2 = manual, 3 = auto
    %correct legacy label assuming SVM
    if strmatch('SVM-auto', temp.list_titles(3)),
        temp.list_titles{3} = 'auto';
    end;
    %eval(['class2use = temp.class2use_' type2map ';']);
    if isfield(temp, 'class2use_sub4') | ~isempty(find(~isnan(temp.classlist(:,4)))),
        if isfield(temp, 'class2use_sub4'),
            class2use = temp.class2use_sub4;
        else %handle odd case with no clsas2use_sub4 but with entries in col 4
            disp('adding class2use_sub4')
            class2use = {'not_ciliate' 'ciliate_mix' 'tintinnid' 'Myrionecta' 'Laboea' 'S_conicum' 'tiarina' 'strombidium_1'...
                 'S_caudatum', 'Strobilidium_1' 'Tontonia' 'strombidium_2' 'S_wulffi' 'S_inclinatum' 'Euplotes' 'Didinium'...
                 'Leegaardiella' 'Sol' 'strawberry' 'S_capitatum'};
            files_nosub = [files_nosub; fname];
        end;
        %list_in = NaN(size(temp.classlist(:,col2remap)));
        ind = find(~isnan(temp.classlist(:,col2remap)));
        list_in = class2use(temp.classlist(ind,col2remap));
        
        eval(['list_out = ' remapfunc '( list_in);'])
        [~,b] = ismember(list_out,class2use_sub4);
        %check to make sure all categories have been remapped
        test = find(b ==0);
        if ~isempty(test),
            disp(['Error: remap does not specify fate of ' unique((list_in(test)))]')
            return
        end;
        %[ list_in' class2use_sub4(b)]
        %pause
        temp.classlist(ind,col2remap) = b;
    else
        disp('adding class2use_sub4')
    end;
    temp.class2use_sub4 = class2use_sub4';

save([remappath1 fname], '-struct', 'temp')
end;