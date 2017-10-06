csv_path1 = '\\sosiknas1\IFCB_products\IFCB2_C211A_SEA2007\Manual_fromClass\annotations_csv_Aug2017\';
csvs = dir([csv_path1 '*.csv']);
csvs = {csvs.name};
csv_path2 = '\\sosiknas1\IFCB_products\IFCB2_C211A_SEA2007\Manual_fromClass\annotations_csv_Aug2017_new\';
mkdir(csv_path2)

for ii = 1:length(csvs)
    t = textread([csv_path1 csvs{ii}], '%s');
    slash = findstr('/', t{1});
    url = t{1}(1:slash(end));
    t = regexprep(t,url, '');
    fid = fopen([csv_path2 csvs{ii}], 'w+');
    for iii = 1:length(t)
        fprintf(fid, '%s\r\n', t{iii});
    end
    fclose(fid);
end