%MVCO sets
MCconfig = get_MCconfigMVCO;
[MCconfig, filelist, classfiles, stitchfiles] = get_MCfilelistMVCO(MCconfig);

%Other sets
%MCconfig = get_MCconfig;
%[MCconfig, filelist, classfiles] = get_MCfilelist(MCconfig);
%stitchfiles = [];

if isempty(filelist),
    disp('No files found. Check paths or file specification in get_MCconfig.')
    return
end;

manual_classify_4_0( MCconfig, filelist, classfiles, stitchfiles );

