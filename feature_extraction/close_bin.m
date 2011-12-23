function [ ] = close_bin ( tmp_dir )
% clean up temporary storage associated with a bin

rmdir(tmp_dir,'s');

end

