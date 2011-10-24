% file for messing around and testing stuff. - Joe Futrelle 9/2011

function [output] = sandbox()

config = configure();

bins = list_bins(config.date);
bin = bins(1);
target_ids = get_targets(bin);
target.config = config;
%target = add_field(target, 'blob_props');
output.config = config;
output.targets = target_ids.pid;

for tix = 1:20, %length(target_ids.pid),
    target.img = get_image(target_ids.pid(tix));
    target = blob(target);
    target = blob_geomprop(target);
    output.features(tix) = target.blob_props;
end;

end
