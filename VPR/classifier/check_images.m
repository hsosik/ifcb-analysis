roibase = 'C:\work\IFCB\test_forEliseOlson\test_Aug2014_RossSea\trrois_VPR4Edit\';
feapath = 'C:\work\IFCB\test_forEliseOlson\test_Aug2014_RossSea\features\';

filelist = dir([feapath '*fea_v2.csv']);
config = config_classifier('C:\work\IFCB\test_forEliseOlson\test_Aug2014_RossSea\RossSea_Trees_23Aug2014');
classes = regexprep({filelist.name}', '_fea_v2.csv', '');
for classcount = 1:length(filelist),
disp(['Manual: ' classes(classcount)])
[ feadata, feahdrs ] = get_fea_file(['C:\work\IFCB\test_forEliseOlson\test_Aug2014_RossSea\features\' filelist(classcount).name]);
%find the indices that match input features to features used for classifier
[~,feaorder] = ismember(config.featitles, feahdrs);

roinum = feadata(:,1);
features = feadata(:,feaorder);
[ TBclass, TBscores] = predict(config.TBclassifier, features);

[ class_out ] = apply_TBthreshold( config.class2useTB, TBscores ,config.maxthre );
 
[~,class_out_num] = ismember(class_out,classes); 
%adhocthresh = .45;
subnum = 0;
[maxscore, winclass] = max(TBscores'); %Winclass is the classes that are the best classes from the Randomforest algorithm
    %ii = find(class_out_num ~= classcount & class_out_num ~= 0); %& manual_class_num==count);
    ii = find(class_out_num == 0); %& manual_class_num==count);
    if ~isempty(ii),
        %keyboard
        for num = 1:length(ii),
            subnum = subnum + 1;
            subplot(5,2,subnum)
            roi_id = ['roi0.' num2str(feadata(ii(num),1), '%010.0f') '.tif'];
            img = imread([roibase filesep classes{classcount} filesep roi_id]);
            imshow(img), title([char(roi_id) '; score = ' num2str(maxscore(ii(num)), '%.2f') ' ' config.class2useTB{winclass(ii(num))}], 'interpreter', 'none')
            if subnum == min(10,length(ii)),
                pause
                clf
                subnum = 0;
            end;
        end;
    end;
end;