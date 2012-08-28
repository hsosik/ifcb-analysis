function [ targets, image_dir ] = open_bin_file ( zip_path, dir )

[~, lid] = fileparts(zip_path);

if nargin < 2, dir = tempdir; end
dir = [dir filesep lid];
mkdir(dir);

% now unzip
unzip(zip_path, dir);

% now parse the .csv file to produce target output
csv_data = fileread([dir filesep lid '.csv']);

targets = csv2targets(csv_data);
image_dir = dir;

end

