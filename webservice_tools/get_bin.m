function [ targets ] = get_bin( pid )
% returns all target metadata and images from a bin.
% can take a long time, but afterwards all image data and metadata
% is available in the output structure.

warning off MATLAB:MKDIR:DirectoryExists

tmp = [tempdir filesep gen_id()];

mkdir(tmp);

[targets, tmp_dir, zip_path] = open_bin(pid, tmp);

try
  targets = read_unzipped_bin(targets, tmp_dir);
  close_bin(tmp_dir, zip_path);
catch ME
  close_bin(tmp_dir, zip_path);
  rethrow(ME)
end

end

