%USER SET PATHS
%where are your manual classification results? same resultpath as for manual_classify_stream2b.m
resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
outputpath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\manual_fromWeb\ciliate_test\'; %USER where to write out pngs
urlbase = 'http://ifcb-data.whoi.edu/mvco/';

resultfilelist = get_filelist_manual([resultpath 'manual_list'],2,[2006:2012], 'all'); %manual_list, column to use, year to find, Copied here by Emily P. from manual_classify_batch_3_1
%resultfilelist = [dir([resultpath 'IFCB1_2006_???_00*.mat']); dir([resultpath 'IFCB1_2007_???_00*.mat'])];
%case 3 for ciliate, big ciliate, diatoms, ditylum ONLY
%load([resultpath 'manual_list.mat']) %col 2-7: {'all categories','ciliates','ditylum','diatoms','big ciliates','special big only'}
%t = cell2mat(manual_list(2:end,2:end-1));
%ind = find(~t(:,1) & t(:,2) & t(:,3) & t(:,4) & t(:,5) & ~t(:,6));
%resultfilelist = cell2struct(manual_list(ind+1,1),{'name'},2);

[ matdate ] = IFCB_file2date( {resultfilelist.name} );
[yr,month] = datevec(matdate);

resultfilelist = char(resultfilelist.name);
resultfilelist = cellstr(resultfilelist(:,1:end-4));

unqmonth = unique(month);
unqyr = unique(yr);
%category = {'ciliate_mix' 'tintinnid'}; %use this syntax to export ONLY the listed categories
%category = {'ciliate_mix'}; %use this syntax to export ONLY the listed categories
category = {'ciliate_mix' 'tintinnid' 'Myrionecta' 'Laboea' 'S_conicum' 'tiarina' 'strombidium_1'...
            'S_caudatum', 'Strobilidium_1' 'Tontonia' 'strombidium_2' 'S_wulffi' 'S_inclinatum' 'Euplotes' 'Didinium'...
            'Leegaardiella' 'Sol' 'strawberry' 'S_capitatum'};
for count = 1:length(category),
    %if ~exist([outputpath char(category(count))], 'dir'),
    %    mkdir([outputpath char(category(count))]);
        for ii = 1:length(unqmonth),
            for iii = 1:length(unqyr),
                pathstr = [outputpath char(category(count)) '\month' num2str(unqmonth(ii),'%02d') '\' num2str(unqyr(iii)) '\'];
                if ~exist(pathstr, 'dir'),
                    mkdir(pathstr)
                end;
            end;
        end;
    %end;
end;


for filecount = 1:length(resultfilelist),
    resultfile = char(resultfilelist(filecount));    
    load([resultpath resultfile])

    %USER CHOOSE A LINE AND EDIT FOR YOUR CASE
    %category = setdiff(class2use_manual, {'bad' 'ciliate' 'crypto' 'dino30' 'roundCell' 'clusterflagellate' 'other' 'mix' 'detritus' 'mix_elongated' 'flagellate' });  %use this syntax to export all EXCEPT the listed categories
    %keyboard
    %category = class2use_manual; %use this syntax to export ALL categories
    %category = {'Pleurosigma' 'Thalassionema'}; %use this syntax to export ONLY the listed categories
    

    disp(resultfile)
    %make subdirs for tiffs

    %loop over classes and save pngs to subdirs
    for count2 = 1:length(category);
%        ind = find(classlist(:,3) == strmatch(category(count2), class2use, 'exact'));
        classnum = strmatch(category(count2), class2use_sub4, 'exact');
     %   ind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
        ind = find(classlist(:,4) == classnum);  %MANUAL ONLY
        %for count = 1:length(ind)
        for count = 1:length(ind),
            num = classlist(ind(count),1);
            %fseek(fid, startbyte(num), -1);
            %img = fread(fid, x(num).*y(num), 'ubit8');
            %img = reshape(img, x(num), y(num));
            pngname = [resultfile '_' num2str(num,'%05.0f')];
            image = get_image([urlbase pngname]);
            if length(image) > 0,
                pathstr = [outputpath char(category(count2)) '\month' num2str(month(filecount),'%02d') '\' num2str(yr(filecount)) '\'];
                imwrite(image, [pathstr pngname '.png'], 'png');
            end;
        end;
    end;
end