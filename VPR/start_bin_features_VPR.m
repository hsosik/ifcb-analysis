function [ ] = start_bin_features_VPR (day_in_path, blob_in_path, fea_out_path, parflag)
%function [ ] = start_bin_features_VPR (day_in_path, blob_in_path, fea_out_path, parflag)
%example: start_bin_features_VPR ('\\SosikNAS1\Lab_data\VPR\vpr3\', '\\SosikNAS1\Lab_data\VPR\vpr3\blobs\', '\\SosikNAS1\Lab_data\VPR\vpr3\features\')
% produce IFCB style feature files for VPR images (after blob production),
% assumes tiff files organized in folders by day, then hour
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2014

%default parallel processing off
if ~exist('parflag', 'var')
    parflag = 0;
end;

bins = dir([blob_in_path '*.zip']);
bins = regexprep({bins.name}', '.zip', '');

bloblist = fullfile(blob_in_path, bins);
fealist = fullfile(fea_out_path, bins);
%multi_path = [out_dir 'multiblob' filesep];
fealist_multi = fullfile(fea_out_path, 'multiblob', bins);
junk = char(bins);
hrlist = fullfile(day_in_path, cellstr(junk(:,1:4)), cellstr(junk(:,5:7))); clear junk

if ~exist(fea_out_path, 'dir'),
    mkdir(fea_out_path)
    mkdir([fea_out_path 'multiblob' filesep])
end;

if parflag
    try
        mypool = parpool('IdleTimeout', 360);
        disp('POOL - started');
    catch e %#ok<NASGU>
        disp('WARNING - workers cannot start, or already active');
    end;
end;

if parflag
    parfor bincount = 1:length(hrlist)
        if ~exist([fealist{bincount} '_fea_v3.csv'], 'file')
            bin_features_VPR(hrlist{bincount}, bloblist{bincount}, fealist(bincount), fealist_multi(bincount));
        else
            disp([fealist{bincount} ' already done'])
        end;   
    end
else
    for bincount = 1:length(hrlist)
        if ~exist([fealist{bincount} '_fea_v3.csv'], 'file')
            bin_features_VPR(hrlist{bincount}, bloblist{bincount}, fealist(bincount), fealist_multi(bincount));
        else
            disp([fealist{bincount} ' already done'])
        end;   
    end
end;

if parflag
    delete(mypool)
end;

end

