function [ ] = make_TreeBaggerClassifier_user_training( result_path, train_filename, result_str, nTrees)
%function [ ] = make_TreeBaggerClassifier_user_training( result_path, train_filename, result_str, nTrees )
%For example:
%   make_TreeBaggerClassifier_user_training( 'C:\work\IFCB\user_training_test_data\manual\summary\', 'UserExample_Train_06Aug2015', 'UserExample_Trees_', 100)
% IFCB classification: create Random Forest classifier from training data
% Heidi M. Sosik, Woods Hole Oceanographic Institution, August 2015
%
%run compile_train_features_user_training.m first to store input results in train_filename
%Example inputs:
%result_path = 'C:\work\IFCB\user_training_test_data\manual\summary\'; %USER location of training file and classifier output
%train_filename = 'UserExample_Train_06Aug2015'; %USER what file contains your training features
%nTrees = 100; %USER how many trees in your forest; choose enough to reach asymptotic error rate in "out-of-bag" classifications

load([result_path train_filename]); 
%load fea2use
fea2use = 1:length(featitles);
featitles = featitles(fea2use);
datestring = datestr(now, 'ddmmmyyyy');
classes = class2use;
%sort training set
[class_vec_str,sort_ind] = sort(classes(class_vector));
train = train(sort_ind,:);
targets = targets(sort_ind);

disp('Growing trees...please be patient')
paroptions = statset('UseParallel','always');
b = TreeBagger(nTrees,train(:,fea2use),class_vec_str,'Method','c','OOBVarImp','on','MinLeaf',1,'Options',paroptions);

figure, hold on
plot(oobError(b), 'b-');
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');

%use code like this to add trees to an existing forest
%b = growTrees(b,100); %specify how many to add
%plot(oobError(b), 'g');

[Yfit,Sfit,Sstdfit] = oobPredict(b);
[mSfit, ii] = max(Sfit');
for count = 1:length(mSfit), mSstdfit(count) = Sstdfit(count,ii(count)); t(count)= Sfit(count,ii(count)); end; 
if isempty(find(mSfit-t)), clear t, else disp('check for error...'); end;
[c1, gord1] = confusionmat(b.Y,Yfit); %transposed from mine
clear t

classes = b.ClassNames;
maxaccu = NaN(1,length(classes));
maxthre = maxaccu;

for count = 1:length(classes),
    old_ind = strmatch(b.ClassNames(count), class2use, 'exact');
    [fpr,accu,thr] = perfcurve(b.Y,Sfit(:,count), class2use{old_ind},'ycrit','accu');
    [maxaccu(count),iaccu] = max(accu);
    maxthre(count) = thr(iaccu);
end;
clear count fpr tpr thr iaccu accu
datestring = datestr(now, 'ddmmmyyyy');

save([result_path result_str datestring],'b', 'targets', 'featitles', 'classes', 'maxthre')

disp('Classifier file stored here:')
disp([result_path result_str datestring])

classifier_oob_analysis( [result_path result_str datestring] )

end