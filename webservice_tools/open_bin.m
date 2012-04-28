function [ targets, image_dir, zip_path ] = open_bin ( pid, dir )
% download all data from a bin and stage it to a temporary directory.
% returns a structure with target metadata and images, and the directory
% containing the images.
% close_bin should be called after images
% are no longer needed, with the same arguments open_bin was called with.
%
% arguments:
% pid - the pid of the bin (e.g., http://ifcb-data.whoi.edu/IFCB5_2011_343_132713)
% dir - the dir to put the images in (if default, system temp dir is used)
% 
% note: this operation can take a long time, but afterwards access to
% the images and data is fast enough that it is a net savings of wall
% clock time

pid = char(pid);

if nargin < 2, dir = tempdir; end

image_dir = [dir filesep lid(pid)];

mkdir(image_dir);

zip_url = [pid '.zip'];
zip_path = [dir filesep lid(pid) '.zip'];

% fetch the zipfile. this can take a long time.
urlwrite(zip_url, zip_path);

targets= open_bin_file(zip_path, dir);

end

