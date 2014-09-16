%roipath = '\\128.128.108.214\data\';
%manualpath = '\\queenrose\IFCB14_Dock\ditylum\Manual\';
roipath = 'http://ifcb-data.whoi.edu/mvco/';
manualpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';

filelist = dir([manualpath 'I*.mat']);

for ii = 1:length(filelist),
    disp(filelist(ii).name)
    clist = load([manualpath filelist(ii).name], 'classlist');
    %adc = importdata([roipath regexprep(filelist(ii).name, 'mat', 'adc')]);
    adc = get_adc_file([roipath regexprep(filelist(ii).name, 'mat', 'adc')]);
    zeros_ind = find(adc(:,12) == 0);
    if ~isempty(zeros_ind)
%        t = find(~isnan(clist.classlist(zeros_ind,2)));
%        s = find(~isnan(clist.classlist(zeros_ind,3)));
%        if ~isempty(t)% | ~isempty(s),
%            keyboard
%        end;
        clist.classlist(zeros_ind,2:3) = NaN;
        classlist = clist.classlist;
        save([manualpath filelist(ii).name], 'classlist', '-append')
        %save(['C:\work\IFCB\ifcb_data_MVCO_jun06\test_out\'  filelist(ii).name], 'classlist')
    end;
end;

