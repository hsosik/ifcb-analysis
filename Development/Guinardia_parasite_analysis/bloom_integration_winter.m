load ('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_manual_current_day')
%load ('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_manual_16Nov2013_day')
[ ind_Gdel, class_label ] = get_G_delicatula_ind( class2use, class2use );
ind14 = find(~isnan(ml_analyzed_mat_bin(:,14)) | nansum(ml_analyzed_mat_bin,2) == 0);
X2 = matdate_bin(ind14);
%Y2 = classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14);
Y2 = sum((classcount_bin(ind14,ind_Gdel)./ml_analyzed_mat_bin(ind14,ind_Gdel)),2);
Z2 = cumtrapz(X2,Y2);

yrlist = ([2006 2008:2012])';
%yrlist = (2006:2012)';
start_stop(:,1) = datenum([repmat('12-15-', length(yrlist),1) num2str(yrlist)]);
start_stop(:,2) = datenum([repmat('04-15-', length(yrlist),1) num2str(yrlist+1)]);

X2i = start_stop'; X2i = X2i(:);
Z2i = interp1(X2,Z2,X2i);

figure
plot(X2,Z2, '.-')
datetick
hold on
plot(X2i,Z2i, 'r*')

bloom_start_end2 = reshape(Z2i,2,length(yrlist))';
bloom_int2 = bloom_start_end2(:,2)-bloom_start_end2(:,1);

ind59 = find(~isnan(ml_analyzed_mat_bin(:,59)) | nansum(ml_analyzed_mat_bin,2) == 0);
X1 = matdate_bin(ind59);
Y1 = classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59);
Z1 = cumtrapz(X1,Y1);
X1i = start_stop'; X1i = X1i(:);
Z1i = interp1(X1,Z1,X1i);

plot(X1,Z1, 'g.-')
plot(X1i,Z1i, 'm*')

bloom_start_end1 = reshape(Z1i,2,length(yrlist))';
bloom_int1 = bloom_start_end1(:,2)-bloom_start_end1(:,1);

figure
set(gcf, 'units', 'inches')
set(gcf, 'position', [1 2 7.5 6], 'paperposition', [1 1 7.5 6]);
plot(bloom_int1, bloom_int2, 'k.', 'MarkerSize',20)
text(bloom_int1+1, bloom_int2+75, num2str(yrlist+1), 'FontSize',20)
axis([0 80 0 4900])
set(gca, 'FontSize', 20)
ylabel('Integrated \it{G. delicatula}\rm (chains ml^{ -1} d)', 'FontSize',20)
xlabel('Integrated infected \it{G. delicatula}\rm (chains ml^{ -1} d)', 'FontSize',20)

[r,p] = corrcoef(bloom_int1,bloom_int2);
r = r(2); p = p(2);

%permutation test, one-tailed for negative
[pval, corr_obs, crit_corr, est_alpha]=mult_comp_perm_corr(bloom_int2,bloom_int1,1e6,-1);