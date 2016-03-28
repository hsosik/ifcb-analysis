function [ feature_mat, featitles, multiblob_features, multiblob_titles ] = make_feature_matrices( out )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

roinum = char([out.pid]);
roinum = str2num(roinum(:,end-4:end));

ii = find([out.features.numBlobs] > 1);
tempfea = out.features(ii);
%make list properly repeated roi numbers
n = [tempfea.numBlobs];
roinum_multi = [];
for count = 1:length(ii), 
    roinum_multi = [roinum_multi [repmat(roinum(ii(count)),1,n(count)); 1:n(count)];];
end;
%omit fields that don't apply to separate blobs
names = fields(tempfea);
ind = strmatch('summed', names);
tempfea = rmfield(tempfea, names(ind));
ind = strmatch('RW', names);
tempfea = rmfield(tempfea, names(ind));
ind = strmatch('moment_invariant', names);
tempfea = rmfield(tempfea, names(ind));
ind = strmatch('texture_', names);
tempfea = rmfield(tempfea, names(ind));
tempfea = rmfield(tempfea, {'HOG', 'Wedges', 'Rings', 'numBlobs'});
multiblob_features = [roinum_multi; cell2mat(squeeze(struct2cell(tempfea)))]';
multiblob_titles = ['roi_number' 'blob_number' fields(tempfea)'];

%all features in compiled version (summed or largest in case of multiple blobs
[ feature_mat, featitles ] = format_features( out );
[ feature_mat, featitles ] = add_derived_features( feature_mat, featitles);
feature_mat = [roinum feature_mat'];
featitles = ['roi_number' featitles'];

end

