roibasepath = '\\sosiknas1\IFCB_data\IFCB013_TaraOceansPolarCircle\data\';
manualpath = 'c:\temp\manual\';

filelist = dir([manualpath 'D*.mat']);

for ii = 1:length(filelist),
    fname = filelist(ii).name;
    disp(fname)
    clist = load([manualpath fname], 'classlist');
    %roipath = [roibasepath filesep fname(2:5) filesep fname(1:9) filesep]; %construct the full path for this file, base\yyyy\daydir\
    roipath = roibasepath; %use this line for all ROI/ADC data in one directory
    adc = importdata([roipath regexprep(fname, 'mat', 'adc')]); %read the adc file
    zeros_ind = find(adc(:,16) == 0); %find the triggers with zero-sized ROIs
    if ~isempty(zeros_ind) % mark their annotations as NaNs
        clist.classlist(zeros_ind,2) = NaN;
        classlist = clist.classlist;
        save([manualpath fname], 'classlist', '-append')
    end;
end;

