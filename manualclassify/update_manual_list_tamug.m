resultpath = '\\Dq-cytobot-pc\IFCB\manual\'; %enter the location of your manual result files
load([resultpath 'manual_list_tamug.mat']) %enter the name of your  manual_list

%re-sort based on file name to update any previous entries
%manual_list(2:end,:) = sortrows(manual_list(2:end,:),1);
%change to sort by date, Heidi 11/10/11
temp = char(manual_list(2:end,1)); temp = cellstr(temp(:,2:end));
[~,sortind] = sort(temp);
manual_list(2:end,:) = manual_list(sortind+1,:);

filelist = dir([resultpath 'D*.mat']); %get the filelist for the manual result directory
filelist = cellstr(char(filelist.name)); %make the file list into a list of strings instead of in a strucgture array.
filelist_old = manual_list(2:end,1); %get the existingg file list from manual_list

newfiles = setdiff(filelist, filelist_old);
if ~isempty(newfiles),
    manual_list(end+1:end+length(newfiles),1) = newfiles;
end;

%column_list = {'filelist', 'sample_type', 'sample_type2', 'instance', 'date', 'Sample_ID'}; % to add columns, enter more column names here. 
 load(strcat(resultpath, char(filelist(1))));
 VariableNames_old = manual_list(1, 2:end);
 if (size(manual_list, 2)-1) < length(class2use_manual);
     %manual_list(end+1:end+(length(class2use_manual)-length(VariableNames_old)))= class2use_manual(length(VariableNames_old)+1:end);
     manual_list(1, (length(VariableNames_old)+2):(length(class2use_manual)+1)) = class2use_manual(length(VariableNames_old)+1:end);
 end
 
%clear resultpath newfiles filelist*
save([resultpath 'manual_list_tamug.mat'], 'manual_list')