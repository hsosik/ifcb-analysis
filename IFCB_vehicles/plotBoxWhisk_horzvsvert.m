%edits T Crockford Dec2014
%tool to compare horz vs vert ifcb
%make box whisker plots of vert vs horz for given exp
%sort of like heat map, includes missed rois at bottom (pos zero)
%assumes only using "new" IFCB adc file format. Both adc formats are listed

clear all

%%%%%%%%%%%%%%%%%%%%%%%%
%make_pathfile2load.m - prompts question of what you'd like to plot 
%set path to data, start & end file, name for saved mat file
%%%%%%%%%%%%%%%%%%%%%%%%
make_pathfiles2load2

%get files between start/end from specified dir
% startday  = str2num([startfile(2:9) startfile(11:16)]);
% endday    = str2num([endfile(2:9) endfile(11:16)]);
allfiles  = dir([hpath 'D2014*.adc']);%get all files from set dir
allfiles  = {allfiles.name}';
temp      = char(allfiles);
temp      = [temp(:,2:9) temp(:,11:16)];
%make matdate for each adc file
hmatdate   = datenum(temp(:,:),'yyyymmddHHMMSS'); %get matdate from filenames
% temp      = str2num(temp);
% %only use files of interest - start/end day set above
% ind       = find(temp>=startday & temp<=endday);
% files     = allfiles(ind); 
% matdate   = matdate(ind);
hfiles       = allfiles;
clear temp ind allfiles startfile endfile


% initialize vars
vert = [];
%compile adcdata xpos, ypox, roixXsize, roiYsize, grabstart, grabend
for count=1:length(files),
    adcdata = load([path char(files(count))]);
    if size(adcdata,1)>1,
    vert = [vert; adcdata(:,14:17) adcdata(:,12:13)];
    mattime  = [mattime; matdate(count)*ones(size(adcdata,1),1)];
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%VERTICAL INSTR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
allfiles  = dir([hpath 'D2014*.adc']);%get all files from set dir
allfiles  = {allfiles.name}';
temp      = char(allfiles);
temp      = [temp(:,2:9) temp(:,11:16)];
%make matdate for each adc file
vmatdate   = datenum(temp(:,:),'yyyymmddHHMMSS'); %get matdate from filenames
vfiles       = allfiles;
clear temp ind allfiles startfile endfile
% initialize vars
vert = [];
%compile adcdata xpos, ypox, roixXsize, roiYsize, grabstart, grabend
for count=1:length(files),
    adcdata = load([path char(files(count))]);
    if size(adcdata,1)>1,
    vert = [vert; adcdata(:,14:17) adcdata(:,12:13)];
    mattime  = [mattime; matdate(count)*ones(size(adcdata,1),1)];
    end
end


