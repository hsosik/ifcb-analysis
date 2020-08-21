classpath_generic = '\\SOSIKNAS1\IFCB_products\MVCO\class\classxxxx_v1\';

classfiles = [];
for yr = 2016:2018 %:2012,
    classpath = regexprep(classpath_generic, 'xxxx', num2str(yr));
    temp = dir([classpath 'I*.mat']);
    temp2 = dir([classpath 'D*.mat']);
    temp = [temp; temp2];
    pathall = repmat(classpath, length(temp),1);
    classfiles = [classfiles; cellstr([pathall char(temp.name)])];
    clear temp pathall classpath
end;

temp = char(classfiles);
ind = length(classpath_generic)+1;
filelist = cellstr(temp(:,ind:end));
filelist = regexprep(filelist, '_class_v1.mat', '');
mdate = IFCB_file2date(filelist);
%%
load('\\sosiknas1\IFCB_products\MVCO\ml_analyzed\ml_analyzed_all', 'ml_analyzed', 'filelist_all');
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
num2dostr = num2str(length(classfiles));

class2do = strmatch( 'Laboea', class2use);
threlist = [0:.1:1];


classcountTB_above_thre = NaN(length(classfiles),length(threlist));

%%

%    adhocthresh = threlist(ii).*ones(size(class2use));    
    for filecount = 1:length(classfiles)
        %for filecount = 205296:length(classfiles)
        if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end;
        [classcountTB_above_thre(filecount,:), class2useTB, roiid_list] = summarize_TBclassMVCO_threshlist(classfiles{filecount}, threlist, class2do);
        %[classcount(filecount,:), classcount_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), class2useTB, roiid_list] = summarize_TBclassMVCO(classfiles{filecount}, adhocthresh, iclass);
        roiids{filecount} = roiid_list;
    end

   

ml_analyzedTB = ml_analyzed_list;
mdateTB = mdate;
filelistTB = filelist;
%%
save(['summary_allTB_bythre_' class2useTB{class2do} '_2'] , 'class2useTB', 'threlist', 'classcountTB_above_thre', 'classcountTB_above_thre', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'classpath_generic', 'roiids', 'class2do')
%save(['summary_allTB' num2str(yr)] , 'class2useTB', 'classcountTB', 'classcountTB_above_optthresh', 'classcountTB_above_adhocthresh', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'adhocthresh', 'classpath_generic', 'roiids', 'class2list')
