resultpath = '\\raspberry\d_work\ifcb1\ifcb_data_mvco_jun06\manual_fromClass\summary\';
classpath_generic = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\classxxxx_v1\';
biovolpath_generic = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\biovolume\biovolumexxxx\';
%classfiles = [];
%biovolfiles = [];
for yr = 2013:2013, %:2012,
    classpath = regexprep(classpath_generic, 'xxxx', num2str(yr));
    biovolpath = regexprep(biovolpath_generic, 'xxxx', num2str(yr));
    temp = dir([classpath 'I*.mat']);
    pathall = repmat(classpath, length(temp),1);
    names = char(temp.name);
    classfiles = cellstr([pathall names]);
    pathall = repmat(biovolpath, length(temp),1);
    biovolfiles = cellstr([pathall names(:,1:21)]);
    clear temp pathall classpath

    temp = char(classfiles);
    ind = length(classpath_generic)+1;
    filelist = cellstr(temp(:,ind:ind+20));
    mdate = IFCB_file2date(filelist);

    load('\\raspberry\d_work\IFCB1\code_mar10_mvco\ml_analyzed_all', 'ml_analyzed', 'filelist_all'); %load the milliliters analyzed for all sample files

%    load('ml_analyzed_all', 'ml_analyzed', 'filelist_all');
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
    classbiovol = classcount;
    %classcount_above_optthresh = classcount;
    num2dostr = num2str(length(classfiles));
    %
    for filecount = 1:length(classfiles)
        if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end;
        [classcount(filecount,:), classbiovol(filecount,:), class2useTB] = summarize_biovol_TBclassMVCO(classfiles{filecount}, biovolfiles{filecount});
    end;
    
    classcountTB = classcount;
    classbiovolTB = classbiovol;
    ml_analyzedTB = ml_analyzed_list;
    mdateTB = mdate;
    filelistTB = filelist;

    save([resultpath 'summary_biovol_allTB' num2str(yr)] , 'class2useTB', 'classcountTB', 'classbiovolTB', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'classpath_generic', 'biovolpath_generic')
    clear *files* classcount classbiovol 
end;
