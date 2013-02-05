
%Other sets
%MCconfig = get_MCconfigHLY;
%[MCconfig, filelist, classfiles] = get_MCfilelistHLY(MCconfig);
%stitchfiles = [];

%dock
MCconfig = get_MCconfigDock;
[MCconfig, filelist, classfiles, stitchfiles] = get_MCfilelistDock(MCconfig);
stitchfiles = [];

if isempty(filelist),
    disp('No files found. Check paths or file specification in get_MCconfig.')
    return
end;

manual_classify_4_0( MCconfig, filelist, classfiles, stitchfiles );

