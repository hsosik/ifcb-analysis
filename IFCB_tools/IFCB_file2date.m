function [ matdate ] = IFCB_file2date( ifcb_filename )
%function [ matdate ] = Untitled2( ifcb_filename )
%generates vector of matlab date/time values from input vector of IFCB filenames
%handles these types:
%IFCB?_yyyy_ddd_hhmmss style files from instruments IFCB1 to IFCB6
%DyyyymmddThhmmss_IFCB??? style for instruments IFCB007 and up

if iscell(ifcb_filename), %if input is cell array, convert to char
    ifcb_filename = char(ifcb_filename);
end;

matdate = NaN(size(ifcb_filename,1),1);
ii = find(ifcb_filename(:,1) == 'D');
%datenum(year, month, day, hour, minute, second)
matdate(ii) = datenum(str2num(ifcb_filename(ii,2:5)), str2num(ifcb_filename(ii,6:7)), str2num(ifcb_filename(ii,8:9)), str2num(ifcb_filename(ii,11:12)), str2num(ifcb_filename(ii,13:14)), str2num(ifcb_filename(ii,15:16)));
ii = find(ifcb_filename(:,1) == 'I');
%datenum(year, 0, yearday, hour, minute, second)
matdate(ii) = datenum(str2num(ifcb_filename(ii,7:10)),0,str2num(ifcb_filename(ii,12:14)), str2num(ifcb_filename(ii,16:17)), str2num(ifcb_filename(ii,18:19)), str2num(ifcb_filename(ii,20:21)));

%fstr = char(filelist);
%year = str2num(fstr(:,7:10));
%yearday = str2num(fstr(:,12:14));
%hour = str2num(fstr(:,16:17));
%min = str2num(fstr(:,18:19));
%sec = str2num(fstr(:,20:21));
%matdate = datenum(year,0,yearday,hour,min,sec);
end

