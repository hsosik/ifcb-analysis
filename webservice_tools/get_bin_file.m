function [ targets ] = get_bin_file( zip_path )

[targets, tmp_dir] = open_bin_file(zip_path);

targets = read_unzipped_bin(targets, tmp_dir);

close_bin(tmp_dir);

end

