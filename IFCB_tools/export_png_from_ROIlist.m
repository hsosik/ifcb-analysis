function [  ] = export_png_from_ROIlist( ROIfile_withpath, outputpath, ROInumbers )
%function [  ] = export_png_from_ROIlist( ROIfile_withpath, outputpath, ROInumbers )
%save png files to disk from ROI file, if no ROInumbers passed in, then all are exported
%Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2014

[basedir,filename,ext] = fileparts(ROIfile_withpath);
%outputpath = [basedir filesep filename filesep];
if ~exist(outputpath, 'dir'),
    mkdir(outputpath);
end;
    
%ROIfile = [filename '.roi'];

%get ADC data for startbyte and length of each ROI
adcfile = [filename '.adc'];
adcdata = load([basedir filesep adcfile]);
if isequal(filename(1), 'I'),
    x = adcdata(:,12);  y = adcdata(:,13); startbyte = adcdata(:,14);
else  %new file format, case 'D*.roi'
    x = adcdata(:,16);  y = adcdata(:,17); startbyte = adcdata(:,18);
end;
if ~exist('ROInumbers', 'var'),
    [ROInumbers] = find(x>0);
end;
fid=fopen([ROIfile_withpath '.roi']);% '.roi']);
for count = 1:length(ROInumbers),
    num = ROInumbers(count);
    fseek(fid, startbyte(num), -1);
    img = fread(fid, x(num).*y(num), 'ubit8');
    img = reshape(img, x(num), y(num));
    pngname = [filename '_' num2str(num,'%05.0f') '.png'];
    if length(img) > 0,
        imwrite(uint8(img'), fullfile(outputpath, pngname));
    end;
end;
fclose(fid);

end

