function files_struct = resolve_files2gui_gomex(filelist, baseroipath, baseclasspath, class_filestr);
%function files_struct = resolve_files2gui(filelist, basepath, classpath, class_filestr);
%Example template 
% Heidi M. Sosik, Woods Hole Oceanographic Institution, 31 May 2009

% if isstruct(filelist),
%     filelist = {filelist.name}';
%     [~, ~, ext] = fileparts(filelist{1});
%     filelist = regexprep(filelist, ext, ''); %strip off extension
% end;

[~,files] = cellfun(@fileparts,filelist, 'uniformoutput', false);

%matdate = IFCB_file2date(files);
%[year,~,~] = datevec(matdate);
files = char(files);
n = length(filelist);
sep = repmat(filesep,n,1);

%create lists of roi/class files with fullpath
roibase = repmat(char(baseroipath),n,1);
classbase = repmat(char(baseclasspath),n,1);
roiext = repmat('.roi',n,1);
classext = repmat([class_filestr '.mat'],n,1);
if files(1,1) == 'D',
    %roipath = [roibase files(:,2:5) sep files(:,1:9) sep];
    roipath = [roibase sep files(:,1:9) sep];
    classpath = [classbase sep]; %edit and use this line instead of above in case of different structure for class and roi locations
else      
    roipath = [roibase sep files(:,7:10) sep files(:,1:14) sep];
    classpath = [classbase sep files(:,7:10) sep files(:,1:14) sep]; %edit and use this line instead of above in case of different structure for class and roi locations
end;
roifiles = cellstr([roipath files roiext]);
classfiles = cellstr([classpath files classext]);

files_struct.classfiles = classfiles;
files_struct.roifiles = roifiles;

end

