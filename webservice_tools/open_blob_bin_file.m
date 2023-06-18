function [ targets, image_dir ] = open_blob_bin_file ( zip_path, dir1 )

warning off MATLAB:MKDIR:DirectoryExists

[~, lid] = fileparts(zip_path);

if nargin < 2, dir1 = tempdir; end
dir1 = [dir1 filesep lid];
mkdir(dir1);

% now unzip
unzip(zip_path, dir1);

%get the list of local ids
temp = dir([dir1 filesep '*.png']);
temp = char(temp.name);
targets.pid = cellstr(temp(:,1:end-4));
% now parse the .csv file to produce target output
%csv_data = fileread([dir filesep lid '.csv']);
%
%targets = csv2targets(csv_data);
image_dir = dir1;

end

