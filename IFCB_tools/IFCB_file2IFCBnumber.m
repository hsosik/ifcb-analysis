function [ IFCBnumberString, IFCBnumber ] = IFCB_file2IFCBnumber( ifcb_filename )
%function [ IFCBnumberString ] = IFCB_file2IFCBnumber( ifcb_filename )
%extracts cell vector of strings for instrument number as IFCB? or IFCB??? from input vector of IFCB filenames
%handles these types:
%IFCB?_yyyy_ddd_hhmmss style files from instruments IFCB1 to IFCB6
%DyyyymmddThhmmss_IFCB??? style for instruments IFCB007 and up

if ischar(ifcb_filename)
    ifcb_filename = cellstr(ifcb_filename);
end

IFCBnumberString = cell(size(ifcb_filename));
IFCBnumber = NaN(size(ifcb_filename));

ii = find(startsWith(ifcb_filename, 'D'));
temp = char(ifcb_filename(ii));
IFCBnumberString(ii) = cellstr(temp(:,18:24));
IFCBnumber(ii) = str2num(temp(:,22:24));

ii = find(startsWith(ifcb_filename, 'I'));
temp = char(ifcb_filename(ii));
IFCBnumberString(ii) = cellstr(temp(:,1:5));
IFCBnumber(ii) = str2num(temp(:,5));

end

