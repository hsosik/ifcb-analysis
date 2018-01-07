result_path = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017\splits\';
result_path = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017_new\splits\';
%result_path = 'C:\work\IFCB\Manual_fromClass\train_fromcsv_Sep2017\splits\';
%result_path2 = 'C:\work\IFCB\\Manual_fromClass\train_fromcsv_Sep2017_new\splits\';

train_filename = 'train_features_v2';
result_str = 'trees_features_v2_';

load([result_path train_filename])
temp = load([result_path2 train_filename]);
class2use = [class2use temp.class2use];
class_vector = [class_vector; temp.class_vector];
features = [features; temp.features];
targets = [targets; temp.targets];
clear temp

%FUDGE for now to fix mistake with more than 4000 detritus examples
ii = strmatch('detritus', class_vector);
ii = ii(4001:end);
class_vector(ii) = [];
features(ii,:) = [];
targets(ii) = [];

class2skip = {'roundCell' 'other' 'crypto' 'other_interaction'};
[,ii] = ismember(class_vector, class2skip);
class_vector(ii) = [];
features(ii,:) = [];
targets(ii) = [];

[~,ia] = ismember(class_vector, class2use);
n_class = histc(ia', 1:length(class2use)); clear ia

ic = find(n_class > 1000);
[~,ia] = ismember(class_vector, class2use(ic));
ia = find(ia); %non-zero values

nTrees = 100;
paroptions = statset('UseParallel','always');

%make_TreeBaggerClassifier_user_training( result_path, train_filename, result_str, nTrees)
b = TreeBagger(nTrees,features(ia,:),class_vector(ia),'Method','c','OOBVarImp','on','MinLeaf',1,'Options',paroptions);

figure, hold on
plot(oobError(b), 'b-');
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');
datestring = datestr(now, 'ddmmmyyyy');

classes = class2use;

save([result_path result_str datestring],'b', 'targets', 'featitles', 'classes', '-v7.3')

classifier_oob_analysis( [result_path result_str datestring] )

validation = load([result_path 'validation_features_v2']);
trees = load([result_path result_str datestring]);
classes = trees.classes;
[ TBclass, TBscores] = predict(trees.b, validation.features);
[c1, gord1] = confusionmat(validation.class_vector,TBclass); %transposed from mine
total = sum(c1')';
maxn = max(total);
[TP TN FP FN] = conf_mat_props(c1);

Pd = TP./(TP+FN); %probability of detection
%Pr = 1-(sum(c1)-diag(c1)')./total'; %precision 1-FP/(TP+FP)
Pr = TP./(TP+FP); %precision = TP/(TP+FP) = diag(c1)./sum(c1)'
disp('overall error rate:')
disp(1-sum(TP)./sum(total))

text_offset = 0.1;

figure(6)
cplot = zeros(size(c1)+1);
cplot(1:length(classes),1:length(classes)) = c1;
%pcolor(log10(cplot))
pcolor(cplot)
set(gca, 'ytick', 1:length(classes), 'yticklabel', [])
text( -text_offset+ones(size(classes)),(1:length(classes))+.5, classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 0)
set(gca, 'xtick', 1:length(classes), 'xticklabel', [])
text((1:length(classes))+.5, -text_offset+ones(size(classes)), classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
axis square, colorbar, caxis([0 maxn])
title('Validation manual vs. classifier; score threshold = 0')
