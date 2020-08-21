
%resultpath = '\\sosiknas1\IFCB_products\MVCO\summary\';
%classpath_generic = '\\sosiknas1\IFCB_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_mvco_Jan10-pt-uw\';
%feapath_generic = '\\sosiknas1\IFCB_products\MVCO\features\featuresxxxx_v2\';
%hdrpath = 'https://ifcb-data.whoi.edu/MVCO/';

% resultpath = '\\sosiknas1\IFCB_products\NESLTER_broadscale\summary\';
% classpath_generic = '\\sosiknas1\ifcb_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_BROADSCALE__Jan10_8020_seeded_iv3_pt_nn_xyto_min20\';
% feapath_generic = '\\sosiknas1\IFCB_products\NESLTER_broadscale\features\';
% hdrpath = 'https://ifcb-data.whoi.edu/NESLTER_broadscale/';
% metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/NESLTER_broadscale', weboptions('Timeout', 180));

% 
%resultpath = '\\sosiknas1\IFCB_products\NESLTER_transect\summary\';
%classpath_generic = '\\sosiknas1\ifcb_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_TRANSECT__Jan10_8020_seeded_iv3_pt_nn_xyto_min20\';
%feapath_generic = '\\sosiknas1\IFCB_products\NESLTER_transect\features\';
%% metaT = readtable('\\sosiknas1\IFCB_products\NESLTER_transect\NESLTER_transect.csv');
%% webread doesn't work to capture all the column variables for transect--maybe associated with some many blanks for first cruise
%% download the csv, then add blank string or Nan to top row entries
%metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/NESLTER_transect', weboptions('Timeout', 200));
%myreadtable = @(filename)readtable(filename, 'Format', '%s%s%s %f%f%f%f%f %s%s %f%s%f %s%s%s%s%s %f'); %case with 5 tags
%metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/NESLTER_transect', weboptions('Timeout', 60, 'ContentReader', myreadtable));

% %
 resultpath = '\\sosiknas1\IFCB_products\SPIROPA\summary\';
 classpath_generic = '\\sosiknas1\IFCB_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_SPIROPA__Jan10_8020_seeded_iv3_pt_nn_xyto_min20\';
 feapath_generic = '\\sosiknas1\IFCB_products\SPIROPA\features\';
 metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/SPIROPA', weboptions('Timeout', 30));

%resultpath = '\\sosiknas1\IFCB_products\EXPORTS\summary\';
%classpath_generic = '\\sosiknas1\IFCB_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_EXPORTS__Jan10_8020_seeded_iv3_pt_nn_xyto_min20\';
%feapath_generic = '\\sosiknas1\IFCB_products\EXPORTS\features\';
%%%metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/EXPORTS', weboptions('Timeout', 30));
%myreadtable = @(filename)readtable(filename, 'Format', '%s%s%s %f%f%f%f%f%s%s %f%s%f %s%s%s %f'); %case with 3 tags
%metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/EXPORTS', weboptions('Timeout', 60, 'ContentReader', myreadtable));

%resultpath = '\\sosiknas1\IFCB_products\SIO_Delmar_mooring\summary\';
%classpath_generic = '\\sosiknas1\IFCB_products\SIO_Delmar_mooring\class_v2\';
%feapath_generic = '\\sosiknas1\IFCB_products\SIO_Delmar_mooring\features\';
%metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/SIO_Delmar_mooring', weboptions('Timeout', 30));

adhocthresh = 0.5;

for yr = 2019:2019 %:2012,
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
    %mdate = IFCB_file2date(filelist);
    %pathall = repmat(hdrpath, size(temp,1),1);
    %xall = repmat('.hdr', size(temp,1),1);
    %temp = cellstr([pathall temp(:,ind:ind+23) xall]);
    %f = [resultpath 'ml_analyzed' num2str(yr) '.mat'];
    %if exist(f, 'file')
    %    load(f)
    %else
    %    ml_analyzed = IFCB_volume_analyzed(temp); 
    %    save(f, 'ml_analyzed')
    %end
    %ml_analyzed = NaN(size(filelist));
    %[~,a,b] = intersect(filelist, meta.pid);
    %ml_analyzed(a) = meta.ml_analyzed(b);    
    
    [~,a,b] = intersect(filelist, metaT.pid);
    meta_data(a,:) = metaT(b,:); 
    mdate = datenum(meta_data.sample_time, 'yyyy-mm-dd HH:MM:ss+00:00');
    
    [~, ~, ~, class2use] = load_class_scores(classfiles{1});
    class2use = deblank(class2use); 
    classcount = NaN(length(classfiles),length(class2use));
    classbiovol = classcount;
    classC = classcount;
    classcount_above_optthresh = classcount;
    classbiovol_above_optthresh = classcount;
    classC_above_optthresh = classcount;
    classcount_above_adhocthresh = classcount;
    classbiovol_above_adhocthresh = classcount;
    classC_above_adhocthresh = classcount;
    num2dostr = num2str(length(classfiles));
    classFeaList = cell(size(classcount));
    classPidList = cell(size(classcount));
    classFeaList_variables = {'ESD' 'maxFeretDiameter' 'summedMajorAxis' 'pmtA' 'pmtB' 'pmtC' 'pmtD' 'peakA' 'peakB' 'peakC' 'peakD' 'TimeOfFlight' 'score'};
    
    %
    for filecount = 1:length(classfiles)
        if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end
        [classcount(filecount,:), classbiovol(filecount,:), classC(filecount,:), classcount_above_optthresh(filecount,:), classbiovol_above_optthresh(filecount,:), classC_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), classbiovol_above_adhocthresh(filecount,:), classC_above_adhocthresh(filecount,:), class2useTB, classFeaList(filecount,:), classPidList(filecount,:)] = summarize_biovol_class_h5(classfiles{filecount}, feafiles{filecount}, adhocthresh);
    end
    
    if ~exist(resultpath, 'dir')
        mkdir(resultpath)
    end
    %save([resultpath 'summary_biovol_allTB' num2str(yr)] , 'class2useTB', 'classcountTB', 'classbiovolTB', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'classpath_generic', 'feapath_generic')
    
    %save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr)] , 'class2use', 'classcount*', 'classbiovol*', 'classC*', 'ml_analyzed', 'mdate', 'filelist', 'classpath_generic', 'feapath_generic')
    save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr)] , 'class2use', 'classcount*', 'classbiovol*', 'classC*', 'meta_data', 'mdate', 'filelist', 'classpath_generic', 'feapath_generic')
    save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'lists'] , 'class2use', 'filelist', 'classpath_generic', 'feapath_generic', 'classFeaList*', 'classPidList')
    disp('results saved: ')
    disp([resultpath 'summary_biovol_allHDF_min20_' num2str(yr)])
    disp([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'lists'])
        
    clear *files* classcount* classbiovol* classC* meta_data mdate class*List
end
