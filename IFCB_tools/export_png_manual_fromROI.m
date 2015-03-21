%USER SET PATHS
%where are your manual classification results? same resultpath as for manual_classify
resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
outputpath = '\\raspberry\d_work\IFCB1\ifcb_data_MVCO_jun06\manual_test\'; %USER where to write out pngs
roibasepath = '\\demi\vol3\';
%urlbase = 'http://ifcb-data.whoi.edu/mvco/'; %USER where is your dashboard\web server

resultfilelist = dir([resultpath 'D*.mat']);
resultfilelist = char(resultfilelist.name);
resultfilelist = cellstr(resultfilelist(:,1:end-4));

for filecount = 1:length(resultfilelist),
    resultfile = char(resultfilelist(filecount));    
    load([resultpath resultfile])

    %USER CHOOSE A LINE AND EDIT FOR YOUR CASE
    %category = class2use_manual; %use this syntax to export ALL categories
    category = {'Ceratium', 'Ditylum'}; %use this syntax to export ONLY the listed categories
    %category = setdiff(class2use_manual, {'bad' 'ciliate' 'detritus'});  %use this syntax to export all EXCEPT the listed categories

    disp(resultfile)
    %make subdirs for tiffs
    for count = 1:length(category),
        if ~exist([outputpath char(category(count))], 'dir'),
            mkdir([outputpath char(category(count))]);
        end;
    end;

    roipath = [roibasepath];
    %loop over classes and save pngs to subdirs
    for count2 = 1:length(category);
        classnum = strmatch(category(count2), class2use_manual, 'exact');
        ind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
        %   ind = find(classlist(:,2) == classnum);  %MANUAL ONLY
        roinum = classlist(ind,1);
        export_png_from_ROIlist([roipath resultfile], [outputpath filesep category{count2}, roinum]);
    end;
end