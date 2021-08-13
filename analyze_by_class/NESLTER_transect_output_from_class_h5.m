p = '\\sosiknas1\IFCB_products\NESLTER_transect\summary\';
pout = '\\sosiknas1\IFCB_products\NESLTER_transect\class\summary\';
if ~exist(pout, 'dir')
    mkdir(pout)
end
yr = 2021;

f = ['summary_biovol_allHDF_min20_' num2str(yr)];
load([p f]);    
ml_analyzed = meta_data.ml_analyzed;
    
ii = find(ml_analyzed<=5 & ml_analyzed>0);
count = classcount(ii,:);
biovol = classbiovol(ii,:);
ml = ml_analyzed(ii);
mdate = mdate(ii);
meta_data = meta_data(ii,:);

T = table;
T.datetime = datetime(mdate, 'ConvertFrom', 'datenum');
T2 = array2table(count./ml, 'VariableNames', class2use);
concentration_by_class = [T T2 meta_data];

writetable(concentration_by_class, ['\\sosiknas1\IFCB_products\NESLTER_transect\class\summary\concentration_by_class_fromCNN_transects' num2str(yr) '.csv'])

T2 = array2table(biovol./ml, 'VariableNames', class2use);
biovol_concentration_by_class = [T T2 meta_data];

writetable(biovol_concentration_by_class, ['\\sosiknas1\IFCB_products\NESLTER_transect\class\summary\biovol_concentration_by_class_fromCNN_transects' num2str(yr) '.csv'])

return

group_table = readtable('\\sosiknas1\training_sets\IFCB\config\IFCB_classlist_type.csv');
group_table.CNN_classlist(strmatch('Pseudo-nitzschia', group_table.CNN_classlist)) = {'Pseudo_nitzschia'};
[~,ia,ib] = intersect(group_table.CNN_classlist, class2use);
diatom_ind = ib(find(group_table.Diatom(ia)));


