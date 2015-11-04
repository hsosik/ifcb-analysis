classpath = '\\SOSIKNAS1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_21Oct2015\';
outpath_base = '\\SosikNAS1\Lab_data\VPR\NBP1201\vpr8\aid_output_RossSea_Trees_21Oct2015\';
classfiles = dir([classpath 'd*.mat']);
classfiles = {classfiles.name}';
aidpathstr = 'c:\data\NBP12_01\rois\vpr8\';
tempstr = char(classfiles);

%aid_prefix = fullfile(aidpathstr, cellstr(tempstr(:,1:4)), cellstr(tempstr(:,5:7)), filesep, 'roi0.');
aid_prefix = fullfile(aidpathstr, cellstr(tempstr(:,12:15)), cellstr(tempstr(:,16:18)), filesep, 'roi0.');

temp = load([classpath classfiles{1}], 'class2useTB', 'classifierName');
class2use = temp.class2useTB;

threshold_mode = 'adhoc';

switch threshold_mode
    case 'opt'  %"optimal" threshold from oob analysis
        temp = load(temp.classifierName, 'maxthre');
        thre = temp.maxthre;
        outpath_base = [outpath_base filesep 'opt_threshold' filesep];
    case 'adhoc'
        thre = 0.4;
        outpath_base = [outpath_base filesep num2str(thre*100,'%03.0f') '_threshold' filesep];
    case 'max'
        outpath_base = [outpath_base filesep 'max_score' filesep];
end
clear temp

if exist('thre', 'var') & length(thre) == 1,
    thre = thre*ones(size(class2use));
    thre = thre(1:end-1); %case with unclassified on end but not explicit in classifier
end;

outpaths = fullfile(outpath_base, class2use, filesep);
outfiles = regexprep(fullfile('NBPVPR4dualaid', cellstr(tempstr(:,12:15)), cellstr(tempstr(:,16:18))), '\\', '.'); 

for ii = 1:length(class2use),
    if ~exist([outpath_base class2use{ii}], 'dir')
        mkdir([outpath_base class2use{ii}])
    end;
end;

num2dostr = num2str(length(classfiles));
for filecount = 1:length(classfiles)
    disp(['reading ' num2str(filecount) ' of ' num2dostr])
    t= load([classpath classfiles{filecount}]);
    %max score wins (no unclassified output)
    switch threshold_mode
        case 'opt'
            [ class_out ] = apply_TBthreshold( t.class2useTB, t.TBscores, thre );
            [~, class_out] = ismember(class_out, t.class2useTB);
        case 'max'
            [maxscore, class_out] = max(t.TBscores');
        case 'adhoc'    
            [ class_out ] = apply_TBthreshold( t.class2useTB, t.TBscores, thre );
            [~, class_out] = ismember(class_out, t.class2useTB);
    end;
    for ii = 1:length(class2use),
        ind = find(class_out == ii);
        filename = [outpaths{ii} outfiles{filecount}];
        output = [repmat(aid_prefix{filecount}, length(ind),1) num2str(t.roinum(ind), '%010.0f') repmat('.tif', length(ind),1)];
        fid = fopen(filename,'w');
        for count = 1:length(ind),
            fprintf(fid,'%s\r\n',output(count,:));
        end;
        fclose(fid);    
    end;
end;


