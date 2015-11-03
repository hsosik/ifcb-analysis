
%run compile_train_features_TAMUG.m to generate train and class_vector
clear all
outputpath = 'C:\IFCB\manual\summary\'; %USER
load([outputpath 'TAMUG_Train_19Mar2015']); %USER
%load fea2use
fea2use = 1:length(featitles);
featitles = featitles(fea2use);
%ii = find(isnan(class_vector)); class_vector(ii) = [];targets(ii)= []; train(ii,:) = [];
datestring = datestr(now, 'ddmmmyyyy');
classes = class2use;
%sort training set
[class_vec_str,sort_ind] = sort(classes(class_vector));
train = train(sort_ind,:);
targets = targets(sort_ind);

%%class_vector = classes(class_vector);
disp('Growing trees...please be patient')
%b = TreeBagger(300,train,class_vector,'Method','c','OOBVarImp','on','MinLeaf',1);

%matlabpool
paroptions = statset('UseParallel','always');
%tic, b = TreeBagger(300,train,class_vector,'Method','c','OOBVarImp','on','MinLeaf',1,'Options',paroptions); toc
b = TreeBagger(100,train(:,fea2use),class_vec_str,'Method','c','OOBVarImp','on','MinLeaf',1,'Options',paroptions);
%matlabpool close
figure, hold on
plot(oobError(b), 'b-');
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');

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
 %[fpr,accu,thr] = perfcurve(b.Y,Sfit(:,count), num2str(count),'ycrit','accu');
    old_ind = strmatch(b.ClassNames(count), class2use, 'exact');
    [fpr,accu,thr] = perfcurve(b.Y,Sfit(:,count), class2use{old_ind},'ycrit','accu');
    [maxaccu(count),iaccu] = max(accu);
    maxthre(count) = thr(iaccu);
end;
clear count fpr tpr thr iaccu accu
datestring = datestr(now, 'ddmmmyyyy');

save([outputpath 'TAMUG_Trees_' datestring],'b', 'targets', 'featitles', 'classes', 'maxthre')

classifier_obb_analysis( [outputpath 'TAMUG_Trees_' datestring] )
