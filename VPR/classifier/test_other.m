config = config_classifier('C:\work\IFCB\test_forEliseOlson\test_Aug2014_RossSea\RossSea_Trees_23Aug2014');

[ feadata, feahdrs ] = get_fea_file(['C:\work\IFCB\test_forEliseOlson\test_Aug2014_RossSea\features\' 'other_fea_v2.csv']);
%find the indices that match input features to features used for classifier
[~,feaorder] = ismember(config.featitles, feahdrs);

roinum = feadata(:,1);
features = feadata(:,feaorder);
[ TBclass, TBscores] = predict(config.TBclassifier, features);

[ class_out ] = apply_TBthreshold( config.class2useTB, TBscores ,config.maxthre );