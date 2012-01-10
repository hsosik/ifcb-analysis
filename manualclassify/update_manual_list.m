resultpath = 'd:\work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([resultpath 'manual_list.mat'])

%re-sort based on file name to update any previous entries
%manual_list(2:end,:) = sortrows(manual_list(2:end,:),1);
%change to sort by date, Heidi 11/10/11
temp = char(manual_list(2:end,1)); temp = cellstr(temp(:,7:end));
[~,sortind] = sort(temp);
manual_list(2:end,:) = manual_list(sortind+1,:);

filelist = dir([resultpath 'IFCB*.mat']);
filelist = cellstr(char(filelist.name));
filelist_old = manual_list(2:end,1);

newfiles = setdiff(filelist, filelist_old);
if ~isempty(newfiles),
    manual_list(end+1:end+length(newfiles),1) = newfiles;
end;

clear resultpath newfiles filelist*
save d:\work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\manual_list manual_list