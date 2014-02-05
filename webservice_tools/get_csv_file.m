function [ csv_data ] = get_csv_file( fullfilename )
%function [ feadata, feahdrs ] = get_csv_file( filename )
%import IFCB csv file
%Heidi M. Sosik, Woods Hole Oceanographic Institution, February 2014

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
csv_data = fileread([filestr]);
%remove temporary file if read from URL
if exist('status', 'var'), delete(filestr); end;

end

