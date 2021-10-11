resultpath = '\\sosiknas1\IFCB_products\MVCO\class\summary\';
classpath_generic = '\\sosiknas1\IFCB_products\MVCO\class\classxxxx_v1\';
feapath_generic = '\\sosiknas1\IFCB_products\MVCO\features\featuresxxxx_v2\';

metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/mvco', weboptions('Timeout', 120));

for yr = 2017 %2009,2010,2012 needs redoing
    classpath = regexprep(classpath_generic, 'xxxx', num2str(yr));
    feapath = regexprep(feapath_generic, 'xxxx', num2str(yr));
    temp = [dir([classpath 'I*.mat']); dir([classpath 'D*.mat'])];
%    pathall = repmat(classpath, length(temp),1);
%    names = char(temp.name);
%    classfiles = cellstr([pathall names]);
%    pathall = repmat(feapath, length(temp),1);
%    xall = repmat('_fea_v2.csv', length(temp),1);
%    feafiles = cellstr([pathall names(:,1:21) xall]);
%    clear temp pathall classpath xall

   classfiles = strcat(classpath, {temp.name});
  %  temp = char(classfiles);
  %  ind = length(classpath_generic)+1;
%    filelist = cellstr(temp(:,ind:ind+20));
   %filelist = cellstr(temp(:,ind:end));
   filelist = regexprep({temp.name}, '_class_v1.mat', '');
   feafiles = strcat(feapath, filelist, '_fea_v2.csv');

%    mdate = IFCB_file2date(filelist);
     [~,a,b] = intersect(filelist, metaT.pid);
    meta_data(a,:) = metaT(b,:); 
    ind = find(meta_data.ifcb ==0);
%    mdate = datenum(meta_data.sample_time, 'yyyy-mm-dd HH:MM:ss+00:00');
    ml_analyzed = meta_data.ml_analyzed;
    mdate = IFCB_file2date(filelist);
    
%    load('\\sosiknas1\IFCB_products\MVCO\ml_analyzed\ml_analyzed_all', 'ml_analyzed', 'filelist_all'); %load the milliliters analyzed for all sample files
%    [~,ia, ib] = intersect(filelist, filelist_all);
%    if length(ia) ~= length(filelist)
%        disp('missing some ml_analyzed values; need to make updated ml_analyzed all.mat?')
%        pause
%    end
%    temp = NaN(size(filelist));
%    temp(ia) = ml_analyzed(ib);
%    ml_analyzed_list = temp;
%    clear ml_analyzed filelist_all temp ia ib 

    temp = load(classfiles{1}, 'class2useTB');
    class2use = temp.class2useTB; clear temp classfilestr
    classcount = NaN(length(classfiles),length(class2use));
    classbiovol = classcount;
    %classcount_above_optthresh = classcount;
    num2dostr = num2str(length(classfiles));
    adhocthresh = 0.5.*ones(size(class2use)-1); %leave off 1 for unclassified
    adhocthresh(strmatch('Laboea', class2use, 'exact')) = 0.7; %example to change a specific class
    adhocthresh(strmatch('tintinnid', class2use, 'exact')) = 0.5;
    adhocthresh(strmatch('Myrionecta', class2use, 'exact')) = 0.3;
    %
    for filecount = 1:length(classfiles)
        if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end;
        %[classcount(filecount,:), classbiovol(filecount,:), class2useTB] = summarize_biovol_TBclassMVCO(classfiles{filecount}, feafiles{filecount});
        [classcount(filecount,:), classbiovol(filecount,:), classC(filecount,:), classcount_above_optthresh(filecount,:), classbiovol_above_optthresh(filecount,:), classC_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), classbiovol_above_adhocthresh(filecount,:), classC_above_adhocthresh(filecount,:), class2useTB] = summarize_biovol_TBclassMVCO(classfiles{filecount}, feafiles{filecount}, adhocthresh);
    end
    
    classcountTB = classcount;
    classcountTB_above_optthresh = classcount_above_optthresh;
    classcountTB_above_adhocthresh = classcount_above_adhocthresh;
    classbiovolTB = classbiovol;
    classbiovolTB_above_optthresh = classbiovol_above_optthresh;
    classbiovolTB_above_adhocthresh = classbiovol_above_adhocthresh;
    classC_TB = classC;
    classC_TB_above_optthresh = classC_above_optthresh;
    classC_TB_above_adhocthresh = classC_above_adhocthresh;
    
    %ml_analyzedTB = ml_analyzed_list;
    ml_analyzedTB = ml_analyzed;
    mdateTB = mdate;
    filelistTB = filelist;
    if ~exist(resultpath, 'dir')
        mkdir(resultpath)
    end
%
       
 %   save([resultpath 'summary_biovol_allTB' num2str(yr)] , 'class2useTB', 'classcountTB', 'classbiovolTB', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'classpath_generic', 'feapath_generic')
    save([resultpath 'summary_biovol_allTB' num2str(yr)] , 'class2useTB', 'classcountTB*', 'classbiovolTB*', 'classC_TB*', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'classpath_generic', 'feapath_generic', 'adhocthresh')
    clear *files* classcount* classbiovol* classC* 
end
