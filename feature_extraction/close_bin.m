function [ ] = close_bin ( pid, dir )
% clean up temporary storage associated with a bin

if nargin < 2, dir = tempdir; end

dir = [dir filesep lid(pid)];

rmdir(dir,'s');

end

