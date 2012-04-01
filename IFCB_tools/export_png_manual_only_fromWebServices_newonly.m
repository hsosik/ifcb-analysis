%USER SET PATHS
%where are your manual classification results? same resultpath as for manual_classify_stream2b.m
resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
outputpath = '\\queenrose\ifcb_data_mvco_jun06\train_new_only2\'; %USER where to write out pngs
urlbase = 'http://ifcb-data.whoi.edu/mvco/';

set1path = '\\queenrose\ifcb_data_mvco_jun06\train_04Nov2011_fromWebServices\';

resultfilelist = get_filelist_manual([resultpath 'manual_list'],7,[2006:2011], 'all'); %manual_list, column to use, year to find, Copied here by Emily P. from manual_classify_batch_3_1
%resultfilelist = dir([resultpath 'IFCB*.mat']);
%resultfilelist = [dir([resultpath 'IFCB1_2006_???_00*.mat']); dir([resultpath 'IFCB1_2007_???_00*.mat'])];
%case 3 for ciliate, big ciliate, diatoms, ditylum ONLY
%load([resultpath 'manual_list.mat']) %col 2-7: {'all categories','ciliates','ditylum','diatoms','big ciliates','special big only'}
%t = cell2mat(manual_list(2:end,2:end-1));
%ind = find(~t(:,1) & t(:,2) & t(:,3) & t(:,4) & t(:,5) & ~t(:,6));
%resultfilelist = cell2struct(manual_list(ind+1,1),{'name'},2);

resultfilelist = char(resultfilelist.name);
resultfilelist = cellstr(resultfilelist(:,1:end-4));

%USER CHOOSE A LINE AND EDIT FOR YOUR CASE
%category = setdiff(class2use_manual, {'bad' 'ciliate' 'crypto' 'dino30' 'roundCell' 'clusterflagellate' 'other' 'mix' 'detritus' 'mix_elongated' 'flagellate' });  %use this syntax to export all EXCEPT the listed categories
%keyboard
%category = class2use_manual; %use this syntax to export ALL categories
%category = {'clusterflagellate' 'Coscinodiscus' 'Dinophysis' 'Euglena' 'Gyrodinium' 'kiteflagellates' 'Lauderia' 'Licmophora' 'Odontella' 'Pyramimonas' 'Stephanopyxis'}; %use this syntax to export ONLY the listed categories
category = {'Ceratium' 'Coscinodiscus' 'Dinophysis' 'Ephemera' 'Eucampia' 'Euglena' 'Guinardia_flaccida' 'Guinardia_striata' 'Hemiaulus' 'Lauderia' 'Licmophora'...
    'Odontella' 'Paralia' 'Phaeocystis' 'Pyramimonas' 'Stephanopyxis' 'bad' 'clusterflagellate' 'kiteflagellates'};

%make subdirs for tiffs
for count = 1:length(category),
    if ~exist([outputpath char(category(count))], 'dir'),
        mkdir([outputpath char(category(count))]);
    end;
end;

for count2 = 1:length(category),
    class = char(category(count2));
    str1 = [set1path class '\'];
    list1{count2} = [dir([str1 '*.png']) ; dir([str1 '\confounded\*.png']); dir([str1 '\somedoubt\*.png']); dir([str1 '\mistakes\*.png'])];
end;

for count = 1:length(resultfilelist),
    resultfile = char(resultfilelist(count));
    load([resultpath resultfile])
    
    disp(resultfile)
    adc_struct = get_targets([urlbase resultfile]);
    
    %loop over classes and save pngs to subdirs
    for count2 = 1:length(category);
        classnum = strmatch(category(count2), class2use_manual, 'exact');
        ind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
        if ~isempty(ind),
            list2 = {};
            for c = 1:length(ind),
                list2(c,1) = cellstr([resultfile '_' num2str(ind(c),'%05.0f') '.png']);
            end;
            %list2 = [repmat([resultfile '_'], length(ind),1) num2str(ind) repmat('.png', length(ind),1)];
            [list_merge,idx] = setdiff(list2, {list1{count2}.name}');
            ind = ind(idx); %disp(length(ind))
            %ind = intersect(ind,adc_struct.targetNumber); %skip the missing ones, e.g., 0-sized ROIs
            %disp(length(ind))
            for count = 1:length(ind),
                %num = classlist(ind(count),1); %%This is same as ind(count)!!!!!
                num = ind(count);
                pngname = [resultfile '_' num2str(num,'%05.0f')];
                image = get_image([urlbase pngname]);
                if length(image) > 0,
                    imwrite(image, [outputpath char(category(count2)) '\' pngname '.png'], 'png');
                end;
            end;
        end;
    end;
end