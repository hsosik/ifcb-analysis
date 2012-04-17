function [ hdr ] = IFCBxxx_readhdr( fullfilename )
%import IFCBxxx series header file as separate text lines, parse to get
%target values and return them in structure (hdr)
%Heidi M. Sosik, Woods Hole Oceanographic Institution, April 2012

t = importdata(fullfilename,'', 150);
ii = strmatch('run time', t);
linestr = char(t(ii));
eqpos = findstr('=', linestr);
spos = findstr('s', linestr);
hdr.runtime = str2num(linestr(eqpos(1)+1:spos(1)-1));
hdr.inhibittime = str2num(linestr(eqpos(2)+1:spos(2)-1));

end

