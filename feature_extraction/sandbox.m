% file for messing around and testing stuff. - Joe Futrelle 9/2011

function [] = sandbox()

bins = list_bins('now');
bin = bins(1);
targets = get_targets(bin);


for tix = 1:length(targets.pid),
    img = get_image(targets.pid(tix));
    subplot(1,2,1), imshow(img);
    subplot(1,2,2), imshow(blob(img));
    pause
end;

end
