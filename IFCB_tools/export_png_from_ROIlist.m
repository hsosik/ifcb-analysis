function [ output_args ] = export_png_from_ROIlist( ROIfile_withpath, ROInumbers )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


[basedir,filename,ext] = fileparts(ROIfile_withpath);
outputpath = [basedir filesep filename '_png' filesep];

if ~exist(outputpath, 'dir'),
    mkdir(outputpath);
end;
    
ROIfile = [filename '.roi'];

%get ADC data for startbyte and length of each ROI
adcfile = [filename '.adc'];
adcdata = load([basedir adcfile]);
if isequal(filename(1), 'I'),
    x = adcdata(:,12);  y = adcdata(:,13); startbyte = adcdata(:,14);
else  %new file format, case 'D*.roi'
    x = adcdata(:,16);  y = adcdata(:,17); startbyte = adcdata(:,18);
end;

fid=fopen([basedir ROIfile]);% '.roi']);
for count = 1:length(ROInumbers),
    num = ROInumbers(count);
    fseek(fid, startbyte(num), -1);
    img = fread(fid, x(num).*y(num), 'ubit8');
    img = reshape(img, x(num), y(num));
    pngname = [filename '_' num2str(num,'%05.0f') '.png'];
    if length(img) > 0,
        imwrite(uint8(img'), [outputpath filesep pngname], 'png');
    end;
end;
fclose(fid);

end

