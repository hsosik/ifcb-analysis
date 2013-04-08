function [ feadata, feahdrs ] = get_fea_file( fullfilename )
%function [ feadata, feahdrs ] = get_fea_file( filename )
%import IFCB feature file, parse to data matrix
%target values and return them in structure (hdr)
%Heidi M. Sosik, Woods Hole Oceanographic Institution, April 2012

if isequal(fullfilename(1:4), 'http'), 
    [~,f] = fileparts(fullfilename);
    [filestr,status] = urlwrite(fullfilename, [f '.csv']);
    if status,
        fullfilename = filestr;
    else
        disp(['Error reading ' fullfilename]);
        feadata = [];
        feahdrs = '';
        return
    end;
end;
t = importdata(fullfilename, ','); 
feahdrs = t.colheaders;
feadata = t.data;
%remove temporary file if read from URL
if exist('status', 'var'), delete(filestr); end;

end

