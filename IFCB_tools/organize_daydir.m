
basepath ='/Volumes/IFCB_data/IFCB14_Dock/data/';
filelist = dir([basepath 'D*.roi']);

c=struct2cell(filelist)';
filenames=c(:,1);

filename_char=char(filenames);
day_filenames=filename_char(:,1:9);
filenames_unique= unique(day_filenames,'rows');


dir_path ='/Volumes/IFCB_data/IFCB14_Dock/dir_practice/';
cd(dir_path)
for i=1:size(filenames_unique,1);
    filename=[filenames_unique(i,:)];
    if ~exist(fullfile(filename),'dir')
    mkdir(fullfile(filename));
    end
end

%data_source='/Volumes/IFCB_data/IFCB14_Dock/data/';
for i=1:size(filenames_unique,1)
    %for i=2:size(filenames_unique,1);
    filename=[filenames_unique(i,:)];
    source_file=fullfile([basepath filename]);
    if ~isempty(strmatch(filename,filename_char));
    movefile([source_file '*'], fullfile([dir_path filename]))
    end
end

