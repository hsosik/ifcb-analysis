
%run compile_train_features_RossSea.m to generate train and class_vector
clear all
outputpath = '\\sosiknas1\Lab_data\VPR\NBP1201\classifiers\';
load([outputpath 'NBP1201_train_vpr8_27Oct201530Oct2015']);
%load fea2use
[~,fea2use] = setdiff(featitles, {'FilledArea' 'summedFilledArea' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter', 'roi_number'}');
%fea2use = 1:length(featitles);
featitles = featitles(fea2use);
%ii = find(isnan(class_vector)); class_vector(ii) = [];targets(ii)= []; train(ii,:) = [];
datestring = datestr(now, 'ddmmmyyyy');
classes = class2use;
classes = class2use([2 6:7 9 11 13:14]); %'blurry_marSnow'    'phae2all'    'phaeIndiv'    'phaeMany'    'squashed'    'whiteout'
%sort training set
temp_class_vector = [2 6:7 9 11 13:14];
num_classes = length(temp_class_vector);
%n = 1:num_classes;
temp = [];
temp2 =[];
for n = 1:num_classes;
    ind = find(class_vector == temp_class_vector(n));
    temp =  [temp;(ind)];
    ind(:) = n;
    temp2= [temp2; ind];
   
end

class_vector = temp2;


[class_vec_str,sort_ind] = sort(classes(class_vector));
sort_ind = temp;
train = train(sort_ind,:);
targets = targets(sort_ind);

%%class_vector = classes(class_vector);
disp('Growing trees...please be patient')
%b = TreeBagger(300,train,class_vector,'Method','c','OOBVarImp','on','MinLeaf',1);

%matlabpool
paroptions = statset('UseParallel','always');
%tic, b = TreeBagger(300,train,class_vector,'Method','c','OOBVarImp','on','MinLeaf',1,'Options',paroptions); toc
b = TreeBagger(200,train(:,fea2use),class_vec_str,'Method','c','OOBVarImp','on','MinLeaf',1,'Options',paroptions);
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

%save([outputpath 'RossSea_Trees_wother' datestring],'b', 'targets', 'featitles', 'classes', 'maxthre')
save([outputpath 'RossSea_Trees_' datestring],'b', 'targets', 'featitles', 'classes', 'maxthre')

classifier_obb_analysis( [outputpath 'RossSea_Trees_' datestring] )
