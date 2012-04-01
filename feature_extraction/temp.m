%get output from compile_train_features2 first
%[coeff,score,latent] = princomp(feamat');

a = strmatch('Area', featitles, 'exact'); b = strmatch('Perimeter', featitles, 'exact'); 
train = [train; train(a,:)./train(b,:).^2; train(a,:)./train(b,:)]; %A/P^2 compactness or circularity index; A/P roundness index
featitles = [featitles; 'Area/Perimeter^2'; 'Area/Perimeter'];

a = strmatch('Hflip', featitles, 'exact'); b = strmatch('H90', featitles, 'exact'); c = strmatch('H180', featitles, 'exact'); 
train = [train; train(b,:)./train(a,:); train(b,:)./train(c,:); train(a,:)./train(c,:)]; %A/P^2 compactness or circularity index; A/P roundness index
featitles = [featitles; 'H90/Hflip'; 'H90/H180'; 'Hflip/H180'];

a = strmatch('summedConvexPerimeter', featitles, 'exact'); b = strmatch('summedPerimeter', featitles, 'exact'); 
train = [train; train(a,:)./train(b,:).^2]; %A/P^2 compactness or circularity index; A/P roundness index
featitles = [featitles; 'summedConvexPerimeter/Perimeter'];

a = strmatch('RotatedBoundingBox_xwidth', featitles, 'exact'); b = strmatch('RotatedBoundingBox_ywidth', featitles, 'exact'); c = strmatch('RotatedArea', featitles, 'exact'); 
train = [train; train(c,:)./(train(a,:).*train(b,:))]; %solidity of rotated bounding box
featitles = [featitles; 'rotated BoundingBox solidity'];

train(isnan(train)) = 0;
[~,i] = setdiff(featitles, {'FilledArea' 'summedFilledArea' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter'}');
%[~,i] = setdiff(featitles(1:40), {'FilledArea' 'summedFilledArea' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter'}');

train_temp = train(i,1:2:end)';
class_vector_temp = class_vector(1:2:end);

[~,i2] = setdiff(featitles, {'FilledArea' 'summedFilledArea' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter' 'Hflip' 'H90' 'H180' 'H90/Hflip' 'Hflip/H180'}');
train_temp2 = train(i,1:2:end)';

i3 = setdiff((1:length(featitles)), [strmatch('Ring', featitles); strmatch('Wedge', featitles); strmatch('RW', featitles)]); 
train_temp3 = train(i,1:2:end)';

i4 = setdiff((1:length(featitles)), [strmatch('HOG', featitles)]); 
train_temp4 = train(i,1:2:end)';

boxplot(train(43,:), class_vector)

[coefs,scores,variances,t2] = princomp(zscore(train_temp));
cumsum(variances)./sum(variances)
figure, biplot(coefs(:,1:3),'Scores',scores(:,1:3),'VarLabels', featitles(i))

percent_explained = 100*variances/sum(variances);
figure, pareto(percent_explained), xlabel('Principal Component'), ylabel('Variance Explained (%)')


Y = pdist(train_temp,'euclid');
Z = linkage(Y,'single');
T = clusterdata(zscore(train_temp),10);

PN = mapstd(train_temp')';
%mapstd scaling seems to give better performance with cross-validation...is this generally true for our data?
%PN = mapminmax(train_temp',-1,1)'; 
trainSample = [PN class_vector'];
beta = 2;
[selectedFeature]=FSDD(trainSample,size(PN,2),beta);
%featitles(i(selectedFeature))
numfea = size(PN,2);
cv = NaN(1,numfea);
for num2select = 3:5:numfea-5, %10:10:200, %1:10:numfea,
    disp(num2select)
    Samples = PN(:,selectedFeature(1:num2select)); Labels = class_vector';
    cv(num2select) = libsvmtrain(Labels, Samples, '-s 0 -c 10.07 -g .0049 -b 1 -v 5 -q');
    figure(1), plot(1:numfea,cv, '.-')
end;



%SVM-RBF Parameter Selection
PN = mapstd(train_temp')';
%PN = mapminmax(train_temp',-1,1)';
trainSample = [PN class_vector_temp'];
beta = 2;
[selectedFeature]=FSDD(trainSample,size(PN,2),beta);
numfea = size(PN,2);
num2select = numfea;
Samples = PN(:,selectedFeature(1:num2select)); Labels = class_vector_temp';
cvec = 2.^[-5:4:15]; gvec = 1;
%gvec = 2.^[-15:4:3];
%cvec = 2.^[12:2:18];
%gvec = 2.^[-15:2:-7];
%cvec = 2.^[16:2:23];
%gvec = 2.^[-15:1:-11];
cv = NaN(length(cvec), length(gvec));
for ind1 = 1:length(cvec),
%    for ind2 = 1:length(gvec),
        %optionstr = ['-s 0 -c ' num2str(cvec(ind1)) ' -g ' num2str(gvec(ind2)) ' -b 1 -v 5 -q'];
        %cv(ind1,ind2) = libsvmtrain(Labels, Samples, optionstr)
        optionstr = ['-s 0 -t 0 -c ' num2str(cvec(ind1)) ' -b 1 -v 5 -q'];
        cv(ind1) = libsvmtrain(Labels, Samples, optionstr)
%    end;
end;



ens = fitensemble(train_temp,class_vector_temp,'AdaBoostM2',100,'Tree')
L = resubLoss(ens)

bag = fitensemble(train_temp,class_vector_temp,'Bag',200,'Tree','type','classification')
Xtest = train(i,2:2:end)';
Ytest = class_vector(2:2:end);
figure;
plot(loss(bag,Xtest,Ytest,'mode','cumulative'));
xlabel('Number of trees');
ylabel('Test classification error');

%cv = fitensemble(X,Y,'Bag',200,'Tree','type','classification','kfold',5)
cv = fitensemble(train_temp,class_vector_temp,'Bag',100,'Tree','type','classification','kfold',5)

figure;
plot(loss(bag,Xtest,Ytest,'mode','cumulative'));
hold
plot(kfoldLoss(cv,'mode','cumulative'),'r.');
plot(oobLoss(bag,'mode','cumulative'),'k--');
hold off;
xlabel('Number of trees');
ylabel('Classification error');
legend('Test','Cross-validation','Out of bag','Location','NE');

leaf = [1 5 10 20 50 100];
col = 'rgbcmy';
figure(1);
for i=1:length(leaf)
    b = TreeBagger(50,train_temp,class_vector_temp,'method','c','oobpred','on','minleaf',leaf(i));
    plot(oobError(b),col(i));
    hold on;
end
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');
legend({'1' '5' '10' '20' '50' '100'},'Location','NorthEast');
hold off;

b = TreeBagger(100,train_temp,class_vector_temp,'Method','c','OOBVarImp','on','MinLeaf',1);
figure(2);
plot(oobError(b));
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');

	
figure(3);
plot(oobError(b));
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Error Excluding in-Bag Observations');

figure(3);
bar(b.OOBPermutedVarDeltaError);
xlabel('Feature Number');
ylabel('Out-Of-Bag Feature Importance');
%idxvar = find(b.OOBPermutedVarDeltaError>1.75)
[~,idxvar] = sort(b.OOBPermutedVarDeltaError, 'descend');
featitles(i(idxvar(1:20)))

figure
plot(oobMeanMargin(b2), 'r')
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Mean Classification Margin');
b2 = fillProximities(b2);
figure, hist(b2.OutlierMeasure);
xlabel('Outlier Measure');
ylabel('Number of Observations');

b2.Y(b2.OutlierMeasure>100)
find(b2.OutlierMeasure>100)
[~,idx] = sort([b2.OOBPermutedVarDeltaError], 'descend');

train_temp4 = train(i(idx(1:20)),1:2:end)';
b4 = TreeBagger(250,train_temp4,class_vector_temp,'Method','c','MinLeaf',1);

figure
b5 = fillProximities(b5);
[s,e] = mdsProx(b5,'colors','rb');
xlabel('1st Scaled Coordinate');
ylabel('2nd Scaled Coordinate');

figure
bar(e(1:20));
xlabel('Scaled Coordinate Index');
ylabel('Eigenvalue');

[Yfit,Sfit] = oobPredict(b5);
[fpr,tpr] = perfcurve(b5.Y,Sfit(:,1));
figure
plot(fpr,tpr);
xlabel('False Positive Rate');
ylabel('True Positive Rate')

Ypred = predict(b5,Xtest);
for c = 1:length(Ypred),
    Ypredn(c) = str2num(Ypred{c});
end;

conf_matrix = zeros(length(classes),length(classes));
conf_matrix_proportion = conf_matrix;
for count = 1:length(classes),
    %    total = length(find(PreLabels(:,1) == count));
    total = length(find(Ytest == count));
    for count2 = 1:length(classes),
        c = length(find(Ytest == count2 & Ypredn == count));
        conf_matrix_proportion(count,count2) = c/total;
        conf_matrix(count,count2) = c;
    end;
end;
conf_matrix_proportion(isinf(conf_matrix_proportion)) = NaN;

c = confusionmat(Ytest,Ypredn); %transposed from mine

%%%%%%%%%%%%
a = strmatch('Area', featitles, 'exact'); b = strmatch('Perimeter', featitles, 'exact'); 
train = [train; train(a,:)./train(b,:).^2; train(a,:)./train(b,:)]; %A/P^2 compactness or circularity index; A/P roundness index
featitles = [featitles; 'Area/Perimeter^2'; 'Area/Perimeter'];

a = strmatch('Hflip', featitles, 'exact'); b = strmatch('H90', featitles, 'exact'); c = strmatch('H180', featitles, 'exact'); 
train = [train; train(b,:)./train(a,:); train(b,:)./train(c,:); train(a,:)./train(c,:)]; %A/P^2 compactness or circularity index; A/P roundness index
featitles = [featitles; 'H90/Hflip'; 'H90/H180'; 'Hflip/H180'];

a = strmatch('summedConvexPerimeter', featitles, 'exact'); b = strmatch('summedPerimeter', featitles, 'exact'); 
train = [train; train(a,:)./train(b,:).^2]; %A/P^2 compactness or circularity index; A/P roundness index
featitles = [featitles; 'summedConvexPerimeter/Perimeter'];

a = strmatch('RotatedBoundingBox_xwidth', featitles, 'exact'); b = strmatch('RotatedBoundingBox_ywidth', featitles, 'exact'); c = strmatch('RotatedArea', featitles, 'exact'); 
train = [train; train(c,:)./(train(a,:).*train(b,:))]; %solidity of rotated bounding box
featitles = [featitles; 'rotated BoundingBox solidity'];

train(isnan(train)) = 0;
[~,i] = setdiff(featitles, {'FilledArea' 'summedFilledArea' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter'}');
%i = setdiff((1:length(featitles)), [strmatch('Ring', featitles); strmatch('Wedge', featitles); strmatch('RW', featitles)]); 
%train_temp = train(i,1:2:end)';
%class_vector_temp = classes(class_vector(1:2:end));
train_temp = train(i,:)';
class_vector_temp = classes(class_vector);
clear a b c i

b3 = TreeBagger(300,train_temp,class_vector_temp,'Method','c','OOBVarImp','on','MinLeaf',1);
figure(2), hold on
plot(oobError(b3), 'b-');
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');
[~,idxvar] = sort(b3.OOBPermutedVarDeltaError, 'descend');
featitles(i(idxvar(1:50)))

b4 = TreeBagger(400,train_temp(:,idxvar(1:50)),class_vector_temp','Method','c','oobpred', 'on', 'MinLeaf',1);
hold on
plot(oobError(b4), 'y');

b3 = growTrees(b3,250); %specify how many to add
plot(oobError(b3), 'g');

[Yfit,Sfit] = oobPredict(b3);  %[Yfit,scores,stdevs] = predict(b2,Xunknown);
%b2 = fillProximities(b2);
%[s,e] = mdsProx(b2);


figure, hold on
for count = 1:length(classes),
 %[fpr,tpr,thr] = perfcurve(b3.Y,Sfit(:,count), classes{count});
 [fpr,tpr,thr] = perfcurve(b3.Y,Sfit(:,count), classes{count});
  subplot(2,1,1), ph = plot(fpr,tpr, 'r');
  title(classes(count)), xlabel('False pos rate'), ylabel('True pos rate')
  %[fpr,accu,thr] = perfcurve(b3.Y,Sfit(:,count), classes{count},'ycrit','accu');
  [fpr,accu,thr] = perfcurve(b3.Y,Sfit(:,count), classes{count},'ycrit','accu');
  subplot(2,1,2), hold off, ph2 = plot(thr,accu, 'g'); 
  hold on, ph3 = plot(thr, fpr, 'r'); legend('accuracy', 'false pos rate')
  set(ph, 'color', 'k')
  [maxaccu(count),iaccu] = max(accu);
  maxthre(count) = thr(iaccu);
%  pause
end;

t = repmat(maxthre,length(class_vector_temp),1);
win = (Sfit > t);
[i,j] =find(win);
Yfit_max = NaN(size(class_vector_temp));
Yfit_max(i) = j;
ind = find(sum(win')>1);
for count = 1:length(ind),
    ii = find(win(ind(count),:));
    [~,Yfit_max(ind(count))] = max(Sfit(ind(count),:));
end;

ind = find(~isnan(Yfit_max));
c2 = confusionmat(b3.Y(ind),classes(Yfit_max(ind)));
total = sum(c2')';
Pd = diag(c2)./total;
Sp = 1-(sum(c2)-diag(c2)')./total';
sum(sum(c2)-diag(c2)')/sum(total)
Pm = (sum(c1')-sum(c2'))./sum(c1');
figure, bar([Pd Sp' Pm])


num_correct = length(find(class_vector==Yfit_max))
num_nanincorrect = length(find(class_vector~=Yfit_max))
num_nan = length(find(isnan(Yfit_max)))
num_wrong = num_nanincorrect-num_nan
acc = num_correct./(num_correct+num_wrong)
unk_rate = num_nan./(num_correct+num_nanincorrect)
sum(c')-sum(c2') %num unknown per 

[fpr,accu,thre] = perfcurve(b2.Y,Sfit(:,1),classes{1},'ycrit','accu');
figure(20);
plot(thre,accu);
xlabel(['Threshold for ' classes{1} ' Returns']);
ylabel('Classification Accuracy');

c1 = confusionmat(b3.Y,Yfit); %transposed from mine
total = sum(c1')';
Pd = diag(c1)./total;
Sp = 1-(sum(c1)-diag(c1)')./total';
sum(sum(c1)-diag(c1)')/sum(total)
bar([total diag(c1) sum(c1)'-diag(c1)])
figure, bar([Pd Sp'])

[P,ind] = max(Sfit');
cind = find(strcmp(Yfit,class_vector_temp'));
mind = find(~strcmp(Yfit,class_vector_temp'));
figure
subplot(3,1,1), boxplot(P,ind)
subplot(3,1,2), boxplot(P(cind),ind(cind))
subplot(3,1,3), boxplot(P(mind),ind(mind))

cind1 = find(strcmp(Yfit,class_vector_temp') & strcmp(classes(17), Yfit));
mind1 = find(~strcmp(Yfit,class_vector_temp') & strcmp(classes(17), Yfit));
h1 = hist(P(cind1), [0:.1:1]);
h2 = hist(P(mind1), [0:.1:1]);
figure
bar([0:.1:1]', [h1; h2]')



