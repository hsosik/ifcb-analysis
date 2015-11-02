
%%

startplace = pwd;
workingFolder='/Volumes/IFCB014_OkeanosExplorerAug2013/NAV/';
cd(workingFolder);

NameOfFile='metadata.mat';

ListOfFiles=dir('CNAV-GGA*');

%%
Date_full=nan(1);
Lat_full=nan(1);
Lon_full=nan(1);

%filename = '/Volumes/IFCB014_OkeanosExplorerAug2013/NAV/CNAV-GGA_20130824-121517.Raw';

for a=1:length(ListOfFiles);
    fprintf('Working on %s\n', ListOfFiles(a).name)
    filename=char(ListOfFiles(a).name);
    full_filename=strcat(workingFolder,filename);
    delimiter = ',';
    
    formatSpec = '%s%s%s%f%f%s%f%s%f%f%f%f%s%f%s%f%s%[^\n\r]';
    fileID = fopen(full_filename,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
    fclose(fileID);
    
    Date = dataArray{:, 1};
    Time = dataArray{:, 2};
    Lat = dataArray{:, 5};
    Lon = dataArray{:, 7};
   
    
    year_day=datevec(Date);
    hour_sec=datevec(Time);
    full_date=[year_day(:,1:3), hour_sec(:,(4:6))];
    date=datenum(full_date);
    
    Date_full=[Date_full date'];
    Lat_full=[Lat_full Lat'];
    Lon_full=[Lon_full Lon'];
    
end;

clear a date Date delimiter fileID filename format* hour_sec Lat List* Lon Long Time year_day ans full_date full_fil* data*

%%

Lat_full=Lat_full(2:length(Lat_full));
Lon_full=Lon_full(2:length(Lon_full));
Date_full=Date_full(2:length(Date_full));
datevec=datevec(Date_full);

clear start* working*

save(NameOfFile)
