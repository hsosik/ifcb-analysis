classpath_generic = 'C:\work\IFCB\user_training_test_data\class2\xxxx\classxxxx_v1\'; %USER where are your class files, xxxx in place for 4 digit year
out_path = 'C:\work\IFCB\user_training_test_data\class2\summary\'; %USER where to store the results
in_dir = 'C:\work\IFCB\user_training_test_data\data\'; %USER where is your raw data (e.g., hdr files); URL for web services if desired 

%'Guinardia_striata' 'Karenia,pennate_diatom,misc_nano'
class2do_string = 'tintinnid'; %USER 

classfiles = [];
for yr = 2016 %2014:2015 %USER
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

filelist = char(filelist);
if strcmp('http', in_dir(1:4))
    hdrfiles = cellstr([repmat(in_dir,length(filelist),1) filelist repmat('.hdr', length(filelist), 1)]);
else
    fsep = repmat(filesep, size(filelist,1),1);
    %determine data subdir structure
    if exist([in_dir filelist(1,:) '.hdr'], 'file') %presume all files in top level of in_dir
        hdrfiles = cellstr([repmat(in_dir,size(filelist,1),1) fsep filelist repmat('.hdr', size(filelist,1), 1)]);   
    elseif exist([in_dir filelist(1,2:5) filesep filelist(1,:) '.hdr'], 'file') %presume all files in subdir by year
        hdrfiles = cellstr([repmat(in_dir,size(filelist,1),1) filelist(:,2:5) fsep filelist repmat('.hdr', size(filelist,1), 1)]);
    elseif exist([in_dir filelist(1,2:5) filesep filelist(1,1:9) filesep filelist(1,:) '.hdr'], 'file') %presume all files in subdir by year then day
        hdrfiles = cellstr([repmat(in_dir,size(filelist,1),1) filelist(:,2:5) fsep filelist(:,1:9) fsep filelist repmat('.hdr', size(filelist,1), 1)]);
    else
        disp('First hdr file not found. Check input directory.')
        return
    end
end;

ml_analyzed = IFCB_volume_analyzed(hdrfiles);

temp = load(classfiles{1}, 'class2useTB');
class2use = temp.class2useTB; clear temp classfilestr
num2dostr = num2str(length(classfiles));

class2do = strmatch(class2do_string, class2use); 
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

if ~exist(out_path, 'dir')
    mkdir(out_path)
end
save([out_path 'summary_allTB_bythre_' class2useTB{class2do}] , 'class2useTB', 'threlist', 'classcountTB_above_thre', 'classcountTB_above_thre', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'classpath_generic', 'roiids', 'class2do')
%save(['summary_allTB' num2str(yr)] , 'class2useTB', 'classcountTB', 'classcountTB_above_optthresh', 'classcountTB_above_adhocthresh', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'adhocthresh', 'classpath_generic', 'roiids', 'class2list')
