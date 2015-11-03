resultpath = '/Volumes/TOSHIBA EXT/whoi_data/output_manual_classify/';
%filelist = get_filelist_manual([resultpath 'manual_list'],2,[2006:2012], 'all'); %manual_list, column to use, year to find
%filelist_manual = {filelist.name}';
%mdate = IFCB_file2date({filelist.name});
urlbase = 'http://profileur.flsh.usherbrooke.ca/myifcb/';

load([resultpath 'summary/test_training_nov2013']);
%load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
%filelist = manual_list(2:end,1); %filelist = cellstr(filelist(:,1:end-4));
% filelist = regexprep(filelist, '.mat', '');
% clear manual_list resultpath

% classfilestr = '_class_v1';
% [ filelist, classfiles ] = resolve_MVCOclassfiles( filelist, classfilestr );
load('/Volumes/TOSHIBA EXT/whoi_data/output_manual_classify/summary/Sherbrooke_trees_test');

[y,TBscores]=oobPredict(b);%,b.X);

%adhocthresh = .45;
subnum = 0;
[maxscore, winclass] = max(TBscores'); %Winclass is the classes that are the best classes from the Randomforest algorithm
  [~,manual_class_num]=ismember(b.Y',classes); %These are the classes from the training dataset (the correct one)
  
for count = 1:length(classes),
    disp(classes(count))
    %ii = find(winclass == count & manual_class_num==count); %case when the classifier is right
    ii = find(winclass == count & manual_class_num~=count);
    %ii = find(winclass ~= count & manual_class_num==count);
%keyboard
    if ~isempty(ii),
        %keyboard
        for num = 1:length(ii),
            subnum = subnum + 1;
            subplot(5,2,subnum)
            roi_id = [targets{ii(num)} '.png']; 
            img = imread([urlbase roi_id]);
            imshow(img), title([roi_id '; score = ' num2str(maxscore(ii(num)), '%.2f')], 'interpreter', 'none')
            if subnum == min(10,length(ii)),
                pause
                clf
                subnum = 0;
            end;
        end;
    end;
end;