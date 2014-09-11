%resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
%load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
load ml_analyzed_all %load the milliliters analyzed for all sample files
biovolpathbase = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\biovolume\';
micron_factor = 1/3.4; %microns per pixel

biovolpath = dir([biovolpathbase 'biovolume*']);
biovolpath = biovolpath([biovolpath.isdir]);
biovolpath = {biovolpath.name}';
%find ml_analyzed matching each manual file
%filelist = char(manual_list(2:end,1)); filelist = cellstr(filelist(:,1:end-4));
filelist = [];
for ii = 1:length(biovolpath),
    temp = dir([biovolpathbase biovolpath{ii} filesep 'IFCB*.mat']); 
    filelist = [filelist; temp];
end;
filelist = {filelist.name}'; filelist = regexprep(filelist,'.mat','');
filelist(strmatch('IFCB1_2006_352', filelist)) = []; %skip bad day
filelist(strmatch('IFCB1_2010_153_00', filelist)) = []; %skip bad day
filelist(strmatch('IFCB1_2010_153_01', filelist)) = []; %skip bad day

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
%filelist_all = filelist;

%calculate date
fstr = char(filelist);
year = str2num(fstr(:,7:10));
yearday = str2num(fstr(:,12:14));
hour = str2num(fstr(:,16:17));
min = str2num(fstr(:,18:19));
sec = str2num(fstr(:,20:21));
matdate = datenum(year,0,yearday,hour,min,sec);
clear fstr year yearday hour min sec

bintitles = {'total', '10-20 microns', '>20 microns'}
numsizes = length(bintitles);
count = NaN(length(filelist),numsizes);  %initialize output
biovol = count;
carbon = count;

biovolpath = char(biovolpath);
for filecount = 1:length(filelist),
    filename = char(filelist(filecount));
    if ~rem(filecount,100),
        disp(filename)
    end;
    ii = strmatch({filename(7:10)}, biovolpath(:,end-3:end));
    load([biovolpathbase biovolpath(ii,:) filesep filename]) %targets
    %tind = char(targets.pid); %find the ROI indices excluding second in stitched pair
    %tind = str2num(tind(:,end-4:end));
    eqdiam = targets.EquivDiameter*micron_factor;
    biovol(filecount,1) = sum([targets.Biovolume])*micron_factor^3;
    count(filecount,1) = size(find([targets.Biovolume] > 0),1);
    ind = find(eqdiam > 10 & eqdiam <= 20);
    biovol(filecount,2) = sum([targets.Biovolume(ind)])*micron_factor^3;
    count(filecount,2) = length(ind);
    ind = find(eqdiam > 20);
    biovol(filecount,3) = sum([targets.Biovolume(ind)])*micron_factor^3;
    count(filecount,3) = length(ind);
end;

if ~exist([biovolpathbase 'summary\'], 'dir')
    mkdir([biovolpathbase 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
save([biovolpathbase 'summary\count_biovol_' datestr], 'matdate', 'ml_analyzed', 'count', 'biovol', 'filelist')

%create and save daily binned results
ml_analyzed_mat = repmat(ml_analyzed,1,numsizes);
[matdate_bin, count_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,count, ml_analyzed_mat);
[matdate_bin, biovol_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,biovol, ml_analyzed_mat);
save([biovolpathbase 'summary\count_biovol_' datestr '_day'], 'matdate_bin', 'count_bin', 'biovol_bin', 'ml_analyzed_mat_bin', 'bintitles')

