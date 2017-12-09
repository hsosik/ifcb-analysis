function [ feavec, feanames ] = roi_features ( roi_url )

options = weboptions('Timeout',30);

[namespace, roi_lid, ~] = fileparts(roi_url);
roi_url = [namespace '/' roi_lid];
features_url = [roi_url '_features.json'];

result = webread(features_url, options);

feanames = result.names;
feavec = result.values;

end
