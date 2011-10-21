% file for messing around and testing stuff. - Joe Futrelle 9/2011

function [] = sandbox()

bins = list_bins('now');
%bins = list_bins('2010-10-10T11:07:16Z');
bin = bins(1);
targets = get_targets(bin);

prop_list = {'Area', 'ConvexArea', 'Eccentricity', 'EquivDiameter', 'Extent', 'FilledArea', 'MajorAxisLength', ...
    'MinorAxisLength', 'Orientation', 'Perimeter', 'Solidity'};%FIXME user choices?

for tix = 1:length(targets.pid),
    img = get_image(targets.pid(tix));
    img_blob = blob(img);    
    %NOTE this breaks right now as soon as there is more than one connected blob in img_blob
    geomprops(tix) = blob_geomprop(img_blob, prop_list);
end;

end
