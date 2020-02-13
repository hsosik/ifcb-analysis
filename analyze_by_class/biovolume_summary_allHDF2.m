%resultpath = '\\sosiknas1\IFCB_products\NESLTER_transect\summary\';
%classpath_generic = '\\sosiknas1\IFCB_products\NESLTER_transect\class\classxxxx_v1\';
%feapath_generic = '\\sosiknas1\IFCB_products\NESLTER_transect\features\featuresxxxx_v4\';
%hdrpath = 'https://ifcb-data.whoi.edu/NESLTER_transect/';

%resultpath = '\\sosiknas1\IFCB_products\MVCO\summary\';
%classpath_generic = '\\sosiknas1\IFCB_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_mvco_Jan10-pt-uw\';
%feapath_generic = '\\sosiknas1\IFCB_products\MVCO\features\featuresxxxx_v2\';
%hdrpath = 'https://ifcb-data.whoi.edu/MVCO/';

resultpath = '\\sosiknas1\IFCB_products\NESLTER_broadscale\summary\';
%classpath_generic = '\\sosiknas1\IFCB_products\NESLTER_broadscale\class\classxxxx_v1\';
classpath_generic = '\\sosiknas1\ifcb_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_BROADSCALE__Jan10_8020_seeded_iv3_pt_nn_xyto_min20\';
feapath_generic = '\\sosiknas1\IFCB_products\NESLTER_broadscale\features\';
hdrpath = 'https://ifcb-data.whoi.edu/NESLTER_broadscale/';

adhocthresh = 0.5;

for yr = 2015:2015 %:2012,
    classpath = classpath_generic;
    temp = dir([classpath 'D' num2str(yr) '*.h5']);
    pathall = repmat(classpath, length(temp),1);
    names = char(temp.name);
    classfiles = cellstr([pathall names]);
    pathall = strcat(feapath_generic, names(:,1:5), filesep, names(:,1:9), filesep);
    xall = repmat('_fea_v4.csv', length(temp),1);
    ii = strmatch('D', names);
    feafiles(ii) = cellstr([pathall(ii,:) names(ii,1:24) xall(ii,:)]);
    ii = strmatch('I', names);
    feafiles(ii) = cellstr([pathall(ii,:) names(ii,1:21) xall(ii,:)]);
    clear temp pathall classpath xall

    temp = char(classfiles);
    ind = length(classpath_generic)+1;
    filelist = cellstr(temp(:,ind:ind+23));
    mdate = IFCB_file2date(filelist);
    
    pathall = repmat(hdrpath, size(temp,1),1);
    xall = repmat('.hdr', size(temp,1),1);
    temp = cellstr([pathall temp(:,ind:inds+23) xall]);
 %   ml_analyzed = IFCB_volume_analyzed(temp); 
    ml_analyzed = NaN;
    
    [~, ~, ~, class2use] = load_class_scores(classfiles{1});
    class2use = deblank(class2use); 
    classcount = NaN(length(classfiles),length(class2use));
    classbiovol = classcount;
    num2dostr = num2str(length(classfiles));
    %
    for filecount = 1:length(classfiles)
        if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end
        [classcount(filecount,:), classbiovol(filecount,:), classC(filecount,:), classcount_above_optthresh(filecount,:), classbiovol_above_optthresh(filecount,:), classC_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), classbiovol_above_adhocthresh(filecount,:), classC_above_adhocthresh(filecount,:), class2useTB] = summarize_biovol_classMVCO_h5(classfiles{filecount}, feafiles{filecount}, adhocthresh);
    end
    
    %classcountTB = classcount;
    %classcountTB_above_optthresh = classcount_above_optthresh;
    %classcountTB_above_optthresh = classcount_above_adhocthresh;
    %classbiovolTB = classbiovol;
    %classbiovolTB_above_optthresh = classbiovol_above_optthresh;
    %classbiovolTB_above_optthresh = classbiovol_above_adhocthresh;
    %classC_TB = classC;
    %classC_TB_above_optthresh = classC_above_optthresh;
    %classC_TB_above_optthresh = classC_above_adhocthresh;
    
    %ml_analyzedTB = ml_analyzed;
    %mdateTB = mdate;
    %filelistTB = filelist;
    if ~exist(resultpath, 'dir')
        mkdir(resultpath)
    end
    %save([resultpath 'summary_biovol_allTB' num2str(yr)] , 'class2useTB', 'classcountTB', 'classbiovolTB', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'classpath_generic', 'feapath_generic')
    save([resultpath 'summary_biovol_allHDF' num2str(yr)] , 'class2use', 'classcount*', 'classbiovol*', 'classC_*', 'ml_analyzed', 'mdate', 'filelist', 'classpath_generic', 'feapath_generic')
    clear *files* classcount* classbiovol* classC* 
end
