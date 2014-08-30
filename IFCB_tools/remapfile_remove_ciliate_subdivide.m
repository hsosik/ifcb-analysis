function [ file_struct_remapped ] = remapfile(config, file_struct); 
% function [ file_struct_remapped ] = remapfile(config, file_struct); 
%   Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013
%
% remapfile_remove_ciliate_subdivide ==> special case for moving ciliates subdivide list to end of main list, Aug 2014

col2remap = strmatch(config.type2map, file_struct.list_titles); %2 = manual, 3 = auto
eval(['class2use = file_struct.class2use_' config.type2map ';']);
%list_in = NaN(size(temp.classlist(:,col2remap)));
orig_length = length(class2use);
%if isfield(file_struct, 'class2use_sub4')
load class2use_MVCOciliate
class2use = [class2use class2use_sub4];

classlist = file_struct.classlist;
keyboard
if size(file_struct.classlist,2) > 3,
    ind2move = find(~isnan(file_struct.classlist(:,4)));
    classlist(ind2move,2) = classlist(ind2move,4) + orig_length;
end;
ind = find(~isnan(classlist(:,col2remap)));
list_in = class2use(classlist(ind,col2remap));

eval(['list_out = ' config.remapfunc '( list_in);'])
[~,b] = ismember(list_out,config.class2use);
%check to make sure all categories have been remapped
test = find(b ==0);
if ~isempty(test),
    disp(['Error: remap does not specify fate of ' unique((list_in(test)))]')
    return
end;
%[list_in' config.class2use(b)' file_struct.class2use_manual(file_struct.classlist(ind,2))'], keyboard %use this to diagnose remap
file_struct.classlist(ind,col2remap) = b; 
eval(['file_struct.class2use_' config.type2map ' = config.class2use;'])

col2remap = 3; %now do auto
ind = find(~isnan(classlist(:,col2remap)));
list_in = class2use(classlist(ind,col2remap));
eval(['list_out = ' config.remapfunc '( list_in);'])
[~,b] = ismember(list_out,config.class2use);
%check to make sure all categories have been remapped
test = find(b ==0);
if ~isempty(test),
    disp(['Error: remap does not specify fate of ' unique((list_in(test)))]')
    return
end;
%[list_in' config.class2use(b)' class2use(file_struct.classlist(ind,3))'], keyboard %use this to diagnose remap
file_struct.classlist(ind,col2remap) = b; 
eval(['file_struct.class2use_auto = config.class2use;'])



file_struct_remapped = file_struct; 

%clean up the files to remove subdivide info
if isfield(file_struct_remapped, 'class2use_sub4'),
    file_struct_remapped = rmfield(file_struct_remapped, 'class2use_sub4');
end;
if isfield(file_struct_remapped, 'class2use_sub'),
    file_struct_remapped = rmfield(file_struct_remapped, 'class2use_sub');
end;
file_struct_remapped.list_titles = file_struct_remapped.list_titles(1:3);
file_struct_remapped.classlist = file_struct_remapped.classlist(:,1:3);

end

