% file for messing around and testing stuff. - Joe Futrelle 9/2011

function [] = sandbox()

config = configure();

bins = list_bins(config.date);
bin = bins(1);
targets = get_targets(bin);

for tix = 1:length(targets.pid),
    target.config = config;
    target.img = get_image(targets.pid(tix));
    
    target = blob(target);
    target = blob_geomprop(target);
end;

end
