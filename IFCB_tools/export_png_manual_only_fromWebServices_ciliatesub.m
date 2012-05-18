%USER SET PATHS
%where are your manual classification results? same resultpath as for manual_classify_stream2b.m
resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
outputpath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\manual_fromWeb\'; %USER where to write out pngs
urlbase = 'http://ifcb-data.whoi.edu/mvco/';

resultfilelist = get_filelist_manual([resultpath 'manual_list'],2,[2006], 'all'); %manual_list, column to use, year to find, Copied here by Emily P. from manual_classify_batch_3_1
%resultfilelist = [dir([resultpath 'IFCB1_2006_???_00*.mat']); dir([resultpath 'IFCB1_2007_???_00*.mat'])];
%case 3 for ciliate, big ciliate, diatoms, ditylum ONLY
%load([resultpath 'manual_list.mat']) %col 2-7: {'all categories','ciliates','ditylum','diatoms','big ciliates','special big only'}
%t = cell2mat(manual_list(2:end,2:end-1));
%ind = find(~t(:,1) & t(:,2) & t(:,3) & t(:,4) & t(:,5) & ~t(:,6));
%resultfilelist = cell2struct(manual_list(ind+1,1),{'name'},2);

resultfilelist = char(resultfilelist.name);
resultfilelist = cellstr(resultfilelist(:,1:end-4));

for filecount = 1:length(resultfilelist),
    resultfile = char(resultfilelist(filecount));    
    load([resultpath resultfile])

    %USER CHOOSE A LINE AND EDIT FOR YOUR CASE
    %category = setdiff(class2use_manual, {'bad' 'ciliate' 'crypto' 'dino30' 'roundCell' 'clusterflagellate' 'other' 'mix' 'detritus' 'mix_elongated' 'flagellate' });  %use this syntax to export all EXCEPT the listed categories
    %keyboard
    %category = class2use_manual; %use this syntax to export ALL categories
    %category = {'Pleurosigma' 'Thalassionema'}; %use this syntax to export ONLY the listed categories
    category = {'ciliate'}; %use this syntax to export ONLY the listed categories

    disp(resultfile)
    %make subdirs for tiffs
    for count = 1:length(category),
        if ~exist([outputpath char(category(count))], 'dir'),
            mkdir([outputpath char(category(count))]);
        end;
    end;

    %loop over classes and save pngs to subdirs
    for count2 = 1:length(category);
%        ind = find(classlist(:,3) == strmatch(category(count2), class2use, 'exact'));
        classnum = strmatch(category(count2), class2use_manual, 'exact');
        ind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
     %   ind = find(classlist(:,2) == classnum);  %MANUAL ONLY
        %for count = 1:length(ind)
        for count = 1:length(ind),
            num = classlist(ind(count),1);
            %fseek(fid, startbyte(num), -1);
            %img = fread(fid, x(num).*y(num), 'ubit8');
            %img = reshape(img, x(num), y(num));
            pngname = [resultfile '_' num2str(num,'%05.0f')];
            image = get_image([urlbase pngname]);
            if length(image) > 0,
                imwrite(image, [outputpath char(category(count2)) '\' pngname '.png'], 'png');
            end;
        end;
    end;
end