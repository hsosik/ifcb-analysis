function [ ] = close_bin ( tmp_dir, zip_path )
% clean up temporary storage associated with a bin

rmdir(tmp_dir,'s');

if nargin > 1,
    delete(zip_path);
end

end

