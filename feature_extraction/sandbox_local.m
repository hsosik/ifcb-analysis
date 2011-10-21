% file for messing around and testing stuff. - Joe Futrelle 9/2011

function [] = sandbox()

%bins = list_bins('now');
%bins = list_bins('2010-10-10T11:07:16Z');
%bin = bins(1);
%targets = get_targets(bin);
%local_path = 'C:\work\IFCB\IFCB1_2011_294_114650_stitchresults\IFCB1_2011_294_114650\';
local_path = 'C:\work\IFCB\IFCB1_2011_282_235113_stitchresults\IFCB1_2011_282_235113\';
targets = dir([local_path '*.png']);

for tix = 1:length(targets),
    %disp(tix)
    %img = get_image(targets.pid(tix));
    img = imread([local_path targets(tix).name]);
    img_blob = blob(img);
    geomprops = blob_geomprop(img_blob);
    %pause
end;

end
