% roibase = 'C:\work\IFCB\test_forEliseOlson\test_Aug2014_RossSea\trrois_VPR4Edit\';
% feapath = 'C:\work\IFCB\test_forEliseOlson\test_Aug2014_RossSea\features\';
% outputpath = 'C:\work\IFCB\test_forEliseOlson\test_Aug2014_RossSea\';
% load([outputpath 'RossSea_TrainSet_24Aug2014.mat'])

roibase = '\\sosiknas1\Lab_data\VPR\NBP1201\VPR8_train_20Sept2015_qc\';
feapath = '\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\features\';
outputpath = '\\sosiknas1\Lab_data\VPR\NBP1201\classifiers\';
load([outputpath 'RossSea_Trees_30Sep2015.mat'])

temp =char(targets);
roinumstr = temp(:,end-9:end);
roinumstr(strmatch(' ', roinumstr(:,1)),1) = '0';
config = config_classifier('\\sosiknas1\Lab_data\VPR\NBP1201\classifiers\RossSea_Trees_30Sep2015');
%config = config_classifier('C:\work\IFCB\test_forEliseOlson\test_Aug2014_RossSea\RossSea_Trees_24Aug2014');
classes = [config.TBclassifier.ClassNames; 'unclassified'];

[Yfit,Sfit,Sstdfit] = oobPredict(config.TBclassifier);
[mSfit, ii] = max(Sfit');
%apply the optimal threshold
t = repmat(config.maxthre,length(Yfit),1);
win = (Sfit > t);
[i,j] = find(win);
Yfit_max = NaN(size(Yfit));
Yfit_max(i) = j;
ind = find(sum(win')>1);
for count = 1:length(ind),
    %    ii = find(win(ind(count),:));
    [~,Yfit_max(ind(count))] = max(Sfit(ind(count),:));
end;
ind = find(isnan(Yfit_max));
Yfit_max(ind) = length(classes); %unclassified


%[ feadata, feahdrs ] = get_fea_file(['C:\work\IFCB\test_forEliseOlson\test_Aug2014_RossSea\features\' 'other_fea_v2.csv']);
[ feadata, feahdrs ] = get_fea_file(['\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\features\' 'other_fea_v2.csv']);
%find the indices that match input features to features used for classifier
[~,feaorder] = ismember(config.featitles, feahdrs);
features = feadata(:,feaorder);
[ TBclass, TBscores] = predict(config.TBclassifier, features);
[ class_out ] = apply_TBthreshold( config.class2useTB, TBscores ,config.maxthre );

maxscore = [mSfit, max(TBscores')];

%concatenate oob with predict on 'other'
roinumstr = [roinumstr; num2str(feadata(:,1), '%010.0f')];
manual_class = [config.TBclassifier.Y; repmat({'unclassified'}, length(class_out),1)];
auto_class = [classes(Yfit_max); class_out'];

[~,auto_class_num] = ismember(auto_class,classes); 
[~,manual_class_num] = ismember(manual_class,classes); 


%adhocthresh = .45;
subnum = 0;
for classcount = 1:length(classes)-1,
    disp(['Manual class:' classes(classcount)])
    ii = find(manual_class_num == classcount & auto_class_num ~= classcount);
    %[maxscore, winclass] = max(TBscores'); %Winclass is the classes that are the best classes from the Randomforest algorithm
    %ii = find(class_out_num ~= classcount & class_out_num ~= 0); %& manual_class_num==count);
    if ~isempty(ii),
        %keyboard
        for num = 1:length(ii),
            subnum = subnum + 1;
            subplot(5,2,subnum)
            roi_id = ['roi0.' roinumstr(ii(num),:) '.tif'];
            img = imread([roibase filesep classes{manual_class_num(ii(num))} filesep roi_id]);
            imshow(img), title([char(roi_id) '; score = ' num2str(maxscore(ii(num)), '%.2f') ' ' auto_class{ii(num)}], 'interpreter', 'none')
            if subnum == min(10,length(ii)),
                pause
                clf
                subnum = 0;
            end;
        end;
    end;
    clf
    subnum = 0;
end;
subnum = 0;
for classcount = length(classes),
    disp(['Manual class:' classes(classcount)])
    ii = find(manual_class_num == classcount & auto_class_num ~= classcount);
    %[maxscore, winclass] = max(TBscores'); %Winclass is the classes that are the best classes from the Randomforest algorithm
    %ii = find(class_out_num ~= classcount & class_out_num ~= 0); %& manual_class_num==count);
    if ~isempty(ii),
        %keyboard
        for num = 1:length(ii),
            subnum = subnum + 1;
            subplot(5,2,subnum)
            roi_id = ['roi0.' roinumstr(ii(num),:) '.tif'];
            img = imread([roibase filesep 'other' filesep roi_id]);
            imshow(img), title([char(roi_id) '; score = ' num2str(maxscore(ii(num)), '%.2f') ' ' auto_class{ii(num)}], 'interpreter', 'none')
            if subnum == min(10,length(ii)),
                pause
                clf
                subnum = 0;
            end;
        end;
    end;
    clf
    subnum = 0;
end;

