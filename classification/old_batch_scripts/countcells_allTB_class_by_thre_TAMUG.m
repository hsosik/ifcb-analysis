classpath_generic = '\\Dq-cytobot-pc\IFCB\class_TAMUG_Trees_15Jul2015\xxxx\';
outpath = '\\Dq-cytobot-pc\IFCB\class_TAMUG_Trees_15Jul2015\summary\';
in_dir = '\\Dq-cytobot-pc\IFCB\data\'; %USER where to access data (hdr files) (url for web services, full path for local)

classfiles = [];
for yr = 2014:2015, %:2012,
    classpath = regexprep(classpath_generic, 'xxxx', num2str(yr));
    temp = dir([classpath 'D*.mat']);
    pathall = repmat(classpath, length(temp),1);
    classfiles = [classfiles; cellstr([pathall char(temp.name)])];
    clear temp pathall classpath
end;

temp = char(classfiles);
ind = length(classpath_generic)+1;
filelist = cellstr(temp(:,ind:ind+23));
mdate = IFCB_file2date(filelist);

if strcmp('http', in_dir(1:4))
    hdrfiles = cellstr([repmat(in_dir,length(filelist),1) filelist repmat('.hdr', length(filelist), 1)]);
else
    fsep = repmat(filesep, length(filelist),1);
    f = char(filelist);
    hdrfiles = cellstr([repmat(in_dir,length(filelist),1) f(:,1:5) fsep f(:,1:9) fsep f repmat('.hdr', length(filelist), 1)]);
end;
disp('computing volume analyzed...')
ml_analyzed = IFCB_volume_analyzed(hdrfiles);

temp = load(classfiles{1}, 'class2useTB');
class2use = temp.class2useTB; clear temp classfilestr
num2dostr = num2str(length(classfiles));

class2do = strmatch( 'Flagellate_MIX', class2use);
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

ml_analyzedTB = ml_analyzed;
mdateTB = mdate;
filelistTB = filelist;

save([outpath 'summary_allTB_bythre_' class2useTB{class2do}] , 'class2useTB', 'threlist', 'classcountTB_above_thre', 'classcountTB_above_thre', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'classpath_generic', 'roiids', 'class2do')
%save(['summary_allTB' num2str(yr)] , 'class2useTB', 'classcountTB', 'classcountTB_above_optthresh', 'classcountTB_above_adhocthresh', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'adhocthresh', 'classpath_generic', 'roiids', 'class2list')
