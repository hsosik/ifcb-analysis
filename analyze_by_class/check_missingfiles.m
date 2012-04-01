resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
filelist_all = char(manual_list(2:end,1)); filelist_all = filelist_all(:,1:end-4);

day_list = unique(cellstr(filelist_all(:,1:14)));

datapaths = {'\\demi\ifcbold\G\IFCB\ifcb_data_MVCO_jun06\' '\\demi\ifcbnew\'};

allfiles = [];
for ii = 1:length(day_list),
    day = char(day_list(ii));
    disp(day)
    yr = day(7:10);
    if yr <=2009,
        roipath = char(datapaths(1));
    else
        roipath = char(datapaths(2));
    end;
    tempfiles = dir([roipath day '\' day '*.roi']);
    tempfiles = char(tempfiles.name); tempfiles = tempfiles(:,1:end-4);
    allfiles = [allfiles; tempfiles];
end;

allfiles = cellstr(allfiles);