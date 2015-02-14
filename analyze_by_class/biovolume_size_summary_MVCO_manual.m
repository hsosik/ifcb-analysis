resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
load \\raspberry\d_work\IFCB1\code_mar10_mvco\ml_analyzed_all %load the milliliters analyzed for all sample files
feapath_base = '\\sosiknas1\IFCB_products\MVCO\features\featuresXXXX_v2\';
micron_factor = 1/3.4; %microns per pixel

load class2use_MVCOmanual5 %get the master list to start
[ classes_byfile, classes_bymode ] = get_annotated_classesMVCO( class2use, manual_list);

filelist = classes_byfile.filelist;%find ml_analyzed matching each manual file
[~,ia, ib] = intersect(filelist, filelist_all);
if length(ia) ~= length(filelist),
    disp('missing some ml_analyzed values; need to make updated ml_analyzed all.mat?')
    pause
end;
temp = NaN(size(filelist));
temp(ia) = ml_analyzed(ib);
ml_analyzed = temp;
%clean up from ml_analyzed_all
clear filelist_all looktime matdate minproctime runtim

%mark NaNs in ml_analyzed for classify not complete in manual annotation
analyzed_flag = classes_byfile.classes_checked; analyzed_flag(analyzed_flag == 0) = NaN;
ml_analyzed_mat = repmat(ml_analyzed,1,length(class2use)).*analyzed_flag;

%calculate date
matdate = IFCB_file2date(filelist);

class2use_manual = class2use;
class2use_manual_first = class2use_manual;
numclass = length(class2use_manual);
class2use_here = [class2use_manual_first];
for classnum = 1:length(class2use_here),
    ml_analyzed_struct.(class2use_here{classnum}) = NaN(1,length(ml_analyzed));
    [biovol.(class2use_here{classnum}){1:length(ml_analyzed)}] = deal([]);
    [perim.(class2use_here{classnum}){1:length(ml_analyzed)}] = deal([]);
end;
eqdiam = biovol;
roiID = biovol;
for classnum = 1:numclass,
    ml_analyzed_struct.(char(class2use_here(classnum))) = ml_analyzed_mat(:,classnum);
end;
for filecount = 1:length(filelist),
    filename = filelist{filecount};
    disp(filename)
    
    load([resultpath filename])
    yr = str2num(filename(7:10));
    clear targets
    feapath = regexprep(feapath_base, 'XXXX', filename(7:10));
    [~,file] = fileparts(filename);
    feastruct = importdata([feapath file '_fea_v2.csv'], ',');
    ind = strmatch('Biovolume', feastruct.colheaders);
    targets.Biovolume = feastruct.data(:,ind);
    ind = strmatch('EquivDiameter', feastruct.colheaders);
    targets.EquivDiameter = feastruct.data(:,ind);
    ind = strmatch('Perimeter', feastruct.colheaders);
    targets.Perimeter = feastruct.data(:,ind);
    ind = strmatch('roi_number', feastruct.colheaders);
    tind = feastruct.data(:,ind);
    [~,f] = fileparts(filename);
    targets.pid = cellstr(strcat(f,'_', num2str(tind, '%05.0f')));
    
    classlist = classlist(tind,:);
    if ~isequal(class2use_manual, class2use_manual_first)
        disp('class2use_manual does not match previous files!!!')
        %     keyboard
    end;
    for classnum = 1:numclass,
        cind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
        
        if ~isempty(cind),
            biovol.(char(class2use_here(classnum)))(filecount) = {targets.Biovolume(cind)*micron_factor.^3};
            eqdiam.(char(class2use_here(classnum)))(filecount) = {targets.EquivDiameter(cind)*micron_factor};
            roiID.(char(class2use_here(classnum)))(filecount) = {char(targets.pid(cind))};
            perim.(char(class2use_here(classnum)))(filecount) = {targets.Perimeter(cind)*micron_factor};
        end;
    end;
    
    clear class2use_manual class2use_auto class2use_sub* classlist
end;

class2use = class2use_here;
if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
save([resultpath 'summary\count_biovol_size_manual_' datestr], 'matdate', 'ml_analyzed_struct', 'biovol', 'filelist', 'eqdiam', 'perim', 'roiID')
save([resultpath 'summary\count_biovol_size_manual_current'], 'matdate', 'ml_analyzed_struct', 'biovol', 'filelist', 'eqdiam', 'perim', 'roiID')

return

%create and save daily binned results
[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classcount, ml_analyzed_mat);
[matdate_bin, classbiovol_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classbiovol, ml_analyzed_mat);
save([resultpath 'summary\count_biovol_manual_' datestr '_day'], 'matdate_bin', 'classcount_bin', 'classbiovol_bin', 'ml_analyzed_mat_bin', 'class2use')
save([resultpath 'summary\count_biovol_manual_current_day'], 'matdate_bin', 'classcount_bin', 'classbiovol_bin', 'ml_analyzed_mat_bin', 'class2use')


