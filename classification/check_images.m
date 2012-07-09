resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
%filelist = get_filelist_manual([resultpath 'manual_list'],2,[2006:2012], 'all'); %manual_list, column to use, year to find
%filelist_manual = {filelist.name}';
%mdate = IFCB_file2date({filelist.name});
urlbase = 'http://ifcb-data.whoi.edu/mvco/';

load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
filelist = manual_list(2:end,1); %filelist = cellstr(filelist(:,1:end-4));
filelist = regexprep(filelist, '.mat', '');
clear manual_list resultpath

classfilestr = '_class_v1';
[ filelist, classfiles ] = resolve_MVCOclassfiles( filelist, classfilestr );
train = load('MVCO_trees_25Jun2012', 'targets', 'maxthre');
adhocthresh = .45;
subnum = 0;
for count = 1:1:length(classfiles),
    disp(filelist(count))
    load(classfiles{count})
    mind = strmatch('Laboea', class2useTB, 'exact');
    [maxscore, winclass] = max(TBscores');
    %ii = find(winclass == mind & maxscore >= train.maxthre(mind));
    ii = find(winclass == mind & maxscore >= adhocthresh);
    %ii = find(winclass == mind & maxscore < adhocthresh & maxscore >= train.maxthre(mind));
    if ~isempty(ii),
        %keyboard
        for num = 1:min(100,length(ii)),
            subnum = subnum + 1;
            subplot(5,2,subnum)
            roi_id = [filelist{count} '_' num2str(roinum(ii(num)), '%05.0f') '.png']; 
            intrain = strmatch(roi_id, train.targets);
            if isempty(intrain), intrain = 0; end;
            img = imread([urlbase roi_id]);
            imshow(img), title([roi_id '; score = ' num2str(maxscore(ii(num)), '%.2f') '; train = ' num2str(intrain)], 'interpreter', 'none')
            if subnum == 10,
                pause
                clf
                subnum = 0;
            end;
        end;
    end;
end;