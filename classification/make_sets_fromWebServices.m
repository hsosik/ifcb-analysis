manual_path = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
train_path = '\\queenrose\IFCB1\ifcb_data_mvco_jun06\train_30Sep2014\';
urlbase = 'http://ifcb-data.whoi.edu/mvco/';

load([manual_path 'manual_list']) %load the manual list detailing annotate mode for each sample file

load class2use_MVCOmanual4 %get the master list to start
[ classes_byfile, classes_bymode ] = get_annotated_classesMVCO( class2use, manual_list);
filelist = classes_byfile.filelist;

%daydate = floor(IFCB_file2date(filelist));
%unqday = unique(daydate);

%make subdirs for pngs
class2use_manual = class2use;
for count = 1:length(class2use_manual),
    if ~exist([train_path char(class2use_manual(count))], 'dir'),
        mkdir([train_path char(class2use_manual(count))]);
        mkdir([train_path char(class2use_manual(count)) '\extra\']);
        mkdir([train_path char(class2use_manual(count)) '\somedoubt\']);
        mkdir([train_path char(class2use_manual(count)) '\confounded\']);
    end;
end;

%load([manual_path filelist(1,:)])
roi_class_byfile = cell(size(filelist,1),length(class2use_manual));
roi_count_byfile = NaN(size(filelist,1),length(class2use_manual));
disp('checking manual files...')
for filecount = 1:size(filelist,1),
    disp(filelist(filecount))
    load([manual_path filelist{filecount}])
    classes_done = find(classes_byfile.classes_checked(filecount,:));
    for classcount = 1:length(class2use_manual),
        if ismember(classcount,classes_done), %consider manual and auto
            roi_class_byfile{filecount, classcount} = find(classlist(:,2) == classcount | isnan(classlist(:,2)) & classlist(:,3) == classcount);
            roi_count_byfile(filecount, classcount) = length(find(classlist(:,2) == classcount | isnan(classlist(:,2)) & classlist(:,3) == classcount));
        else %manual only
            roi_class_byfile{filecount, classcount} = find(classlist(:,2) == classcount);
            roi_count_byfile(filecount, classcount) = length(find(classlist(:,2) == classcount));
        end;
    end;
end;

train_num = 1000;

filenum_list = cell(length(class2use_manual),1);
num_roi_list = filenum_list;
num2get_file = filenum_list;
disp('selecting rois for sets...')
for classcount = 1:length(class2use_manual),
    t = cell(size(filelist,1),1);
    for indcount = 1:size(filelist,1),
        t{indcount} = ones(length(roi_class_byfile{indcount,classcount}),1)*indcount;
    end;
    filenum_list{classcount} = cat(1,t{:}); %list of file numbers for each roi of this class
    num_roi_list{classcount} = cat(1,roi_class_byfile{:,classcount}); %list of roi numbers in this class (with corresponding filenum_list)
    unqfiles = unique(filenum_list{classcount});
    rois_possible = roi_count_byfile(unqfiles,classcount);
%    rois_possible(rois_possible <=1) = 0; %%%SPECIAL CASE - OMIT FIRST PASS(es) (only 1 possible) since previously taken
    if sum(rois_possible) <= train_num,
        num2get = rois_possible;
    else
        avgnum = ceil(train_num/length(unqfiles));
        num2get = ones(size(rois_possible))*avgnum;
        ind = find(rois_possible < num2get); %reset if avgnum not available
        num2get(ind) = rois_possible(ind);
        %this case gets more than one pass by starting at the begining and passing again
        %count = 0;
        %while (nansum(num2get) < train_num & nansum(num2get) < nansum(rois_possible)),
        %    count = count + 1;
        %    ind = find(rois_possible >= avgnum + count);
        %    num2get(ind) = num2get(ind) + 1;
        %end;
        %this case gets more than one pass by randomly choosing from all
        %remaining available (so not even in time, rather more likely to get blooms...)
        left2get = train_num - sum(num2get);
        rois_left = rois_possible-num2get;
        %get the rest sampling according to PDF of remaining from rois_possible
        temp = rois_left./sum(rois_left)*left2get;
        [temp2, ind] = sort(temp, 'descend');
        temp2 = (cumsum(ceil(temp2)));
        ind2 = find(temp2 >= left2get); ind2 = ind2(1); ind = ind(1:ind2);
        num2get(ind) = num2get(ind) + ceil(temp(ind)); 
        if sum(num2get) < train_num, keyboard, end;
    end;
    num2get_file{classcount} = num2get;
end;

clear xbig ybig num2get ind* *count t classlist ans avgnum class2use_sub* class2use_auto class2use big_only unqfiles list_titles

%filelist = filelist(:,1:end-4);
for classcount = 44:length(class2use_manual),  %REDO 43 - start on 73
    disp(class2use_manual{classcount})
    filenum = filenum_list{classcount};
    num_roi = num_roi_list{classcount};
    unqfilenum = unique(filenum);
    num2get = num2get_file{classcount};
    cat_path = [train_path char(class2use_manual(classcount)) '\'];
    disp('     writing pngs...')
    for filecount = 1:length(unqfilenum),
        fileind = find(filenum == unqfilenum(filecount));
        fileind = fileind(randperm(num2get(filecount))); %randomly choose the ones to get from all possible
        filename = filelist{unqfilenum(filecount),:};
    
        for count = 1:length(fileind),
            num = num_roi(fileind(count));
            tname = [filename '_' num2str(num,'%05.0f')];
            image = get_image([urlbase tname]);
            imwrite(image, [cat_path tname '.png'], 'png');
        end;
    end;
    tempfilelist = dir([cat_path '*.png']);
    numpng = length(tempfilelist);
    sortind = randperm(numpng);
    disp('     sorting pngs...')
    if ~isempty(sortind),
        if numpng >= train_num,
            for count = 1:numpng-train_num,
                dos(['move ' cat_path tempfilelist(sortind(count)).name ' '  cat_path 'extra\' ]);
            end;
        end;
    end;
end;