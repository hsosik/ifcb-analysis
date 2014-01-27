resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
load \\RASPBERRY\d_work\IFCB1\code_mar10_mvco\ml_analyzed_all %load the milliliters analyzed for all sample files
biovolpath_base = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\biovolume\';
feapath_base = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\featuresXXXX_v2\';
micron_factor = 1/3.4; %microns per pixel

%%%%%%%%%FIX - this set of lines to skip some missing biovol due to missing blobs
%filelist = char(manual_list(2:end,1)); filelist = cellstr(filelist(:,1:end-4));
%t = dir(['\\queenrose\ifcb_data_mvco_jun06\biovolume\IFCB*.mat']);
%t = char(t.name); t = cellstr(t(:,1:end-4)); 
%files_biovol = t; clear t
%[~,ia] = setdiff(filelist, files_biovol); %4985 4977
%manual_list(ia+1,:) = [];  %omit the ones missing biovol

mode_list = manual_list(1,2:end-1); mode_list = [mode_list 'ciliate_ditylum'];
%find ml_analyzed matching each manual file
filelist = char(manual_list(2:end,1)); filelist = cellstr(filelist(:,1:end-4));

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
filelist_all = filelist;

%calculate date
fstr = char(filelist);
year = str2num(fstr(:,7:10));
yearday = str2num(fstr(:,12:14));
hour = str2num(fstr(:,16:17));
min = str2num(fstr(:,18:19));
sec = str2num(fstr(:,20:21));
matdate = datenum(year,0,yearday,hour,min,sec);
clear fstr yearday hour min sec

load([resultpath char(manual_list(2,1))]) %read first file to get classes
load class2use_MVCOmanual3 %get the master list to start
class2use_manual = class2use;
class2use_manual_first = class2use_manual;
class2use_first_sub = class2use_sub4; %this is specific for one sub case = ciliates
numclass1 = length(class2use_manual);
numclass2 = length(class2use_sub4);
numclass = numclass1 + numclass2;
class2use_here = [class2use_manual_first class2use_sub4];
classcount = NaN(length(filelist),numclass);  %initialize output
classbiovol = classcount;
classcarbon = classcount;
ml_analyzed_mat = classcount;
for loopcount = 1:length(mode_list),
    annotate_mode = char(mode_list(loopcount));
    [ class_cat, list_col, mode_ind, manual_only ] = config_annotate_mode( annotate_mode, class2use_here, class2use_first_sub, manual_list, mode_list );
    filelist = cell2struct(manual_list(mode_ind+1,1),{'name'},2);
    
    for filecount = 1:length(filelist),
        filename = filelist(filecount).name;
        disp(filename)
        ml_analyzed_mat(mode_ind(filecount),class_cat) = ml_analyzed(mode_ind(filecount));
        load([resultpath filename])
        yr = str2num(filename(7:10));
        if yr < 2013,
            biovolpath = [biovolpath_base 'biovolume' filename(7:10) '\'];
            load([biovolpath filename]) %targets
            tind = char(targets.pid); %find the ROI indices excluding second in stitched pair
            tind = str2num(tind(:,end-4:end));
        else %2013 and later, v2 features with biovolume
            clear targets
            feapath = regexprep(feapath_base, 'XXXX', filename(7:10));
            [~,file] = fileparts(filename);
            feastruct = importdata([feapath file '_fea_v2.csv'], ','); 
            ind = strmatch('Biovolume', feastruct.colheaders);
            targets.Biovolume = feastruct.data(:,ind);
            ind = strmatch('EquivDiameter', feastruct.colheaders);
            targets.EquivDiameter = feastruct.data(:,ind);
            ind = strmatch('roi_number', feastruct.colheaders);
            tind = feastruct.data(:,ind);
        end;
        
        classlist = classlist(tind,:); 
        if ~isequal(class2use_manual, class2use_manual_first)
            disp('class2use_manual does not match previous files!!!')
       %     keyboard
        end;
        temp = zeros(1,numclass); %init as zeros for case of subdivide checked but none found, classcount will only be zero if in class_cat, else NaN
        tempvol = temp;
        for classnum = 1:numclass1,
            if manual_only,
                cind = find(classlist(:,2) == classnum);
            else
                cind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
            end;
            temp(classnum) = length(cind);
            tempvol(classnum) = nansum(targets.Biovolume(cind)*micron_factor.^3);
            tempeqd(classnum) = targets.EquivDiameter(cind)*micron_factor;
 %           keyboard
        end;
        if exist('class2use_sub4', 'var'),
             if ~isequal(class2use_sub4, class2use_first_sub)
                disp('class2use_sub4 does not match previous files!!!')
                keyboard
            end;
            for classnum = 1:numclass2,
                cind = find(classlist(:,4) == classnum);
                temp(classnum+numclass1) = length(cind);
                tempvol(classnum+numclass1) = nansum(targets.Biovolume(cind)*micron_factor.^3);
                tempeqd(classnum+numclass1) = targets.EquivDiameter(cind)*micron_factor;
            end;    
        end;
        %classcount(mode_ind(filecount),class_cat) = temp(class_cat);
        %classbiovol(mode_ind(filecount),class_cat) = tempvol(class_cat);
        classcount(mode_ind(filecount),:) = temp;
        classbiovol(mode_ind(filecount),:) = tempvol;
        classeqdiam(mode_ind(filecount),:) = tempeqd;
        clear class2use_manual class2use_auto class2use_sub* classlist
    end;
end;

filelist = filelist_all;
class2use = class2use_here;
if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
save([resultpath 'summary\count_biovol_manual_' datestr], 'matdate', 'ml_analyzed_mat', 'classcount', 'classbiovol', 'filelist', 'class2use','classeqdiam')

%create and save daily binned results
[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classcount, ml_analyzed_mat);
[matdate_bin, classbiovol_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classbiovol, ml_analyzed_mat);
[matdate_bin, classeqdiam_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classeqdiam, ml_analyzed_mat);
save([resultpath 'summary\count_biovol_manual_' datestr '_day'], 'matdate_bin', 'classcount_bin', 'classbiovol_bin', 'ml_analyzed_mat_bin', 'class2use','classeqdiam_bin')

