function [ img ] = get_image( pid, image_dir )
% given a PID such as
% http://ifcb-data.whoi.edu/IFCB1_2011_270_120600_00995,
% fetch the image.
% if image_dir is provided, will look there for a .png file

pid = char(pid);

if nargin < 2,
    try
        img = imread([pid '.png'], 'PNG');
    catch
        disp([pid '.png unreadable'])
        img = [];
    end;
else
    try 
        img = imread([image_dir filesep lid(pid) '.png'], 'PNG');
    catch
        disp([pid '.png unreadable'])
        img = [];
    end;
end

end