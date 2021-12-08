%%    
load \\sosiknas1\IFCB_products\EXPORTS\summary\summary_biovol_allHDF_min20_2018lists.mat
load('\\sosiknas1\IFCB_products\EXPORTS\summary\summary_biovol_allHDF_min20_2018', 'meta_data')
ii = find(strcmp(meta_data.cruise, 'SR1812')& strcmp(meta_data.sample_type, 'underway'));
%%
cc = find(strcmp(class2use, 'Guinardia_flaccida'))
roiset = cat(1,classPidList{ii,cc});
whos roiset
%%
figure
t = tiledlayout(10,5)
title(t, 'CNN G. flaccida: ')
for ind = 1:length(roiset)
    nexttile
    imshow(imread(['https://ifcb-data.whoi.edu/EXPORTS/' roiset{ind} '.png']))
    %title(['CNN G. flaccida: ' set2{ind}])
    %title(set2(ind), 'interpreter', 'none')
    %pause
end