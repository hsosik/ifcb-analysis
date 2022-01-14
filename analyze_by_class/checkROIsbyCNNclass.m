%%    
load \\sosiknas1\IFCB_products\EXPORTS\summary\summary_biovol_allHDF_min20_2018lists.mat
load('\\sosiknas1\IFCB_products\EXPORTS\summary\summary_biovol_allHDF_min20_2018', 'meta_data')
ii = find(strcmp(meta_data.cruise, 'SR1812')& strcmp(meta_data.sample_type, 'underway'));
%%
classStr = 'Guinardia_flaccida';
cc = find(strcmp(class2use, classStr))
roiset = cat(1,classPidList{ii,cc});
whos roiset
%%
%get the images 
disp('Reading images...')
clear img
for ind = 1:length(roiset)
   if ~rem(ind,20)
       disp([num2str(ind) ' of ' num2str(length(roiset))]);
   end
   img{ind} = imread(['https://ifcb-data.whoi.edu/EXPORTS/' roiset{ind} '.png']);
end
disp('Ready to plot')
%%
figure
t = tiledlayout(4,3);
title(t, ['CNN ' classStr], 'interpreter', 'none')
tilecount = 0;
for ind = 1:length(roiset)
    if tilecount<prod(t.GridSize)
        nexttile
        tilecount = tilecount+1;
        imshow(img{ind})
        title(roiset(ind), 'interpreter', 'none')
    else
        pause
        tilecount = 0;
        clf
        t = tiledlayout(4,3);
        title(t, ['CNN ' classStr], 'interpreter', 'none')
    end
end