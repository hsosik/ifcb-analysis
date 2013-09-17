resultpath = '\\128.128.111.141\LaneyLab\projects\HLY1101\work_IFCB8\Manual\';
metapath = '\\128.128.111.141\IFCBdata\IFCB8_HLY1101\metadata\';
load([metapath 'ml_analyzed']) %load the milliliters analyzed for all sample files
biovolpath_base = '\\128.128.111.141\IFCBdata\IFCB8_HLY1101\biovolume\';
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
classcount_lt10 = classcount;
classcount_lt20 = classcount;
classbiovol = classcount;
classcarbon = classcount;
classcarbon_lt10 = classcount; bv10 = 4/3*pi.*([10]/2).^3;
classcarbon_lt20 = classcount; bv20 = 4/3*pi.*([20]/2).^3;
% diatom_str = {'Asterionellopsis' 'Cerataulina' 'Chaetoceros' 'Corethron' 'Coscinodiscus' 'Cylindrotheca' 'DactFragCerataul' 'Dactyliosolen' 'Ditylum'...
%     'Ephemera' 'Eucampia' 'Guinardia' 'Guinardia_flaccida' 'Guinardia_striata' 'Lauderia' 'Licmophora' 'Odontella' 'Paralia' 'pennate' 'Pleurosigma'...
%     'Pseudonitzschia' 'Rhizosolenia' 'Skeletonema' 'Stephanopyxis' 'Thalassionema' 'Thalassiosira' 'Fragilariopsis' 'Navicula' 'Fragilariopsis_Grazed'...
%     'Bacterosira' 'Detonula' 'Melosira' 'Nitzschia frigida' 'mix_elongated' };
% [~,diatom_ind,~] = intersect(class2use_here, diatom_str);
%lgdiatom_flag = zeros(size(class2use_here)); lgdiatom_flag(diatom_ind) = 1;
lg_diatom_str = {'DactFragCerataul' 'Dactyliosolen' 'Ditylum' 'Ephemera' 'Guinardia_flaccida' 'Guinardia_striata' 'Licmophora' 'pennate'...
    'Pleurosigma' 'Rhizosolenia' 'Thalassiosira' 'Fragilariopsis' 'Navicula'};
[~,lg_diatom_ind,~] = intersect(class2use_here, lg_diatom_str);
lgdiatom_flag = zeros(size(class2use_here)); lgdiatom_flag(lg_diatom_ind) = 1;
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
        temp_lt10 = temp;
        temp_lt20 = temp;
        tempvol = temp;
        tempcarbon = temp;
        tempcarbon_lt10 = temp;
        tempcarbon_lt20 = temp;
        %tempcarbon = temp;
        for classnum = 1:numclass,
            cind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
            temp(classnum) = length(cind);
            bv = targets.Biovolume(cind)*micron_factor.^3;
            tempvol(classnum) = nansum(bv); %cubic microns
            tempcarbon(classnum) =  nansum(biovol2carbon(bv,lgdiatom_flag(classnum))); %picograms
            %%%%%%%%%%TEMPORARY results without using the large diatom C:vol
            %tempcarbon(classnum) =  nansum(biovol2carbon(bv,0)); %picograms
            sind = find(bv <= bv10);
            temp_lt10(classnum) = length(sind);
            tempcarbon_lt10(classnum) = nansum(biovol2carbon(bv(sind),lgdiatom_flag(classnum))); %picograms
            %tempcarbon_lt10(classnum) = nansum(biovol2carbon(bv(sind),0)); %picograms
            sind = find(bv <= bv20);
            temp_lt20(classnum) = length(sind);
            tempcarbon_lt20(classnum) = nansum(biovol2carbon(bv(sind),lgdiatom_flag(classnum))); %picograms
            %tempcarbon_lt20(classnum) = nansum(biovol2carbon(bv(sind),0)); %picograms
        end;
        classcount(filecount,:) = temp;
        classcount_lt10(filecount,:) = temp_lt10;
        classcount_lt20(filecount,:) = temp_lt20;
        classbiovol(filecount,:) = tempvol;
        classcarbon(filecount,:) = tempcarbon;
        classcarbon_lt10(filecount,:) = tempcarbon_lt10;
        classcarbon_lt20(filecount,:) = tempcarbon_lt20;
        clear class2use_manual class2use_auto class2use_sub* classlist
    end;

%filelist = filelist_all;
class2use = class2use_here;
if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
units = {'biovol is in cubic microns, carbon is in picograms'};
save([resultpath 'summary\count_biovol_manual_' datestr], 'matdate', 'ml_analyzed', 'classcount*', 'classbiovol', 'filelist', 'class2use', 'metadata', 'classcarbon*', 'units', 'lg_diatom_str')
%save([resultpath 'summary\count_biovol_manual_nolgdiatom_' datestr], 'matdate', 'ml_analyzed', 'classcount*', 'classbiovol', 'filelist', 'class2use', 'metadata', 'classcarbon*', 'units')

