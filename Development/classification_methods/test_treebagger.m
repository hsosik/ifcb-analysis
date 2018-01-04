
result_path = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017\splits\';
train_filename = 'train_features_v2';
result_str = 'trees_features_v2_'
nTrees = 50;
paroptions = statset('UseParallel','always');

load([result_path train_filename]);
%make_TreeBaggerClassifier_user_training( result_path, train_filename, result_str, nTrees)
b = TreeBagger(nTrees,features,class_vector,'Method','c','OOBVarImp','on','MinLeaf',1,'Options',paroptions);

figure, hold on
plot(oobError(b), 'b-');
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');
datestring = datestr(now, 'ddmmmyyyy');

classes = class2use;
save([result_path result_str datestring],'b', 'targets', 'featitles', 'classes', '-v7.3')

classifier_oob_analysis( [result_path result_str datestring] )

validation = load([result_path 'validation_features_v2']);
trees = load([result_path result_str '29Dec2017']);
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
