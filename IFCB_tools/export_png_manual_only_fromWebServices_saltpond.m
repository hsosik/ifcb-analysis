%USER SET PATHS
%where are your manual classification results? same resultpath as for manual_classify_stream2b.m
resultpath = '\\mellon\saltpond\manualclassify\';
outputpath = 'C:\work\IFCB010\manual_fromWeb\'; %USER where to write out pngs
urlbase = 'http://ifcb-data.whoi.edu/saltpond/';

%resultfilelist = get_filelist_manual([resultpath 'manual_list'],3,[2006:2011], 'all'); %manual_list, column to use, year to find, Copied here by Emily P. from manual_classify_batch_3_1
resultfilelist = dir([resultpath 'D*.mat']);

resultfilelist = char(resultfilelist.name);
resultfilelist = cellstr(resultfilelist(:,1:end-4));

for count = 1:length(resultfilelist),
    resultfile = char(resultfilelist(count));    
    load([resultpath resultfile])

    %USER CHOOSE A LINE AND EDIT FOR YOUR CASE
    category = setdiff(class2use_manual, {'other'});  %use this syntax to export all EXCEPT the listed categories
    %category = class2use_manual; %use this syntax to export ALL categories
    %category = {'Pleurosigma' 'Thalassionema'}; %use this syntax to export ONLY the listed categories
    %category = {'ciliate'}; %use this syntax to export ONLY the listed categories
        
    disp(resultfile)
    %make subdirs for tiffs
    for count = 1:length(category),
        if ~exist([outputpath char(category(count))], 'dir'),
            mkdir([outputpath char(category(count))]);
        end;
    end;

    %loop over classes and save pngs to subdirs
    for count2 = 1:length(category);
        classnum = strmatch(category(count2), class2use_manual, 'exact');
        ind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
        ind = find(classlist(:,2) == classnum);  %MANUAL ONLY
        for count = 1:length(ind),
            num = classlist(ind(count),1);
            %pngname = [resultfile '_' num2str(num,'%05.0f')];
            pngname = [resultfile(1:17) num2str(num,'%05.0f') resultfile(17:end)];
            image = get_image([urlbase pngname]);
            if length(image) > 0,
                imwrite(image, [outputpath char(category(count2)) '\' pngname '.png'], 'png');
            end;
        end;
    end;
end