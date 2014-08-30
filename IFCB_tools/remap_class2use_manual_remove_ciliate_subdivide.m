function [  ] = remap_class2use_manual( config )
%function  [  ] = remap_class2use_manual( config )
%   Detailed explanation goes here
%   Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013
%
% remap_class2use_manual_remove_ciliate_subdivide.m ==> case for moving
% ciliates subdivide list to end of main list, Aug 2014

disp(['WARNING: you are about to remap classes in ' config.remappath ' to correspond to the following master list'])
disp(config.class2use)
flag = input('Are you sure you want to do this? Type ''yes'' to proceed. ', 's');
if strcmp('yes', flag),
    disp('Remapping: ')
    filelist = dir([config.remappath 'IFCB*.mat']);
    config.type2map = 'manual'; %'manual', 'auto', etc. from list_titles
    for filecount = 1:length(filelist),
        fname = filelist(filecount).name;
        disp(fname)
        %file_struct = load([config.remappath fname]);
        file_struct = load(['\\raspberry\d_work\IFCB1\ifcb_data_MVCO_jun06\Manual_fromClass_backup_20Aug2014\' fname]);
        file_struct_remapped = remapfile_remove_ciliate_subdivide(config, file_struct); 
        save([config.remappath fname], '-struct', 'file_struct_remapped')
    end;
end;

end

