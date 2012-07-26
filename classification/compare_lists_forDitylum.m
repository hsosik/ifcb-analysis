load C:\work\IFCB\Ditylum\fromRob_July2012\DitylumMVCOProfileResults\ProfileResults2009
roiid_previous = cellstr([roifilelist(:,1:end-4) repmat('_', length(roinumlist),1) num2str(roinumlist, '%05.0f')]);

load summary_allTB2009
%initialize
roiidTB = cell(sum(classcountTB_above_adhocthresh(:,class2list)),1);
ind = 0;
for ii = 1:length(filelistTB),
    roinum_temp = roiids{ii};
    for iii = 1:length(roinum_temp),
        ind = ind + 1;
        roiidTB{ind} = [filelistTB{ii} '_' num2str(roinum_temp(iii),'%05.0f')];
    end;
end;

overlap_list = intersect(roiid_previous, roiidTB);
remove_list = setdiff(roiid_previous, roiidTB);
add_list = setdiff(roiidTB, roiid_previous);

view_rois(add_list)
    