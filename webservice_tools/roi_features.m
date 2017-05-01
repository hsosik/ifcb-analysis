function [ feavec, feanames ] = roi_features ( roi_url )

[namespace, roi_lid, ~] = fileparts(roi_url);
roi_url = [namespace '/' roi_lid];
features_url = [roi_url '_features.json'];

result = webread(features_url);

feanames = result.names;
feavec = result.values;

end
