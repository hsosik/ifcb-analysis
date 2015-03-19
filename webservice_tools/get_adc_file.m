function [ adc_data ] = get_adc_file( fullfilename )
%function [ feadata, feahdrs ] = get_csv_file( filename )
%import IFCB csv file
%Heidi M. Sosik, Woods Hole Oceanographic Institution, February 2014

if isequal(fullfilename(1:4), 'http'), 
    [~,f] = fileparts(fullfilename);
    [filestr,status] = urlwrite(fullfilename, [f '.adc']);
    if status,
        fullfilename = filestr;
    else
        disp(['Error reading ' fullfilename]);
        feadata = [];
        feahdrs = '';
        return
    end;
end;
adc_data = load([fullfilename]);
%remove temporary file if read from URL
if exist('status', 'var'), delete(filestr); end;

end

