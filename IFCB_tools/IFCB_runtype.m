function [ runtype ] = IFCB_runtype( hdrname )


if ischar(hdrname), hdrname = cellstr(hdrname); end;
runtype = NaN(size(hdrname));
for count = 1:length(hdrname),
    hdr = IFCBxxx_readhdr(hdrname{count});
    if ~isempty(hdr),
        runtype = hdr.runtype;
    end;
end;

end


