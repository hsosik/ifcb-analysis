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
empty_target = target;

for tix = 1:length(target_ids.pid),
    disp(tix)
    target = empty_target; %re-initialize each time through
    target.image = get_image(target_ids.pid(tix));
    target = blob(target);
    target = blob_geomprop(target); 
    target = blob_texture(target);
    target = blob_invmoments(target);
    target = blob_sumprops(target); 
    output.features(tix) = target.blob_props;
end;

end

%feamat = struct2cell(output.features);
%feamat = cell2mat(squeeze(feamat)');
%featitles = fields(output.features)';