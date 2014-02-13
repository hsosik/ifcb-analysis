%I made a change
load '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\Alt\summary\count_manual_low_green27Jan2014.mat'

load '\\queenrose\IFCB010_OkeanosExplorerAug2013\data\Manual_fromClass\summary\count_manual_19Jan2014.mat'

min_diff= 1/24;
match_ind=NaN(size(matdate_lowgreen));

for ii=1:length(matdate_lowgreen);
    [min_ii, i2]=min(abs(matdate_lowgreen(ii)-matdate(ii)));
 
    if min_ii <= min_diff
        match_ind(ii)=i2;
    end
end;

iii=find(isnan(i2));

[matdate_lowgreen(iii)-matdate(i2(iii))]*24  %as a check, should appear as less than 1
    











IFCB10_filename={filelist.name}';
IFCB14_filename={filelist_lowgreen.name}';

low_green_ind = find(green < ((chl+1.5)/0.4));
    classlist=classlist(low_green_ind,1:4);
    
    ii = find(ifcb_filename(:,11:12) == 'D');
    
    IFCB10_filename(:(11:12)
    D20130824T211357_IFCB010.mat
    
     ii = find(ifcb_filename(:,11:12)
     
     matdate = NaN(size(ifcb_filename,1),1);
ii = find(ifcb_filename(:,1) == 'D');
%datenum(year, month, day, hour, minute, second)
matdate(ii) = datenum(str2num(ifcb_filename(ii,2:5)), str2num(ifcb_filename(ii,6:7)), str2num(ifcb_filename(ii,8:9)), str2num(ifcb_filename(ii,11:12)), str2num(ifcb_filename(ii,13:14)), str2num(ifcb_filename(ii,15:16)));
ii = find(ifcb_filename(:,1) == 'I');
%datenum(year, 0, yearday, hour, minute, second)
matdate(ii) = datenum(str2num(ifcb_filename(ii,7:10)),0,str2num(ifcb_filename(ii,12:14)), str2num(ifcb_filename(ii,16:17)), str2num(ifcb_filename(ii,18:19)), str2num(ifcb_filename(ii,20:21)));

% fstr = char(filelist);
% year = str2num(fstr(:,2:5));
% month=str2num(fstr(:,6:7));
% yearday = str2num(fstr(:,8:9));
% hour = str2num(fstr(:,11:12));
% min = str2num(fstr(:,13:14));
% sec = str2num(fstr(:,15:16));
% matdate = datenum(year, month, day, hour, minute, second);
end