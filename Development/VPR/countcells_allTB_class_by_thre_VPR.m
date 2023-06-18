classpath= '\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_30Oct2015_seven_classes\classpath_div\';

classfiles = [];
%for yr = 2006:2015, %:2012,
    %classpath = regexprep(classpath_generic, 'xxxx', num2str(yr));
    temp = dir([classpath 'd*.mat']);
    pathall = repmat(classpath, length(temp),1);
    classfiles = [classfiles; cellstr([pathall char(temp.name)])];
    clear temp pathall


temp = char(classfiles);
ind = length(classpath)+1;
filelist = cellstr(temp(:,ind:ind+20));
%mdate = IFCB_file2date(filelist);

% load('\\raspberry\d_work\IFCB1\code_mar10_mvco\ml_analyzed_all', 'ml_analyzed', 'filelist_all');
% [~,ia, ib] = intersect(filelist, filelist_all);
% if length(ia) ~= length(filelist),
%     disp('missing some ml_analyzed values; need to make updated ml_analyzed all.mat?')
%     pause
% end;
% temp = NaN(size(filelist));
% temp(ia) = ml_analyzed(ib);
% ml_analyzed_list = temp;
% clear ml_analyzed filelist_all temp ia ib 

temp = load(classfiles{1}, 'class2useTB');
class2use = temp.class2useTB; clear temp classfilestr
num2dostr = num2str(length(classfiles));

class2do = strmatch( 'phaeManyMix', class2use, 'exact');
threlist = [0:.1:1];

classcountTB_above_thre = NaN(length(classfiles),length(threlist));

%%

%    adhocthresh = threlist(ii).*ones(size(class2use));    
    for filecount = 1:length(classfiles)
        if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end;
        [classcountTB_above_thre(filecount,:), class2useTB, roiid_list] = summarize_TBclassMVCO_threshlist(classfiles{filecount}, threlist, class2do);
        %[classcount(filecount,:), classcount_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), class2useTB, roiid_list] = summarize_TBclassMVCO(classfiles{filecount}, adhocthresh, iclass);
        roiids{filecount} = roiid_list;
    end;
%%

% ml_analyzedTB = ml_analyzed_list;
% mdateTB = mdate;
filelistTB = filelist;
classpath_generic = classpath;
savedir = '\\SOSIKNAS1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_30Oct2015_seven_classes\classpath_div\summary_by_thre\';
save([savedir 'summary_allTB_bythre_' class2useTB{class2do}] , 'class2useTB', 'threlist', 'classcountTB_above_thre', 'classcountTB_above_thre',  'filelistTB', 'classpath_generic', 'roiids', 'class2do')
%save(['summary_allTB' num2str(yr)] , 'class2useTB', 'classcountTB', 'classcountTB_above_optthresh', 'classcountTB_above_adhocthresh', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'adhocthresh', 'classpath_generic', 'roiids', 'class2list')
