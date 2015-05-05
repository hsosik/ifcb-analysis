function files_struct = resolve_MVCOfiles4gui(filelist, baseroi, baseclass, class_filestr);
%function files_struct = resolve_MVCOfiles4gui(filelist, baseroi, baseclass, class_filestr);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%baseroi and baseclass passed in for general resovler case, but not used
%for this MVCO instance

if isstruct(filelist),
    filelist = {filelist.name}';
end;
[~,filelist] = cellfun(@fileparts,filelist, 'uniformoutput', false); %filename only, no path, no ext

classpath = fullfile('\\sosiknas1\IFCB_products\MVCO\class\classxxxx_v1\');  %case for new results with TBclassifier
basedir = fullfile('\\sosiknas1\IFCB_data\MVCO\data\xxxx');
stitchpath = fullfile('\\SOSIKNAS1\IFCB_products\MVCO\stitch\stitchxxxx\');  %%USER set, roi stitch info files

n = length(filelist);
matdate = IFCB_file2date(filelist);
[year,~,~] = datevec(matdate);
roiext = repmat('.roi',n,1);

ii = findstr(basedir(1,:), 'xxxx'); %added by EP to accomodate SOSIKNAS file structure 12-15-2014
basedir = repmat(basedir, length(year),1); %added by EP to accomodate SOSIKNAS file structure 12-15-2014
basedir(:,ii:ii+3) = num2str(year);%added by EP to accomodate SOSIKNAS file structure 12-15-2014

files = char(filelist);
sep = repmat(filesep,length(year),1);
basedir = [char(basedir) sep files(:,1:14) sep];
%filelist = cellstr([basedir files roiext]);

ii = findstr(classpath(1,:), 'xxxx');
classpath = repmat(classpath, length(year),1);
classpath(:,ii:ii+3) = num2str(year);
ii = findstr(stitchpath(1,:), 'xxxx');
stitchpath = repmat(stitchpath, length(year),1);
stitchpath(:,ii:ii+3) = num2str(year);

files_struct.roifiles = cellstr([basedir files roiext]);
files_struct.classfiles = cellstr([classpath files repmat(class_filestr, length(year),1) repmat('.mat', length(year),1)]);
files_struct.stitchfiles = cellstr([stitchpath files repmat('_roistitch', length(year),1) repmat('.mat', length(year),1)]);

end

