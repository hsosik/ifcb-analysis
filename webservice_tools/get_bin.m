function [ targets ] = get_bin( pid )
% returns all target metadata and images from a bin.
% can take a long time, but afterwards all image data and metadata
% is available in the output structure.

[targets, tmp_dir] = open_bin(pid);

targets = read_unzipped_bin(targets, tmp_dir);

close_bin(tmp_dir);

end

