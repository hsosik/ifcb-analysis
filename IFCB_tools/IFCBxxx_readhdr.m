function [ hdr ] = IFCBxxx_readhdr( fullfilename )
%import IFCBxxx series header file as separate text lines, parse to get
%target values and return them in structure (hdr)
%Heidi M. Sosik, Woods Hole Oceanographic Institution, April 2012
%
%Sept 2012, modified to accept URL file locations from web services
%April 2020, modified to use webread for URL files and to inclede runType
%entry in output
%November 2022, modified to handle change in capitalization use in hdr file
%labels that appears associated with MRL's LINUX IFCBacq

if isequal(fullfilename(1:4), 'http')
    t = webread(fullfilename, weboptions('timeout', 15));
    t = splitlines(t);
else
    t = importdata(fullfilename,'', 150);
end
t = lower(t);

ii = strmatch('runtime:', t);
    
if ~isempty(ii)
    linestr = char(t(ii));  
    colonpos = findstr(':', linestr);
    hdr.runtime = str2num(linestr(colonpos(1)+1:end));
    ii = strmatch('inhibittime:', t);
    linestr = char(t(ii));  
    colonpos = findstr(':', linestr);
    hdr.inhibittime = str2num(linestr(colonpos(1)+1:end));
    ii = strmatch('pmttriggerselection_daq_mcconly:', t);
    if ~isempty(ii)
        linestr = char(t(ii));  
        colonpos = findstr(':', linestr);
        hdr.PMTtriggerSelection_DAQ_MCConly = str2num(linestr(colonpos(1)+1:end));
    end
else
    ii = strmatch('run time', t);
    linestr = char(t(ii));  
    eqpos = findstr('=', linestr);
    spos = findstr('s', linestr);
    hdr.runtime = str2num(linestr(eqpos(1)+1:spos(1)-1));
    hdr.inhibittime = str2num(linestr(eqpos(2)+1:spos(2)-1));
end

ii=strmatch('runtype:',t);
if ~isempty(ii),
    ii = ii(end); %fudge for 2018 IFCB109 cases with two runType entries
    linestr = char(t(ii));  
    colonpos = findstr(':', linestr);
    hdr.runType = linestr(colonpos(1)+2:end);
end

ii=strmatch('sampletype:',t);
if ~isempty(ii)
    linestr = char(t(ii));  
    colonpos = findstr(':', linestr);
    hdr.sampletype = linestr(colonpos(1)+2:end);
end

end


