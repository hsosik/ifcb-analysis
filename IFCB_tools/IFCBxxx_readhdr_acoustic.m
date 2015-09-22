function [ hdr, adcfileformat ] = IFCBxxx_readhdr( fullfilename )
%import IFCBxxx series header file as separate text lines, parse to get
%target values and return them in structure (hdr)
%Heidi M. Sosik, Woods Hole Oceanographic Institution, April 2012
%
%Sept 2012, modified to accept URL file locations from web services
% hdrfilename='M:\D20131107T223633_IFCB009.hdr'
% fullfilename=hdrfilename
keyboard
if isequal(fullfilename(1:4), 'http'),
    [filestr,status] = urlwrite(fullfilename, 'temp.hdr');
    if status,
        fullfilename = filestr;
    else
        disp(['Error reading ' fullfilename]);
        hdr = '';
        return
    end;
end;

t = importdata(fullfilename,'', 150);
adcfileformat = char(t(end));

%remove temporary file if read from URL
if exist('status', 'var'), delete(filestr); end;
ii = strmatch('runTime:', t);

if ~isempty(ii),
    ii = strmatch('runType', t);
    linestr = char(t(ii));
    colonpos = findstr(':', linestr);
    hdr.runtype = (linestr(colonpos(1)+1:end));
    
    ii = strmatch('inhibitTime:', t);
    linestr = char(t(ii));
    colonpos = findstr(':', linestr);
    hdr.inhibittime = str2num(linestr(colonpos(1)+1:end));
    
    ii = strmatch('runTime:', t);
    linestr = char(t(ii));
    colonpos = findstr(':', linestr);
    hdr.runtime = str2num(linestr(colonpos(1)+1:end));
    
    ii = strmatch('RunFastFactor:', t);
    linestr = char(t(ii));
    colonpos = findstr(':', linestr);
    hdr.RunFastFactor = str2num(linestr(colonpos(1)+1:end));
    
    ii = strmatch('runSampleFast:', t);
    if ~isempty(ii)
        linestr = char(t(ii));
        colonpos = findstr(':', linestr);
        hdr.runSampleFast = str2num(linestr(colonpos(1)+1:end));
    end
    ii = strmatch('fluidsActive:', t);
    if ~isempty(ii)
        linestr = char(t(ii));
        colonpos = findstr(':', linestr);
        hdr.fluidsActive = str2num(linestr(colonpos(1)+1:end));
    end
    ii = strmatch('AcousticFocusingOnALT:', t);
    if ~isempty(ii)
        linestr = char(t(ii));
        colonpos = findstr(':', linestr);
        hdr.AcousticFocusingOnALT = str2num(linestr(colonpos(1)+1:end));
    end
    ii = strmatch('FileComment:', t);
    if ~isempty(ii)
        linestr = char(t(ii));
        colonpos = findstr(':', linestr);
        hdr.FileComment = linestr(colonpos(1)+1:end);
    end
    ii = strmatch('altSyringeSampleVolume:', t);
    if ~isempty(ii)
        linestr = char(t(ii));
        colonpos = findstr(':', linestr);
        hdr.altSyringeSampleVolume = str2num(linestr(colonpos(1)+1:end));
    end
    ii = strmatch('SyringeSampleVolume:', t);
    linestr = char(t(ii));
    colonpos = findstr(':', linestr);
    hdr.SyringeSampleVolume = str2num(linestr(colonpos(1)+1:end));
else
    ii = strmatch('run time', t);
    linestr = char(t(ii));
    eqpos = findstr('=', linestr);
    spos = findstr('s', linestr);
    hdr.runtime = str2num(linestr(eqpos(1)+1:spos(1)-1));
    hdr.inhibittime = str2num(linestr(eqpos(2)+1:spos(2)-1));
end;
end

