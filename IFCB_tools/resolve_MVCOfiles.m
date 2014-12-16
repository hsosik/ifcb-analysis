function [filelist, classfiles, stitchfiles] = resolve_MVCOfiles(filelist, class_filestr);
%function [filelist, classfiles, stitchfiles] = resolve_MVCOfiles(filelist, class_filestr);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if isstruct(filelist),
    filelist = {filelist.name}';
    [~, ~, ext] = fileparts(filelist{1});
    filelist = regexprep(filelist, ext, ''); %strip off extension
end;
%   classpath = ['\\queenrose\g_work_IFCB1\ifcb_data_mvco_jun06\classxxxx_24may07_' class_filestr 'revDec11\']; 
%classpath = ['\\queenrose\g_work_IFCB1\ifcb_data_mvco_jun06\classxxxx_v1\'];  %case for new results with TBclassifier
classpath = ['\\sosiknas1\IFCB_products\MVCO\class\classxxxx_v1\'];  %case for new results with TBclassifier
basedir = ['\\sosiknas1\IFCB_data\MVCO\data\xxxx'];
%basedir_all = {'\\demi\vol1'; '\\demi\vol2'; '\\demi\vol3'};
stitchpath = '\\queenrose\ifcb_data_mvco_jun06\stitchxxxx\';  %%USER set, roi stitch info files

matdate = IFCB_file2date(filelist);
[year,~,~] = datevec(matdate);
% basedir_ind = ones(size(year))*2; %default to vol2 
% basedir_ind(year >= 2012) = 1;
% basedir_ind(year <= 2009) = 3;
% basedir = basedir_all(basedir_ind);

ii = findstr(basedir(1,:), 'xxxx'); %added by EP to accomodate SOSIKNAS file structure 12-15-2014
basedir = repmat(basedir, length(year),1); %added by EP to accomodate SOSIKNAS file structure 12-15-2014
basedir(:,ii:ii+3) = num2str(year);%added by EP to accomodate SOSIKNAS file structure 12-15-2014

files = char(filelist);
sep = repmat('\',length(year),1);
basedir = [char(basedir) sep files(:,1:14) sep];
filelist = cellstr([basedir files]);
ii = findstr(classpath(1,:), 'xxxx');
classpath = repmat(classpath, length(year),1);
classpath(:,ii:ii+3) = num2str(year);
ii = findstr(stitchpath(1,:), 'xxxx');
stitchpath = repmat(stitchpath, length(year),1);
stitchpath(:,ii:ii+3) = num2str(year);

classfiles = cellstr([classpath files repmat(class_filestr, length(year),1) repmat('.mat', length(year),1)]);
stitchfiles = cellstr([stitchpath files repmat('_roistitch', length(year),1) repmat('.mat', length(year),1)]);

end

