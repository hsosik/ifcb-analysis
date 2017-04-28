function [ feavec, feanames ] = roi_features ( roi_url )

[dir, file, ~] = fileparts(roi_url);
roi_url = [dir '/' file];

roi_metadata = webread([roi_url '.json']);
bin_url = roi_metadata.binID;
roi_number = roi_metadata.targetNumber;
features_url = [bin_url '_features.csv'];

tmp = tempname;
fout = fopen(tmp,'w');
path = websave(tmp, features_url);
fclose(fout);
data = importdata(path);
feavecs = data.data;
feanames = data.colheaders;
[n_rois, ~] = size(feavecs);

for i=1:n_rois
    rn = feavecs(i,1);
    if rn == roi_number
        feavec = feavecs(i,:);
        return;
    end
end

end
