function [ file_struct_remapped ] = remapfile(config, file_struct); 
% function [ file_struct_remapped ] = remapfile(config, file_struct); 
%   Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013

col2remap = strmatch(config.type2map, file_struct.list_titles); %2 = manual, 3 = auto
%correct legacy label assuming SVM
if strmatch('SVM-auto', file_struct.list_titles(3)),
    file_struct.list_titles{3} = 'auto';
end;
eval(['class2use = file_struct.class2use_' config.type2map ';']);
    %list_in = NaN(size(temp.classlist(:,col2remap)));
ind = find(~isnan(file_struct.classlist(:,col2remap)));
list_in = class2use(file_struct.classlist(ind,col2remap));

eval(['list_out = ' config.remapfunc '( list_in);'])
[~,b] = ismember(list_out,config.class2use);
%check to make sure all categories have been remapped
test = find(b ==0);
if ~isempty(test),
    disp(['Error: remap does not specify fate of ' unique((list_in(test)))]')
    return
end;
%[list_in' config.class2use(b)'], keyboard %use this to diagnose remap
file_struct.classlist(ind,col2remap) = b; 
eval(['file_struct.class2use_' config.type2map ' = config.class2use;'])
file_struct_remapped = file_struct; 

end

