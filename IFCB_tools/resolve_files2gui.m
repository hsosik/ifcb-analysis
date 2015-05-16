function files_struct = resolve_files2gui(filelist, baseroipath, baseclasspath, class_filestr);
%function files_struct = resolve_files2gui(filelist, basepath, classpath, class_filestr);
%Example template for use with startMC / manual_classify_5_0 (GUI versions)
% Advanced users can save this with customized name and edit the roipath
% and classpath code below to construct their own local resolver to
% automatically set complete paths for locating IFCB data and classifier
% files on different hard drives and/or within subdirectories
%
% As written here, this template replicates the pattern in the
% "standard" resolver that is built into StartMC / ManageMCconfig:
% standard case for <base_path>\yyyy\<IFCB_day_dir>\ or
% <base_path>/yyyy/<IFCB_day_dir>/, as appropriate
%
% In modifying for your own customer resolver, just be careul not to
% change anything about the the inputs or outputs to the function.
%
% To use this function after saving it with a custom name, it is necessary 
% to select it in the custom resolver box in the ManageMCconfig GUI
%
% Heidi M. Sosik, Woods Hole Oceanographic Institution, May 2015

[~,files] = cellfun(@fileparts,filelist, 'uniformoutput', false);

files = char(files);
n = length(filelist);
sep = repmat(filesep,n,1);

%create lists of roi/class files with fullpath
roibase = repmat(char(baseroipath),n,1);
classbase = repmat(char(baseclasspath),n,1);
roiext = repmat('.roi',n,1);
classext = repmat([class_filestr '.mat'],n,1);
if files(1,1) == 'D',
    roipath = [roibase files(:,2:5) sep files(:,1:9) sep]; %edit and use this line in case of different structure for class and roi locations
    classpath = [classbase files(:,2:5) sep files(:,1:9) sep]; %edit and use this line in case of different structure for class and roi locations
else  %case for original 'I*' style IFCB data (only for IFCB7 and earlier)    
    roipath = [roibase sep files(:,7:10) sep files(:,1:14) sep];
    classpath = [classbase sep files(:,7:10) sep files(:,1:14) sep]; 
end;
roifiles = cellstr([roipath files roiext]);
classfiles = cellstr([classpath files classext]);

files_struct.classfiles = classfiles;
files_struct.roifiles = roifiles;

end

