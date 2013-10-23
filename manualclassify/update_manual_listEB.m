resultpath = '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\';
load([resultpath 'manual_listEB.mat'])

%re-sort based on file name to update any previous entries
%manual_list(2:end,:) = sortrows(manual_list(2:end,:),1);
%change to sort by date, Heidi 11/10/11
temp = char(manual_listEB(2:end,1)); temp = cellstr(temp(:,7:end));
[~,sortind] = sort(temp);
manual_list(2:end,:) = manual_listEB(sortind+1,:);

filelist = dir([resultpath 'IFCB*.mat']);
filelist = cellstr(char(filelist.name));
filelist_old = manual_listEB(2:end,1);

newfiles = setdiff(filelist, filelist_old);
if ~isempty(newfiles),
    manual_listEB(end+1:end+length(newfiles),1) = newfiles;
end;

clear resultpath newfiles filelist*
save \\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\manual_listEB manual_listEB