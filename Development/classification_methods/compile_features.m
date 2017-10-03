%p = 'C:\work\IFCB\Manual_fromClass\train_fromcsv_Sep2017\train_validation_split\';
p = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017\test_validation_split\';

l = dir([p '*_train.mat']);
l = {l.name};
class2use = regexprep(l, '_train.mat', '')';

train = [];
targets = [];
class_vector = [];
validation = [];
vtargets = [];
vclass_vector = [];
testing = [];
ttargets = [];
tclass_vector = [];

for count = 1:length(l)
    t = load([p l{count}]);
    train = [train; t.train];
    targets = [targets; t.trtargets];
    class_vector = [class_vector; repmat(count,length(t.trtargets),1)];
    validation = [validation; t.validation];
    vtargets = [vtargets; t.vtargets];
    vclass_vector = [vclass_vector; repmat(count,length(t.vtargets),1)]; 
    %testing = [testing; t.testing];
    ttargets = [ttargets; t.ttargets];
    tclass_vector = [tclass_vector; repmat(count,length(t.ttargets),1)];  
    nclass(count) = length(t.trtargets);
    vnclass(count) = length(t.vtargets);
    tnclass(count) = length(t.ttargets);
end
featitles = t.featitles;
clear l count t
[~,i] = setdiff(featitles, {'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter', 'roi_number'}');
featitles = featitles(i);
train = train(:,i); validation = validation(:,i);
[~,i] = setdiff(featitles, {'shapehist_kurtosis_normEqD' 'shapehist_mean_normEqD' 'shapehist_median_normEqD' 'shapehist_skewness_normEqD'...
    'H90' 'H90_over_Hflip' 'H90_over_H180' 'H180' 'Hflip' 'Hflip_over_H180'}');
featitles = featitles(i);
train = train(:,i); validation = validation(:,i);
a = strmatch('B90', featitles); b = strmatch('B180', featitles); c = strmatch('Bflip', featitles);
featitles = [featitles 'B90_over_B180' 'B90_over_Bflip' 'Bflip_over_B180'];
train = [train train(:,a)./train(:,b) train(:,a)./train(:,c) train(:,c)./train(:,b)];
validation = [validation validation(:,a)./validation(:,b) validation(:,a)./validation(:,c) validation(:,c)./validation(:,b)];
clear i a b c 
save([p 'train_split'])

return

result_path = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017\test_validation_split\';
train_filename = 'train_split';
result_str = 'train_splitTrees'
nTrees = 100;

make_TreeBaggerClassifier_user_training( result_path, train_filename, result_str, nTrees)

load([result_path 'train_split']);
trees = load([result_path 'train_splitTrees29Sep2017']);
classes = trees.classes;
[ TBclass, TBscores] = predict(trees.b, validation);
[c1, gord1] = confusionmat(class2use(vclass_vector),TBclass); %transposed from mine
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
