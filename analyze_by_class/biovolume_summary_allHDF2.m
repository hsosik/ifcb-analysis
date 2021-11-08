
%resultpath = '\\sosiknas1\IFCB_products\MVCO\summary\';
%classpath_generic = '\\sosiknas1\IFCB_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_mvco_Jan10-pt-uw\';
%feapath_generic = '\\sosiknas1\IFCB_products\MVCO\features\featuresxxxx_v2\';
%hdrpath = 'https://ifcb-data.whoi.edu/MVCO/';

if 0
    resultpath = '\\sosiknas1\IFCB_products\NESLTER_broadscale\summary\';
    classpath_generic = '\\sosiknas1\IFCB_products\NESLTER_broadscale\class\v3\20210606_Dec2020_NES_1.6\';
    feapath_generic = '\\sosiknas1\IFCB_products\NESLTER_broadscale\features\';
    hdrpath = 'https://ifcb-data.whoi.edu/NESLTER_broadscale/';
    opts = delimitedTextImportOptions("NumVariables", 24);
    opts.DataLines = [2 inf];
    %opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double", "double"];
    %case with 7 tags
    opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "string", "string", "string", "double", "double"];
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
    classpath_generic = '\\sosiknas1\IFCB_products\NESLTER_transect\class\v3\20210606_Dec2020_NES_1.6\';
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
    classpath_generic = '\\sosiknas1\IFCB_products\SPIROPA\class\v3\20210606_Dec2020_NES_1.6\';
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
if 1
    resultpath = '\\sosiknas1\IFCB_products\MVCO\summary_v4\';
    %classpath_generic = '\\sosiknas1\IFCB_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_SPIROPA__Jan10_8020_seeded_iv3_pt_nn_xyto_min20\';
    classpath_generic = '\\sosiknas1\IFCB_products\MVCO\class\v3\20210606_Dec2020_NES_1.6\';
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
end

if 0 %EXPORTS 2018
  resultpath = '\\sosiknas1\IFCB_products\EXPORTS\summary\';
%  classpath_generic = '\\sosiknas1\IFCB_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_EXPORTS__Jan10_8020_seeded_iv3_pt_nn_xyto_min20\';
%  classpath_generic = '\\vortex\omics\sosik\run-output\EXPORTS_run\v3\20201030_EXPORTS\';
  classpath_generic = '\\sosiknas1\IFCB_products\EXPORTS\class\v3\20201102_EXPORTS\';
  feapath_generic = '\\sosiknas1\IFCB_products\EXPORTS\features\';
    opts = delimitedTextImportOptions("NumVariables", 20);
    opts.DataLines = [2 inf];
    opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double", "double"];
    opts.VariableNamesLine = 1;
    myreadtable = @(filename)readtable(filename, opts); %
    metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/EXPORTS', weboptions('Timeout', 60, 'ContentReader', myreadtable));
    %  myreadtable = @(filename)readtable(filename, 'Format', '%s%s%s %f%f%f%f%f %s%s %f%s%f %s%s%s%s %f%f', 'HeaderLines', 1,'ReadVariableNames', true); %case with 4 tags, 1 comment summary
    %metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/EXPORTS', weboptions('Timeout', 60));
end

if 0 %EXPORTS 2021
  resultpath = '\\sosiknas1\IFCB_products\EXPORTS\summary\';
  classpath_generic = '\\sosiknas1\IFCB_products\EXPORTS\class\v3\20210606_Dec2020_NES_1.6\';
  feapath_generic = '\\sosiknas1\IFCB_products\EXPORTS\features\';
  %myreadtable = @(filename)readtable(filename, 'Format', '%s%s%s %f%f%f%f%f%s%s %f%s%f %s%s%s %f'); %case with 3 tags
  %metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/EXPORTS', weboptions('Timeout', 60));
    opts = delimitedTextImportOptions("NumVariables", 21);
    opts.DataLines = [2 inf];
    opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double", "double"];
    opts.VariableNamesLine = 1;
    myreadtable = @(filename)readtable(filename, opts); %
    metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/EXPORTS', weboptions('Timeout', 60, 'ContentReader', myreadtable));
end

%resultpath = '\\sosiknas1\IFCB_products\SIO_Delmar_mooring\summary\';
%classpath_generic = '\\sosiknas1\IFCB_products\SIO_Delmar_mooring\class_v2\';
%feapath_generic = '\\sosiknas1\IFCB_products\SIO_Delmar_mooring\features\';
%metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/SIO_Delmar_mooring', weboptions('Timeout', 30));

%%
adhocthresh = 0.5;

for yr = 2006:2011
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
            feafiles(ii) = cellstr( strcat(feapath_base, names_temp(:,1:24), xall(ii,:)));
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
    classFeaList_variables = {'ESD' 'maxFeretDiameter' 'summedMajorAxis' 'representativeWidth' 'summedSurfaceArea' 'summedBiovolume' 'cellC'  'numBlobs' 'pmtA' 'pmtB' 'pmtC' 'pmtD' 'peakA' 'peakB' 'peakC' 'peakD' 'TimeOfFlight' 'score'};
    
    %%
    for filecount = 1:length(classfiles)
        if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end
        if exist( feafiles{filecount}, 'file')
            [classcount(filecount,:), classbiovol(filecount,:), classC(filecount,:), classcount_above_optthresh(filecount,:), classbiovol_above_optthresh(filecount,:), classC_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), classbiovol_above_adhocthresh(filecount,:), classC_above_adhocthresh(filecount,:), class2useTB, classFeaList(filecount,:), classPidList(filecount,:)] = summarize_biovol_class_h5(classfiles{filecount}, feafiles{filecount}, adhocthresh);
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
    save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr)] , 'class2use', 'classcount*', 'classbiovol*', 'classC*', 'meta_data', 'mdate', 'filelist', 'classpath_generic', 'feapath_generic')
    save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'list_pid'] , 'class2use', 'filelist', 'classpath_generic', 'feapath_generic', 'classPidList', '-v7.3')
    save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'lists'] , 'class2use', 'filelist', 'classpath_generic', 'feapath_generic', 'classFeaList*')
    disp('results saved: ')
    disp([resultpath 'summary_biovol_allHDF_min20_' num2str(yr)])
    disp([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'lists'])
    disp([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'lists_pid'])

    clear *files* classcount* classbiovol* classC* meta_data mdate class*List
end
clear summarize_biovol_class_h5 %clear the summarize function to clear the persistent variables