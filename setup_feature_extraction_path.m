function setup_feature_extraction_path()
repo = fileparts(mfilename('fullpath'));

addpath(genpath(fullfile(repo, 'feature_extraction')));
addpath(fullfile(repo, 'IFCB_tools'));
addpath(fullfile(repo, 'webservice_tools'));
end
