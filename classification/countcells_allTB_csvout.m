classpath_generic = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\classxxxx_v1\';
outpath = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\temp_lists\';

classfiles = [];
for yr = 2006, %:2012,
    classpath = regexprep(classpath_generic, 'xxxx', num2str(yr));
    temp = dir([classpath 'I*.mat']);
    pathall = repmat(classpath, length(temp),1);
    classfiles = [classfiles; cellstr([pathall char(temp.name)])];
    clear temp pathall classpath
end;

temp = char(classfiles);
ind = length(classpath_generic)+1;
filelist = cellstr(temp(:,ind:ind+20));
mdate = IFCB_file2date(filelist);

load('ml_analyzed_all', 'ml_analyzed', 'filelist_all');
[~,ia, ib] = intersect(filelist, filelist_all);
if length(ia) ~= length(filelist),
    disp('missing some ml_analyzed values; need to make updated ml_analyzed all.mat?')
    pause
end;
temp = NaN(size(filelist));
temp(ia) = ml_analyzed(ib);
ml_analyzed_list = temp;
clear ml_analyzed filelist_all temp ia ib 

temp = load(classfiles{1}, 'class2useTB');
class2use = temp.class2useTB; clear temp classfilestr
classcount = NaN(length(classfiles),length(class2use));
classcount_above_optthresh = classcount;
classcount_above_adhocthresh = classcount;
num2dostr = num2str(length(classfiles));
adhocthresh = 0.5.*ones(size(class2use));
%adhocthresh(strmatch('Ditylum', class2use, 'exact')) = 0.45;
class2get_str = 'Laboea';
class2list = strmatch(class2get_str, class2use, 'exact');
%%
for filecount = 1:length(classfiles)
    if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end;
    [classcount(filecount,:), classcount_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), class2useTB, roiid_list, p_list] = summarize_TBclassMVCO(classfiles{filecount}, adhocthresh, class2list);
    roiids{filecount} = roiid_list;
    p{filecount} = p_list;
end;
%%

%classcountTB = classcount;
classcountTB_above_optthresh = classcount_above_optthresh;
%classcountTB_above_adhocthresh = classcount_above_adhocthresh;
%ml_analyzedTB = ml_analyzed_list;
%mdateTB = mdate;
%filelistTB = filelist;

%initialize
roiidTB = cell(sum(classcountTB_above_adhocthresh(:,class2list)),1);
pTB = NaN(size(roiidTB));
ind = 0;
for ii = 1:40, %length(filelistTB),
    roinum_temp = roiids{ii};
    for iii = 1:length(roinum_temp),
        ind = ind + 1;
        roiidTB{ind} = [filelistTB{ii} '_' num2str(roinum_temp(iii),'%05.0f')];
        pTB(ind) = p{ii}(iii);
    end;
end;

fid = fopen([outpath class2get_str num2str(yr) '.csv'], 'w');
for ii = 1:length(p),
    fprintf(fid, '%s,%s,%02.4f\n', roiidTB{ii}, class2get_str, pTB(ii));
end;
fclose(fid);

