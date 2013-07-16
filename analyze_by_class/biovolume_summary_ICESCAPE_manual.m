resultpath = '\\floatcoat\LaneyLab\projects\HLY1101\work_IFCB8\Manual\';
metapath = '\\floatcoat\IFCBdata\IFCB8_HLY1101\metadata\';
load([metapath 'ml_analyzed']) %load the milliliters analyzed for all sample files
biovolpath_base = '\\floatcoat\IFCBdata\IFCB8_HLY1101\biovolume\';
%micron_factor = 1/3.4; %microns per pixel  FIX!!!!!!!
%micron_factor = 1/4.23; %USER, instrument specific entry for pixels per micron %IFCB8 4.23 from beads in IFCB8_2011_203_135906, see est_micron_factor.m
micron_factor = 1/3.92; %USER, instrument specific entry for pixels per micron %IFCB8 4.23 from beads in IFCB8_2011_203_135906, see est_micron_factor.m, updated with new features 

resfilelist = dir([resultpath 'IFCB*.mat']);
[~,ia, ib] = intersect(regexprep({resfilelist.name}', '.mat', ''), filelist);
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

load([metapath 'HLY1101metadata'])
[~,ia, ib] = intersect(regexprep({filelist.name}', '.mat', ''), {metadata.filename}');
if length(ia) ~= length(filelist),
    disp('missing some metadata?')
    pause
end;
metadata = metadata(ib);

%calculate date
fstr = char(filelist.name);
year = str2num(fstr(:,7:10));
yearday = str2num(fstr(:,12:14));
hour = str2num(fstr(:,16:17));
min = str2num(fstr(:,18:19));
sec = str2num(fstr(:,20:21));
matdate = datenum(year,0,yearday,hour,min,sec);
clear fstr yearday hour min sec

%load([resultpath filelist(1).name]) %read first file to get classes
temp = load('\\floatcoat\LaneyLab\projects\HLY1101\work_IFCB8\code\class2use_HLY1101', 'class2use');
class2use_manual_first = [temp.class2use]; clear temp
numclass = length(class2use_manual_first);
class2use_here = class2use_manual_first;
classcount = NaN(length(filelist),numclass);  %initialize output
classbiovol = classcount;
classcarbon = classcount;
diatom_str = {'Asterionellopsis' 'Cerataulina' 'Chaetoceros' 'Corethron' 'Coscinodiscus' 'Cylindrotheca' 'DactFragCerataul' 'Dactyliosolen' 'Ditylum'...
    'Ephemera' 'Eucampia' 'Guinardia' 'Guinardia_flaccida' 'Guinardia_striata' 'Lauderia' 'Licmophora' 'Odontella' 'Paralia' 'pennate' 'Pleurosigma'...
    'Pseudonitzschia' 'Rhizosolenia' 'Skeletonema' 'Stephanopyxis' 'Thalassionema' 'Thalassiosira' 'Fragilariopsis' 'Navicula' 'Fragilariopsis_Grazed'...
    'Bacterosira' 'Detonula' 'Melosira' 'Nitzschia frigida'};
[~,diatom_ind,~] = intersect(class2use_here, diatom_str);
lgdiatom_flag = zeros(size(class2use_here)); lgdiatom_flag(diatom_ind) = 1;
%ml_analyzed_mat = classcount;
    for filecount = 1:length(filelist),
        filename = filelist(filecount).name;
        disp(filename)
        %ml_analyzed_mat(mode_ind(filecount),class_cat) = ml_analyzed(mode_ind(filecount));
        load([resultpath filename])
        %biovolpath = [biovolpath_base 'biovolume' filename(7:10) '\'];
        biovolpath = [biovolpath_base];
        load([biovolpath filename]) %targets
        tind = char(targets.pid); %find the ROI indices excluding second in stitched pair
        tind = str2num(tind(:,end-4:end));
        classlist = classlist(tind,:); 
        if ~isequal(class2use_manual, class2use_manual_first)
            disp('class2use_manual does not match previous files!!!')
            t = min([length(class2use_manual) length(class2use_manual_first)]);
            if isequal(class2use_manual(1:t), class2use_manual_first(1:t)),
                disp('class2use_manual missing entries on end')
            %else
                %keyboard
            end;
        end;
        temp = zeros(1,numclass); %init as zeros for case of subdivide checked but none found, classcount will only be zero if in class_cat, else NaN
        tempvol = temp;
        %tempcarbon = temp;
        for classnum = 1:numclass,
            cind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
            temp(classnum) = length(cind);
            tempvol(classnum) = nansum(targets.Biovolume(cind)*micron_factor.^3); %cubic microns
            tempcarbon(classnum) =  nansum(biovol2carbon(targets.Biovolume(cind)*micron_factor.^3,lgdiatom_flag(classnum))); %picograms
            %%%%%%%%%%TEMPORARY results without using the large diatom C:vol
            tempcarbon(classnum) =  nansum(biovol2carbon(targets.Biovolume(cind)*micron_factor.^3,0)); %picograms
        end;
        classcount(filecount,:) = temp;
        classbiovol(filecount,:) = tempvol;
        classcarbon(filecount,:) = tempcarbon;
        clear class2use_manual class2use_auto class2use_sub* classlist
    end;

%filelist = filelist_all;
class2use = class2use_here;
if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
units = {'biovol is in cubic microns, carbon is in picograms'};
%save([resultpath 'summary\count_biovol_manual_' datestr], 'matdate', 'ml_analyzed', 'classcount', 'classbiovol', 'filelist', 'class2use', 'metadata', 'classcarbon', 'units')
save([resultpath 'summary\count_biovol_manual_nolgdiatom_' datestr], 'matdate', 'ml_analyzed', 'classcount', 'classbiovol', 'filelist', 'class2use', 'metadata', 'classcarbon', 'units')

