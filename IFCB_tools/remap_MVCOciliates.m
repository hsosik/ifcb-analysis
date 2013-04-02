load class2use_MVCOciliate

remappath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
remapfunc = 'ciliate_class_map';

%disp(['WARNING: you are about to remap classes in ' remappath ' to correspond to the following master list'])
%disp(class2use)

%flag = input('Are you sure you want to do this? Type ''yes'' to proceed. ', 's');
%if strmatch(flag, 'yes'),

disp('Remapping: ')
filelist = dir([remappath 'IFCB*.mat']);

type2map = 'ciliate'; %'manual', 'auto', etc. from list_titles

for filecount = 124:length(filelist),
    fname = filelist(filecount).name;
    disp(fname)
    temp = load([remappath fname]);
    
    col2remap = strmatch(type2map, temp.list_titles); %2 = manual, 3 = auto
    %correct legacy label assuming SVM
    if strmatch('SVM-auto', temp.list_titles(3)),
        temp.list_titles{3} = 'auto';
    end;
    %eval(['class2use = temp.class2use_' type2map ';']);
    if isfield(temp, 'class2use_sub4'),
    class2use = temp.class2use_sub4;
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
    %[ list_in class2use_sub4(b)]
    %[ list_in' class2use_sub4(b)]
    %pause
    temp.classlist(ind,col2remap) = b;
    else
        disp('adding class2use_sub4')
    end;
    temp.class2use_sub4 = class2use_sub4';
    
    save([remappath fname], '-struct', 'temp')
end;