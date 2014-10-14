
basepath ='/Volumes/IFCB_data/IFCB14_Dock/data/';
filelist = dir([basepath 'D*.roi']);

c=struct2cell(filelist)';
filenames=c(:,1);

char=char(filenames);
day_filenames=char(:,1:9);
filenames_unique= unique(day_filenames,'rows');


practicepath ='/Volumes/IFCB_data/IFCB14_Dock/dir_practice/';
cd(practicepath)
for i=1:length(filenames_unique);
    filename=[filenames_unique(i,:)];
    mkdir(fullfile(filename));
end

% data_source='/Volumes/IFCB_data/IFCB14_Dock/data/';
% for i=1:length(filenames_unique)
%     filename=[filenames_unique(i,:)];
%     source_file=fullfile([data_source filename]);
%     movefile([source_file '*'], fullfile([practicepath filename]))
% end

