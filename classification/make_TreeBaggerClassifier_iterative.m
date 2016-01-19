function [  ] = make_TreeBaggerClassifier_iterative( result_path, train_filename, result_str, nTrees, nRound )
%function [ ] = make_TreeBaggerClassifier_iterative( result_path, train_filename, result_str, nTrees, nRound )
%For example:
%   make_TreeBaggerClassifier_iterative( 'C:\work\IFCB\user_training_test_data\manual\summary\', 'UserExample_Train_06Aug2015', 'UserExample_Trees_', 100, 25)
% IFCB classification: create Random Forest classifier from training data,
% iteratively select which training examples to include
% Heidi M. Sosik, Woods Hole Oceanographic Institution, August 2015
%
%run compile_train_features_user_training.m first to store input results in train_filename
%Example inputs:
%result_path = 'C:\work\IFCB\user_training_test_data\manual\summary\'; %USER location to save the classifier
%train_filename = 'UserExample_Train_20Aug2015'; %USER what is the name of train set file (compiled features)
%nTrees = 100; %USER how many trees to grow in your classifier
%nRound = 25; %USER number of training examples from each class to consider per iteration

t = load([result_path train_filename]); 
%keyboard
%%temporary
class2skip = {'other' 'crypto'};
class2skip = [class2skip t.class2use(t.nclass<20)];
if exist('class2skip', 'var')
    [~,classnum2skip] = intersect(t.class2use, class2skip);
%    t.class2use(classnum2skip) = [];
%    t.nclass(classnum2skip) = [];
    ind2del = find(ismember(t.class_vector,classnum2skip));
    t.class_vector(ind2del) = [];
    t.train(ind2del,:) = [];
    t.targets(ind2del) = [];   
end
%%

%load fea2use
nclass = t.nclass;
class_vector = t.class_vector;
fea2use = 1:length(t.featitles);
featitles = t.featitles(fea2use);
datestring = datestr(now, 'ddmmmyyyy');
classes = t.class2use(find(nclass)); %only keep classes with non-zero n
%classes = t.class2use;
%sort training set
[class_vec_str,sort_ind] = sort(classes(class_vector));
train = t.train(sort_ind,:);
targets = t.targets(sort_ind);

paroptions = statset('UseParallel','always'); %enable parallel processing for tree growing

use_flag = zeros(size(class_vector));
%nmax = 150;
%nRound = 25; %number of examples to consider in each round
n2use_byclass = ones(size(classes))*nRound; %initialize total in use by class
h = figure;

%find the index lists by class, mark the first nRound to use in each class
%(unless not enough, in which case mark all available in class)
class_ind = NaN(max(nclass),length(nclass));
use_flag = zeros(size(class_ind));
for class_count = 1:length(classes),
    temp = find(class_vector == class_count);
    pind = randperm(length(temp));
    class_ind(1:length(pind),class_count) = temp(pind); %random permutation of indices for class
end
use_flag(1:nRound,:) = 1; %use the first nRound

ind4now = class_ind(find(use_flag)); %
ind4now = ind4now(~isnan(ind4now)); %get rid of the NaNs
disp('Round 1: Growing trees...please be patient')
b = TreeBagger(nTrees,train(ind4now,fea2use),class_vec_str(ind4now),'Method','c','OOBVarImp','on','MinLeaf',1,'Options',paroptions);
figure(h),clf, hold on, title('Round 1')
plot(oobError(b), 'b-'); ylim([0 1]); xlabel('Number of Grown Trees'); ylabel('Out-of-Bag Classification Error');
pause(1)

done_flag = 0;
rounds = ceil(max(nclass)/nRound);
for round_count = 2:rounds
    %consider the next round
    test_flag = zeros(size(use_flag));
    %test_flag((nRound*(round_count-1)+1):nRound*round_count,:) = 1;
    test_flag((nRound+1):min(nRound*round_count,max(nclass)),:) = 1;
    %run the previous round classifier to see what to keep
    ind4now = class_ind(find(test_flag)); %
    ind4now = ind4now(~isnan(ind4now)); %get rid of the NaNs
    [Yfit] = predict(b, train(ind4now,fea2use));
    test_ind = find(test_flag);
    mistake_ind = find(strcmp(Yfit, class_vec_str(ind4now)') == 0); 
    [~, ~, mind] = intersect(ind4now(mistake_ind), class_ind); 
    use_flag(mind) = 1;
    %n2use_byclass = sum(use_flag);
    %make the next classifier
    ind4now = class_ind(find(use_flag)); %
    ind4now = ind4now(~isnan(ind4now)); %get rid of the NaNs
    disp(['Round ' num2str(round_count)])
    disp('Growing trees...please be patient')
    b = TreeBagger(nTrees,train(ind4now,fea2use),class_vec_str(ind4now),'Method','c','OOBVarImp','on','MinLeaf',1,'Options',paroptions);
    figure(h),clf, hold on, title(['Round ' num2str(round_count)])
    plot(oobError(b), 'b-'); ylim([0 1]); xlabel('Number of Grown Trees'); ylabel('Out-of-Bag Classification Error');
    pause(1)
    keyboard
end

n2use_byclass = sum(use_flag);
disp(n2use_byclass)

[Yfit,Sfit,Sstdfit] = oobPredict(b);
[mSfit, ii] = max(Sfit');
for count = 1:length(mSfit), mSstdfit(count) = Sstdfit(count,ii(count)); tt(count)= Sfit(count,ii(count)); end; 
if isempty(find(mSfit-tt)), clear tt, else disp('check for error...'); end;
[c1, gord1] = confusionmat(b.Y,Yfit); %transposed from mine
clear t

classes = b.ClassNames;
maxaccu = NaN(1,length(classes));
maxthre = maxaccu;

for count = 1:length(classes),
    old_ind = strmatch(b.ClassNames(count), classes, 'exact');
    [fpr,accu,thr] = perfcurve(b.Y,Sfit(:,count), classes{old_ind},'ycrit','accu');
    [maxaccu(count),iaccu] = max(accu);
    maxthre(count) = thr(iaccu);
end;
clear count fpr tpr thr iaccu accu
datestring = datestr(now, 'ddmmmyyyy');

keyboard
save([result_path result_str datestring],'b', 'targets', 'featitles', 'classes', 'maxthre', '-v7.3')

classifier_oob_analysis( [result_path result_str datestring] )

end

%make_TreeBaggerClassifier_iterative( '\\sosiknas1\IFCB_products\MVCO\classifiers\', 'MVCO_train_04Nov2011_fromWebServices18Aug2015', 'MVCO_trees_test', 50)