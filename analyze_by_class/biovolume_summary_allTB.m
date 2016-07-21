% resultpath = '\\sosiknas1\IFCB_products\IFCB101_OkeanosExplorerNov2013\class\summary\';
% classpath_generic = '\\sosiknas1\IFCB_products\IFCB101_OkeanosExplorerNov2013\class\classxxxx_v1\';
% feapath_generic = '\\sosiknas1\IFCB_products\IFCB101_OkeanosExplorerNov2013\features\featuresxxxx_v2\';
% %feapath_generic = '\\sosiknas1\IFCB_products\IFCB101_OkeanosExplorerNov2013\features\';
% hdrpath = 'http://ifcb-data.whoi.edu/IFCB101_OkeanosExplorerNov2013/';

resultpath = '\\sosiknas1\IFCB_products\IFCB102_PiscesNov2014\class\summary\';
classpath_generic = '\\sosiknas1\IFCB_products\IFCB102_PiscesNov2014\class\classxxxx_v1\';
feapath_generic = '\\sosiknas1\IFCB_products\IFCB102_PiscesNov2014\features\';
hdrpath = 'http://ifcb-data.whoi.edu/IFCB102_PiscesNov2014/';

for yr = 2014:2014, %:2012,
    classpath = regexprep(classpath_generic, 'xxxx', num2str(yr));
    feapath = regexprep(feapath_generic, 'xxxx', num2str(yr));
    temp = dir([classpath 'D*.mat']);
    pathall = repmat(classpath, length(temp),1);
    names = char(temp.name);
    classfiles = cellstr([pathall names]);
    pathall = repmat(feapath, length(temp),1);
    xall = repmat('_fea_v2.csv', length(temp),1);
    feafiles = cellstr([pathall names(:,1:24) xall]);
    clear temp pathall classpath xall

    temp = char(classfiles);
    ind = length(classpath_generic)+1;
    filelist = cellstr(temp(:,ind:ind+23));
    mdate = IFCB_file2date(filelist);
    
    pathall = repmat(hdrpath, length(temp),1);
    xall = repmat('.hdr', length(temp),1);
    filelist = cellstr([pathall temp(:,ind:ind+23) xall]);
    ml_analyzed = IFCB_volume_analyzed(filelist); 
    
    temp = load(classfiles{1}, 'class2useTB');
    class2use = temp.class2useTB; clear temp classfilestr
    classcount = NaN(length(classfiles),length(class2use));
    classbiovol = classcount;
    %classcount_above_optthresh = classcount;
    num2dostr = num2str(length(classfiles));
    %
    for filecount = 1:length(classfiles)
        if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end;
        [classcount(filecount,:), classbiovol(filecount,:), class2useTB] = summarize_biovol_TBclassMVCO(classfiles{filecount}, feafiles{filecount});
    end;
    
    classcountTB = classcount;
    classbiovolTB = classbiovol;
    ml_analyzedTB = ml_analyzed;
    mdateTB = mdate;
    filelistTB = filelist;
    if ~exist(resultpath, 'dir')
        mkdir(resultpath)
    end
    save([resultpath 'summary_biovol_allTB' num2str(yr)] , 'class2useTB', 'classcountTB', 'classbiovolTB', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'classpath_generic', 'feapath_generic')
    clear *files* classcount classbiovol 
end
