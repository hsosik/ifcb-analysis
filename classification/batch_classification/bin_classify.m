function [ ] = bin_classify( in_dir, file, out_dir, config)
%function [ ] = bin_classify( in_dir, file, out_dir )
%BIN_FEATURES Summary of this function goes here
%modified from bin_blobs
%Modified to incorporate biovolume computations (taken from bin_volume.m), Jan 2013
%Heidi M. Sosik, Woods Hole Oceanographic Institution

debug = false;

function log(msg) % not to be confused with logarithm function
    logmsg(['bin_features ' msg],debug);
end

% load the fea file
log(['LOAD ' file]);

[ feadata, feahdrs ] = get_fea_file([in_dir file]);
%find the indices that match input features to features used for classifier
[~,feaorder] = ismember(config.featitles, feahdrs);

if ~isempty(feadata),
roinum = feadata(:,1);
features = feadata(:,feaorder);
[ TBclass, TBscores] = predict(config.TBclassifier, features);

t = repmat(config.maxthre,length(TBclass),1);
win = (TBscores > t);
[i,j] = find(win);
TBclass_above_threshold = cell(size(TBclass));
TBclass_above_threshold(:) = deal(repmat({'unclassified'},1,length(TBclass)));
TBclass_above_threshold(i) = config.TBclassifier.ClassNames(j); %most are correct his way (zero or one case above threshold)
ind = find(sum(win')>1); %now go back and fix the conflicts with more than one above threshold
for count = 1:length(ind),
    %ii = find(win(ind(count),:));
    [~,ii] = max(TBscores(ind(count),:));
    TBclass_above_threshold(ind(count)) = config.TBclassifier.ClassNames(ii);
end;

outfile = regexprep(file, 'features', 'class_v1');
outfile = regexprep(outfile, 'fea_v3', 'class_v1'); %keep both lines to work for either case
outfile = regexprep(outfile, 'fea_v2', 'class_v1');
outfile = regexprep(outfile, '.csv', '');
%outfile = regexprep(outfile, 'v2', 'v1'); %TEMPORARY work around for v2 features, still v1 class files
class2useTB = config.class2useTB; classifierName = config.classifierName;
save([out_dir outfile], 'class2useTB', 'TBclass', 'roinum', 'TBscores', 'TBclass_above_threshold', 'classifierName')
log(['DONE ' outfile]);
else
log(['NO FEATURE DATA ' file]);    
end;

end

