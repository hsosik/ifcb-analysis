function [ targets ] = get_bin( pid )
% returns all target metadata and images from a bin.
% can take a long time, but afterwards all image data and metadata
% is available in the output structure.

[targets, tmp_dir] = open_bin(pid);

ims = {};

for tix = 1:length(targets.pid),
    im = get_image(targets.pid(tix), tmp_dir);
    ims = [ims; im];
end
targets.image = ims;

close_bin(pid);

end

