
%resultpath = '\\sosiknas1\IFCB_products\MVCO\summary\';
%classpath_generic = '\\sosiknas1\IFCB_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_mvco_Jan10-pt-uw\';
%feapath_generic = '\\sosiknas1\IFCB_products\MVCO\features\featuresxxxx_v2\';
%hdrpath = 'https://ifcb-data.whoi.edu/MVCO/';

if 0
    resultpath = '\\sosiknas1\IFCB_products\NESLTER_broadscale\summary\';
%     classpath_generic = '\\sosiknas1\IFCB_products\NESLTER_broadscale\class\v3\20210606_Dec2020_NES_1.6\';
    classpath_generic = '\\sosiknas1\IFCB_products\NESLTER_broadscale\class\v3\20220209_Jan2022_NES_2.4\';
    feapath_generic = '\\sosiknas1\IFCB_products\NESLTER_broadscale\features\';
    hdrpath = 'https://ifcb-data.whoi.edu/NESLTER_broadscale/';
    opts = delimitedTextImportOptions("NumVariables", 24);
    opts.DataLines = [2 inf];
    %opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double", "double"];
    %case with 8 tags
    opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "string", "string", "string", "string", "double", "double"];
    opts.VariableNamesLine = 1;
    myreadtable = @(filename)readtable(filename, opts);
    metaT = webread('https://ifcb-data.whoi.edu/api/export_metadata/NESLTER_broadscale', weboptions('Timeout', 60, 'ContentReader', myreadtable));
    %metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/NESLTER_broadscale', weboptions('Timeout', 180));
    %myreadtable = @(filename)readtable(filename, 'Format', '%s%s%s %f%f%f%f%f %s%s %f%s%f %s%s%s%s%s%s%s%s %f'); %case with 8 tags (for now)
    %metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/NESLTER_broadscale', weboptions('Timeout', 120, 'ContentReader', myreadtable));
end

% 
if 0 
    resultpath = '\\sosiknas1\IFCB_products\NESLTER_transect\summary\';
    classpath_generic = '\\sosiknas1\IFCB_products\NESLTER_transect\class\v3\20220209_Jan2022_NES_2.4\';
    feapath_generic = '\\sosiknas1\IFCB_products\NESLTER_transect\features\';
    opts = delimitedTextImportOptions("NumVariables", 21);
    opts.DataLines = [2 inf];
    %case with 5 tags
    opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "string", "double", "double"];
    opts.VariableNamesLine = 1;
    myreadtable = @(filename)readtable(filename, opts);
    metaT = webread('https://ifcb-data.whoi.edu/api/export_metadata/NESLTER_transect', weboptions('Timeout', 60, 'ContentReader', myreadtable));
    %myreadtable = @(filename)readtable(filename, 'Format', '%s%s%s %f%f%f%f%f %s%s %f%s%f %s%s%s%s%s %f'); %case with 5 tags
    %metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/NESLTER_transect', weboptions('Timeout', 60, 'ContentReader', myreadtable));
end
%% metaT = readtable('\\sosiknas1\IFCB_products\NESLTER_transect\NESLTER_transect.csv');
%% webread doesn't work to capture all the column variables for transect--maybe associated with some many blanks for first cruise
%% download the csv, then add blank string or Nan to top row entries
%metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/NESLTER_transect', weboptions('Timeout', 200));

% if 0 
%     resultpath = '\\sosiknas1\IFCB_products\NESLTER_transect\summary\';
%     classpath_generic = '\\sosiknas1\IFCB_products\NESLTER_transect\class\v3\20201022_NES\';
%     feapath_generic = '\\sosiknas1\IFCB_products\NESLTER_transect\features\';
%     myreadtable = @(filename)readtable(filename, 'Format', '%s%s%s %f%f%f%f%f %s%s %f%s%f %s%s%s%s%s %f'); %case with 5 tags
%     metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/NESLTER_transect', weboptions('Timeout', 60, 'ContentReader', myreadtable));
% end

if 0 
    resultpath = '\\sosiknas1\IFCB_products\OTZ\summary\';
    classpath_generic = '\\sosiknas1\IFCB_products\OTZ\class\v3\20210606_Dec2020_NES_1.6\';
    feapath_generic = '\\sosiknas1\IFCB_products\OTZ\features\';
    %myreadtable = @(filename)readtable(filename, 'Format', '%s%s%s %f%f%f%f%f %s%s %f%s%f %s%s%s%s%s %f'); %case with 5 tags
    %metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/OTZ_Atlantic', weboptions('Timeout', 60, 'ContentReader', myreadtable));
    metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/OTZ_Atlantic');
end

if 0
    resultpath = '\\sosiknas1\IFCB_products\SPIROPA\summary\';
    classpath_generic = '\\sosiknas1\IFCB_products\SPIROPA\class\v3\20220209_Jan2022_NES_2.4\';
    feapath_generic = '\\sosiknas1\IFCB_products\SPIROPA\features\';
  %  myreadtable = @(filename)readtable(filename, 'Format', '%s%s%s %f%f%f%f%f %s%s %f%s%f %s%s%s%s%s %f'); %case with 5 tags
    opts = delimitedTextImportOptions("NumVariables", 20);
    opts.DataLines = [2 inf];
    opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double", "double"];
    opts.VariableNamesLine = 1;
    myreadtable = @(filename)readtable(filename, opts); %
    metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/SPIROPA', weboptions('Timeout', 60, 'ContentReader', myreadtable));
end

%
mvco_flag = 0;
pidlist_flag = 1;
if 1
    resultpath = '\\sosiknas1\IFCB_products\MVCO\summary_v4\';
    %classpath_generic = '\\sosiknas1\IFCB_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_SPIROPA__Jan10_8020_seeded_iv3_pt_nn_xyto_min20\';
    classpath_generic = '\\sosiknas1\IFCB_products\MVCO\class\v3\20220209_Jan2022_NES_2.4\';
    %feapath_generic = '\\sosiknas1\IFCB_products\MVCO\features\featuresxxxx_v2\';
    feapath_generic = '\\sosiknas1\IFCB_products\MVCO\features_v4\';
    %metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/mvco', weboptions('Timeout', 60));
    opts = delimitedTextImportOptions("NumVariables", 20);
    opts.DataLines = [2 inf];
    %case 4 tags
    opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double", "double"];
    opts.VariableNamesLine = 1;
    myreadtable = @(filename)readtable(filename, opts); %
    metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/mvco', weboptions('Timeout', 60, 'ContentReader', myreadtable));
    mvco_flag = 1;
    pidlist_flag = 0;
end

if 0 %EXPORTS 2018
  resultpath = '\\sosiknas1\IFCB_products\EXPORTS\summary\';
%  classpath_generic = '\\sosiknas1\IFCB_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_EXPORTS__Jan10_8020_seeded_iv3_pt_nn_xyto_min20\';
%  classpath_generic = '\\vortex\omics\sosik\run-output\EXPORTS_run\v3\20201030_EXPORTS\';
  classpath_generic = '\\sosiknas1\IFCB_products\EXPORTS\class\v3\20220225_EXPORTS_pacific_Dec2021_1_3\';
  feapath_generic = '\\sosiknas1\IFCB_products\EXPORTS\features\';
    opts = delimitedTextImportOptions("NumVariables", 20);
    opts.DataLines = [2 inf];
    opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double", "double"];
    opts.VariableNamesLine = 1;
    myreadtable = @(filename)readtable(filename, opts); %w
    metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/EXPORTS', weboptions('Timeout', 60, 'ContentReader', myreadtable));
    %  myreadtable = @(filename)readtable(filename, 'Format', '%s%s%s %f%f%f%f%f %s%s %f%s%f %s%s%s%s %f%f', 'HeaderLines', 1,'ReadVariableNames', true); %case with 4 tags, 1 comment summary
    %metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/EXPORTS', weboptions('Timeout', 60));
end

if 0 %EXPORTS 2021
  resultpath = '\\sosiknas1\IFCB_products\EXPORTS\summary\';
  classpath_generic = '\\sosiknas1\IFCB_products\EXPORTS\class\v3\20220209_Jan2022_NES_2.4_RELABELED\';
  feapath_generic = '\\sosiknas1\IFCB_products\EXPORTS\features\';
  %myreadtable = @(filename)readtable(filename, 'Format', '%s%s%s %f%f%f%f%f%s%s %f%s%f %s%s%s %f'); %case with 3 tags
  %metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/EXPORTS', weboptions('Timeout', 60));
    opts = delimitedTextImportOptions("NumVariables", 20);
    opts.DataLines = [2 inf];
    opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double", "double"];
    opts.VariableNamesLine = 1;
    myreadtable = @(filename)readtable(filename, opts); %
    metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/EXPORTS', weboptions('Timeout', 60, 'ContentReader', myreadtable));
end

if 0
    resultpath = '\\sosiknas1\IFCB_products\SIO_Delmar_mooring\summary\';
    classpath_generic = '\\sosiknas1\IFCB_products\SIO_Delmar_mooring\class\v3\20220416_Delmar_NES_1\';
    feapath_generic = '\\sosiknas1\IFCB_products\SIO_Delmar_mooring\features_v4\';
    metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/SIO_Delmar_mooring', weboptions('Timeout', 30));
end
%%
adhocthresh = 0.5;
% optimal thresholds:
% list classes and corresponding statistic you'd like to use the opt-thresh
% in rows of a cell array. class = col 1, stat = col 2, i.e.
% classes not specified here are set to use 'prec-rec' below...
classXstat = {'Guinardia_delicatula', 'f1'; ...
    'Guinardia_delicatula_TAG_internal_parasite', 'f1'};
% load up the optthreshXstatXclass:
load("\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\opt_threshXstatisticXclass.mat")
for yr = 2015:2015
    ystr = ['D' num2str(yr)];
    classpath = [classpath_generic filesep ystr filesep];
    feapath = [feapath_generic ystr filesep];
    %temp = dir([classpath 'D' num2str(yr) '*.h5']);
    temp = dir([classpath ystr '*']);
    temp = {temp([temp.isdir]).name};
    pathall = []; pathall2 = [];
    names = {};
    if mvco_flag
       feapath_base = regexprep(feapath_generic, 'xxxx', num2str(yr));
    end
    for ii = 1:length(temp)
        pathnow = [classpath temp{ii} filesep];
        pathnow2 = [feapath temp{ii} filesep];
        temp2 = dir([pathnow '*.h5']);
        pathall = [pathall; repmat(pathnow, length(temp2),1)];
        pathall2 = [pathall2; repmat(pathnow2, length(temp2),1)];
        names = [names; {temp2.name}'];
    end
    
    classfiles = strcat(pathall, names);
   % pathall = strcat(feapath_generic, names(:,1:5), filesep, names(:,1:9), filesep);
    if ~mvco_flag
        feafiles = strcat(pathall2, regexprep(names, '_class.h5', '_fea_v4.csv'));
        %xall = repmat('_fea_v4.csv', length(names),1);
        %ii = strmatch('D', names);
        %feafiles(ii) = strcat(pathall(ii,:), regexprep(names(ii), '_class.h5', '_fea_v4.csv'));
        %ii = strmatch('I', names);
        %feafiles(ii) = cellstr([pathall(ii,:) names(ii,1:21) xall(ii,:)]);        
        clear temp* pathall* classpath xall 
    else
       % xall = repmat('_fea_v4.csv', length(names),1);
        ii = strmatch('D', names);
        names_temp = char(names{ii});
        if ~isempty(ii)
%            feafiles(ii) = cellstr( strcat(feapath_base, names_temp(:,1:24), xall(ii,:)));
             feafiles(ii) = cellstr( strcat(feapath_generic, ystr, filesep, names_temp(:,1:9),filesep, char(regexprep(names(ii),'class.h5', 'fea_v4.csv'))));
        end
        ii = strmatch('I', names);
        names_temp = char(names{ii});
        if ~isempty(ii)
            %feafiles(ii) = cellstr( strcat(feapath_base, names_temp(:,1:21), xall(ii,:)));      
            feafiles(ii) = cellstr( strcat(feapath_generic, ystr, filesep, names_temp(:,1:14),filesep, char(regexprep(names(ii),'class.h5', 'fea_v4.csv'))));
        end
        clear temp* pathall classpath xall 
    end
    
    %%%%CHECK
    %temp = char(classfiles);
    %ind = length(classpath_generic)+18;
    %filelist = cellstr(temp(:,ind:ind+23));
    %clear temp

    filelist = regexprep(cellstr(names), '_class.h5', '');
    clear names
    
    [~,a,b] = intersect(filelist, metaT.pid);
    clear meta_data, meta_data(a,:) = metaT(b,:); 
    ind = find(meta_data.ifcb ==0);
    meta_data(ind,:) = []; %omit any files not in dashboard table
    mdate = datenum(meta_data.sample_time, 'yyyy-mm-dd HH:MM:ss+00:00');
    [~,ind] = setdiff(filelist,meta_data.pid);
    classfiles(ind) = [];
    filelist(ind) = [];
    feafiles(ind) = []; 
    
    classTable = load_class_scores(classfiles{1});
    class2use = deblank(classTable.class_labels); 
%     dylans addition Sep 2022
    optthresh = ones(1, length(class2use)); % start with ones to make classes that aren't specified explicitly useless
    for i = 1:size(class2use, 1)

        cc = class2use{i}; % class name
        cmatch = strrep(cc, '_TAG_', 'TAG');
        cmatch = strrep(cmatch, '_', ' ');
    
        if any(ismember(classXstat, cc), "all")
            % grab opt thresh specified in classXstat
            ss = classXstat{ismember(classXstat(:,1),cc),2}; % statistic
            oo = optXstatXclass(ss , cmatch); % opt thresh value
            optthresh(i) = table2array(oo);
        elseif ~any(ismember(optXstatXclass.Properties.VariableNames, cmatch))
            % validation not available for this class. opt thresh = 1
            optthresh(i) = nan;
        else
            % grab opt thresh for prec-rec
            oo = optXstatXclass("prec-rec", cmatch);
            optthresh(i) = table2array(oo);
        end

    end

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
    if ~pidlist_flag
        classPidList = cell(size(classcount));
    end
    classFeaList_variables = {'ESD' 'maxFeretDiameter' 'summedMajorAxis' 'representativeWidth' 'summedArea' 'summedSurfaceArea' 'summedBiovolume' 'cellC'  'numBlobs' 'pmtA' 'pmtB' 'pmtC' 'pmtD' 'peakA' 'peakB' 'peakC' 'peakD' 'TimeOfFlight' 'roi_numbers' 'score'};
    
    %%
    for filecount = 1:length(classfiles)
        if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end
        if exist( feafiles{filecount}, 'file')
            if pidlist_flag
                [classcount(filecount,:), classbiovol(filecount,:), classC(filecount,:), classcount_above_optthresh(filecount,:), classbiovol_above_optthresh(filecount,:), classC_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), classbiovol_above_adhocthresh(filecount,:), classC_above_adhocthresh(filecount,:), class2useTB, classFeaList(filecount,:), classPidList(filecount,:)] = summarize_biovol_class_h5(classfiles{filecount}, feafiles{filecount}, adhocthresh, optthresh, pidlist_flag);
            else
                [classcount(filecount,:), classbiovol(filecount,:), classC(filecount,:), classcount_above_optthresh(filecount,:), classbiovol_above_optthresh(filecount,:), classC_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), classbiovol_above_adhocthresh(filecount,:), classC_above_adhocthresh(filecount,:), class2useTB, classFeaList(filecount,:), classPidList] = summarize_biovol_class_h5(classfiles{filecount}, feafiles{filecount}, adhocthresh, optthresh, pidlist_flag);
            end
            %temp MVCO old features
         % %   [classcount(filecount,:), classbiovol(filecount,:), classC(filecount,:), classcount_above_optthresh(filecount,:), classbiovol_above_optthresh(filecount,:), classC_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), classbiovol_above_adhocthresh(filecount,:), classC_above_adhocthresh(filecount,:), class2useTB, classFeaList(filecount,:), classPidList(filecount,:)] = summarize_biovol_class_h5_mvco_temp(classfiles{filecount}, feafiles{filecount}, adhocthresh);
         % %skip classPidList, classFeaList
          %  [classcount(filecount,:), classbiovol(filecount,:), classC(filecount,:), classcount_above_optthresh(filecount,:), classbiovol_above_optthresh(filecount,:), classC_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), classbiovol_above_adhocthresh(filecount,:), classC_above_adhocthresh(filecount,:), class2useTB, classFeaList(filecount,:), classPidList(filecount,:)] = summarize_biovol_class_h5_mvco_temp(classfiles{filecount}, feafiles{filecount}, adhocthresh);
        else
            disp(['skipping, no feature file: ' feafiles{filecount}])
        end                
    end
    %%
    if ~exist(resultpath, 'dir')
        mkdir(resultpath)
    end
    %save([resultpath 'summary_biovol_allTB' num2str(yr)] , 'class2useTB', 'classcountTB', 'classbiovolTB', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'classpath_generic', 'feapath_generic')
    
    %save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr)] , 'class2use', 'classcount*', 'classbiovol*', 'classC*', 'ml_analyzed', 'mdate', 'filelist', 'classpath_generic', 'feapath_generic')
    save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr)] , 'class2use', 'classcount*', 'classbiovol*', 'classC*', 'meta_data', 'mdate', 'filelist', 'classpath_generic', 'feapath_generic', 'adhocthresh', 'classXstat', 'optthresh')
    save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'lists'] , 'class2use', 'filelist', 'classpath_generic', 'feapath_generic', 'classFeaList*', '-v7.3')
    disp('results saved: ')
    disp([resultpath 'summary_biovol_allHDF_min20_' num2str(yr)])
    disp([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'lists'])
    if pidlist_flag 
        save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'list_pid'] , 'class2use', 'filelist', 'classpath_generic', 'feapath_generic', 'classPidList', '-v7.3')
        disp([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'lists_pid'])
    end
    
    clear *files* classcount* classbiovol* classC* meta_data mdate class*List
end
clear summarize_biovol_class_h5 %clear the summarize function to clear the persistent variables