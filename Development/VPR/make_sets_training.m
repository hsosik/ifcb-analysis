%script to select and copy a subset of classified VPR images to
%subdirectories for a candidate training set (after a final quality
%control step); this presumes the existence of standard IFCB-style manual
%files (either produced from startMC / manual_classify OR converted from
%pre-existing aid files from McGillicuddy lab)
%   
%
%Heidi M. Sosik, Woods Hole Oceanographic Institution, August 2015

manual_path = '\\sosiknas1\Lab_data\VPR\NBP1201\manual\';
train_path = '\\sosiknas1\Lab_data\VPR\NBP1201\VPR8_train_27Oct2015\';
img_path_base = '\\sosiknas1\Lab_data\VPR\NBP1201\rois\';
roi2use = 1:5000; %This is because we only looked at the first 5000 images of each VPR hour. Change as needed.
%make subdirs for pngs
filelist = dir([manual_path 'NBP1201vpr8*.mat']); 
filelist = regexprep({filelist.name}, '.mat', '')';
t = load([manual_path filelist{1}]); 
class2use_manual = t.class2use_manual;
for count = 1:length(class2use_manual),
    if ~exist([train_path char(class2use_manual(count))], 'dir'),
        mkdir([train_path char(class2use_manual(count))]);
        mkdir([train_path char(class2use_manual(count)) '\extra\']);
        mkdir([train_path char(class2use_manual(count)) '\somedoubt\']);
        mkdir([train_path char(class2use_manual(count)) '\confounded\']);
    end;
end;

roi_class_byfile = cell(size(filelist,1),length(class2use_manual));
roi_count_byfile = NaN(size(filelist,1),length(class2use_manual));
disp('checking manual files...')
for filecount = 1:size(filelist,1),
    disp(filelist(filecount))
    load([manual_path filelist{filecount}])
    for classcount = 1:length(class2use_manual),
        roi_class_byfile{filecount, classcount} = classlist(classlist(roi2use,2) == classcount | isnan(classlist(roi2use,2)) & classlist(roi2use,3) == classcount,1);
        roi_count_byfile(filecount, classcount) = length(roi_class_byfile{filecount, classcount});
    end;
end;

train_num = 600;

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

clear num2get ind* *count t classlist ans avgnum class2use_auto class2use unqfiles list_titles temp* left2get rois_left rois_possible

%now copy the images
for classcount = 1:length(class2use_manual)
    disp(class2use_manual{classcount})
    filenum = filenum_list{classcount};
    num_roi = num_roi_list{classcount};
    unqfilenum = unique(filenum);
    num2get = num2get_file{classcount};
    cat_path = [train_path char(class2use_manual(classcount)) '\'];
    disp('     copy images...')
    for filecount = 1:length(unqfilenum),
        fileind = find(filenum == unqfilenum(filecount));
        fileind = fileind(randperm(num2get(filecount))); %randomly choose the ones to get from all possible
        filename = filelist{unqfilenum(filecount),:};
        imgpath = [img_path_base filename(8:end-7) filesep filename(end-6:end-3) filesep filename(end-2:end) filesep]; 
        for count = 1:length(fileind),
            num = num_roi(fileind(count));
            tname = ['roi0.' num2str(num,'%0.0f') '.tif'];
            copyfile([imgpath tname],[cat_path filename '.' tname])
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