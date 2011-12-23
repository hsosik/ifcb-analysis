function [ targets ] = read_unzipped_bin( targets, tmp_dir )

ims = {};

for tix = 1:length(targets.pid),
    im = get_image(targets.pid(tix), tmp_dir);
    ims = [ims; im];
end
targets.image = ims;

end

