resultpath = '\\Queenrose\ifcb2_c211a_sea2007\Manual_fromClass\';
load \\Queenrose\ifcb2_c211a_sea2007\ml_analyzed_C211A   %load the milliliters analyzed for all sample files
feapath_base = '\\Queenrose\IFCB2_C211A_SEA2007\data\features\features2007_v2\';
micron_factor = 1/3.4; %microns per pixel

resfilelist = dir([resultpath 'IFCB*.mat']);
[~,ia, ib] = intersect(regexprep({resfilelist.name}', '.mat', ''), regexprep({filelist.name}', '.adc', ''));
%[~,ia, ib] = intersect(regexprep({resfilelist.name}', '.mat', ''), filelist);

if length(ia) ~= length(resfilelist),
    disp('missing some ml_analyzed values; need to make updated ml_analyzed all.mat?')
    pause
end;
temp = NaN(size(resfilelist));
temp(ia) = ml_analyzed(ib);
ml_analyzed = temp;
%clean up from ml_analyzed_all
clear looktime* extra_proc* runtime ia ib temp numrois numtriggers
filelist = resfilelist; clear resfilelist

%calculate date
fstr = char(filelist.name);
year = str2num(fstr(:,7:10));
yearday = str2num(fstr(:,12:14));
hour = str2num(fstr(:,16:17));
min = str2num(fstr(:,18:19));
sec = str2num(fstr(:,20:21));
matdate = datenum(year,0,yearday,hour,min,sec);
clear fstr yearday hour min sec

load '\\Queenrose\ifcb2_c211a_sea2007\Manual_fromClass\IFCB2_2007_174_171957.mat' %read first file to get classes
temp = load('\\raspberry\d_work\IFCB1\code_svn\trunk\manualclassify\class2use_MVCOmanual3' ,'class2use'); %get the master list to start
temp2 = load('\\raspberry\d_work\IFCB1\code_svn\trunk\manualclassify\class2use_MVCOciliate', 'class2use_sub4');

class2use_manual_first = [temp.class2use]; clear temp
class2use_first_sub = [temp2.class2use_sub4]; clear temp2 %class2use_sub4; %this is specific for one sub case = ciliates
numclass1 = length(class2use_manual);
numclass2 = length(class2use_sub4);
numclass = numclass1 + numclass2;
class2use_here = [class2use_manual_first class2use_sub4];
classcount = NaN(length(filelist),numclass);  %initialize output
classbiovol = classcount;
classcarbon = classcount;
%ml_analyzed_mat = classcount;
% for loopcount = 1:length(mode_list),
%     annotate_mode = char(mode_list(loopcount));
%     [ class_cat, list_col, mode_ind, manual_only ] = config_annotate_mode( annotate_mode, class2use_here, class2use_first_sub, manual_list, mode_list );
%     filelist = cell2struct(manual_list(mode_ind+1,1),{'name'},2);
    for filecount = 1:length(filelist),
        filename = filelist(filecount).name;
        disp(filename)
       % ml_analyzed_mat(mode_ind(filecount),class_cat) = ml_analyzed(mode_ind(filecount));
        load([resultpath filename])
         clear targets
        feapath = regexprep(feapath_base, 'XXXX', filename(7:10));
        [~,file] = fileparts(filename);
        feastruct = importdata([feapath file '_fea_v2.csv'], ','); 
        ind = strmatch('Biovolume', feastruct.colheaders);
        targets.Biovolume = feastruct.data(:,ind);
        ind = strmatch('roi_number', feastruct.colheaders);
        tind = feastruct.data(:,ind);

        classlist = classlist(tind,:); 
        if ~isequal(class2use_manual, class2use_manual_first)
            disp('class2use_manual does not match previous files!!!')
       %     keyboard
        end;
        temp = zeros(1,numclass); %init as zeros for case of subdivide checked but none found, classcount will only be zero if in class_cat, else NaN
        tempvol = temp;
        for classnum = 1:numclass1,
            cind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
            temp(classnum) = length(cind);
            tempvol(classnum) = nansum(targets.Biovolume(cind)*micron_factor.^3);
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
            end;    
        end;
        %classcount(mode_ind(filecount),class_cat) = temp(class_cat);
        %classbiovol(mode_ind(filecount),class_cat) = tempvol(class_cat);
        classcount(filecount,:) = temp;
        classbiovol(filecount,:) = tempvol;
%        classcarbon(filecount,:) = tempcarbon;
        clear class2use_manual class2use_auto class2use_sub* classlist
    end;
%end;

biovolume_units = 'cubic microns';
%filelist = filelist_all;
filelist = regexprep({filelist.name}', '.mat', '');
class2use = class2use_here;
if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
save([resultpath 'summary\count_biovol_manual_' datestr], 'matdate', 'ml_analyzed', 'classcount', 'classbiovol', 'filelist', 'class2use', 'biovolume_units')
save([resultpath 'summary\count_biovol_manual_current'], 'matdate', 'ml_analyzed', 'classcount', 'classbiovol', 'filelist', 'class2use', 'biovolume_units')

%create and save daily binned results
%[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classcount, ml_analyzed_mat);
%[matdate_bin, classbiovol_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classbiovol, ml_analyzed_mat);
%save([resultpath 'summary\count_biovol_manual_' datestr '_day'], 'matdate_bin', 'classcount_bin', 'classbiovol_bin', 'ml_analyzed_mat_bin', 'class2use')
%save([resultpath 'summary\count_biovol_manual_current_day'], 'matdate_bin', 'classcount_bin', 'classbiovol_bin', 'ml_analyzed_mat_bin', 'class2use')

