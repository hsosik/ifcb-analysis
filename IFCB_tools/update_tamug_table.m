%resultpath = 'C:\IFCB\manual\';
%resultpath = '\\Dq-cytobot-pc\D\IFCB\data\D2014\'; %name the path where the table is located
load('\\Dq-cytobot-pc\D\IFCB\data\tamug_table.mat'); %load the existing table

in_dir_base = '\\Dq-cytobot-pc\D\IFCB\data\D2015\'; %USER web services to access data
daydir = dir([in_dir_base 'D2015*']);
daydir = daydir([daydir.isdir]); 

filelist = {};
for ii = 1:length(daydir),
    in_dir_temp = [in_dir_base daydir(ii).name filesep];
    filelist_temp = dir([in_dir_temp '*.adc']);
    filelist_temp = regexprep({filelist_temp.name}', '.adc', '');
    if isempty(filelist);
       filelist = filelist_temp;
    else filelist = [filelist; filelist_temp];
    end
end



temp = char(tamug_table{:,1});  temp = cellstr(temp(:,2:end));
[~,sortind] = sort(temp);
tamug_table = tamug_table(sortind,:);

%filelist = dir([resultpath 'D*.mat']); %get the list of files in the directory, including those not yet in manual_table
%filelist = cellstr(char(filelist.name));
filelist_old = (tamug_table{:,1}); %get the list of files in the current manual_table
 filelist_old_temp = char(filelist_old);
filelist_old_temp = filelist_old_temp(:,1:24);
filelist_old_temp = cellstr(filelist_old_temp);

temp = find(ismember(filelist, filelist_old_temp) ==0);
newfiles = filelist(temp);

%newfiles = setdiff(filelist, filelist_old);
if ~isempty(newfiles),
   % manual_table.filename(end+1:end+length(newfiles)) = newfiles;
    %calculate date of new files
    matdate = IFCB_file2date(newfiles);
    date = cellstr(datestr(matdate, 2)); %convert matdate to regular date
    new_rows_start = length(filelist_old)+1;
    new_rows_end = length(filelist_old) + length(newfiles);
    tamug_table.filename(new_rows_start:new_rows_end,1) = newfiles; %& manual_table.date(end+1:end+length(newfiles))  = date;
    tamug_table.date(new_rows_start:new_rows_end) = date;
end;





%This section was for adding any new category names to manual_table. I
%think since we are deciding to use a different sort of table that doesn't
%have a column for every category, it is not needed (July 2015). 

%July 2015. Okay, using similar code to make option for Hannah to add
%columns to manual table. 

column_list = {'filelist', 'sample_type', 'sample_type2', 'instance', 'date', 'Sample_ID'}; % to add columns, enter more column names here. 
 %load(strcat(resultpath, char(filelist(1))));
 %VariableNames_old = manual_table.Properties.VariableNames;
 if width(tamug_table) < length(column_list);
     %manual_table.Properties.VariableNames(end+1:end+(length(class2use_manual)-length(VariableNames_old)))= class2use_manual(length(VariableNames_old)+1:end);
    temp =  column_list(width(tamug_table)+1:end);
    temp2 = cell(size(tamug_table,1),length(temp)); %use this line if the new column will contain strings (text)
    %temp2 = zeros(size(manual_table,1),length(temp)); %use this line if the new column will contain numbers (double)
     T2 =array2table(temp2);
     T2.Properties.VariableNames= temp;
     tamug_table = horzcat(tamug_table, T2);
 end
 


clear resultpath newfiles filelist*
%save C:\IFCB\manual\manual_table manual_table
save \\Dq-cytobot-pc\D\IFCB\data\tamug_table tamug_table
% 
% enddate = '01/08/15'; % enter start date here
% startdate = '11/10/14'; % enter end date here


% example to search categorical columns 
row_numbers = find(tamug_table.sample_type2 == 'timeseries' |tamug_table.sample_type == 'timeseries'); % gives list of row numbers that meets criteria
filelist = tamug_table{row_numbers,{'filename'}}; %gives a list of files that meet the criteria

enddate = '01/08/15'; % enter start date here
startdate = '11/10/14'; % enter end date here
enddate = datenum(enddate);
startdate = datenum(startdate);
matdate= datenum(tamug_table.date);
row_numbers = find(matdate >= startdate & matdate <= enddate & tamug_table.sample_type == 'timeseries');
