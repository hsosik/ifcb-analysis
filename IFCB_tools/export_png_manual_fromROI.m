%USER SET PATHS
%where are your manual classification results? same resultpath as for manual_classify
resultpath = 'C:\work\IFCB\user_training_test_data\manual\';
outputpath = 'C:\work\IFCB\user_training_test_data\manual\pngs\'; %USER where to write out pngs
roibasepath = 'C:\work\IFCB\user_training_test_data\data\xxxx\'; %USER where are your ROIs, put xxxx to mark loaction so of year digits
%urlbase = 'http://ifcb-data.whoi.edu/mvco/'; %USER where is your dashboard\web server

resultfilelist = dir([resultpath 'D*.mat']);
resultfilelist = char(resultfilelist.name);
resultfilelist = cellstr(resultfilelist(:,1:end-4));

for filecount = 1:length(resultfilelist),
    resultfile = char(resultfilelist(filecount));    
    load([resultpath resultfile])

    %USER CHOOSE A LINE AND EDIT FOR YOUR CASE
    %category = class2use_manual; %use this syntax to export ALL categories
    %category = {'Ceratium', 'Ditylum'}; %use this syntax to export ONLY the listed categories
    %category = setdiff(class2use_manual, {'bad' 'ciliate' 'detritus'});  %use this syntax to export all EXCEPT the listed categories
    category = setdiff(class2use_manual, {'other' 'misc_nano'});  %use this syntax to export all EXCEPT the listed categories

    disp(resultfile)
    %make subdirs for tiffs
    for count = 1:length(category),
        if ~exist([outputpath char(category(count))], 'dir'),
            mkdir([outputpath char(category(count))]);
        end;
    end;
    if resultfile(1) == 'D'
        roipath = [roibasepath resultfile(1:9) filesep];
        roipath = regexprep(roipath, 'xxxx', resultfile(2:5));
    else
        roipath = [roibasepath resultfile(1:14) filesep];
        roipath = regexprep(roipath, 'xxxx', resultfile(7:10));
    end;
    
    %loop over classes and save pngs to subdirs
    for count2 = 1:length(category);
        classnum = strmatch(category(count2), class2use_manual, 'exact');
        if isempty(classnum),
            disp(['Category is missing from class2use: ' category{count2}])
        else
            ind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
            %   ind = find(classlist(:,2) == classnum);  %MANUAL ONLY
            roinum = classlist(ind,1);
            export_png_from_ROIlist([roipath resultfile], [outputpath filesep category{count2}], roinum);
        end;
    end;
end