load '/Users/markmiller/Documents/count_manual_current_day.mat'
perml=classcount_bin./ml_analyzed_mat_bin;
perml=perml';
elsa_perml=perml;
save elsa_perml

for i=1:length(matdate_bin);
    rep{i}=(['t', num2str(i),'r1']);
end

for i=1:length(class2use);
    factor{i}=(['f',num2str(i)]);
end

factor=factor';