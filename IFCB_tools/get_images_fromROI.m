function [targets] = get_images_fromROI( ROIfile_withpath, ROInumbers )
%function [targets  ] = get_images_fromROI( ROIfile_withpath, ROInumbers )
%read images from ROI file and store in targets structure, if no ROInumbers passed in, then all are exported
%Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2014

[basedir,filename,ext] = fileparts(ROIfile_withpath);
    
ROIfile = [filename '.roi'];

%get ADC data for startbyte and length of each ROI
adcfile = [filename '.adc'];
adcdata = load([basedir filesep adcfile]);
if ~isempty(adcdata)
    if isequal(filename(1), 'I'),
        x = adcdata(:,12);  y = adcdata(:,13); startbyte = adcdata(:,14);
    else  %new file format, case 'D*.roi'
        x = adcdata(:,16);  y = adcdata(:,17); startbyte = adcdata(:,18);
    end;
else
    x = [];
end
if ~exist('ROInumbers', 'var'),
    [ROInumbers] = find(x>0);
end;
fid=fopen([basedir filesep ROIfile]);% '.roi']);
targets.targetNumber = ROInumbers;
targets.pid = []; %initialize empty in case no ROIs
for count = 1:length(ROInumbers),
    num = ROInumbers(count);
    fseek(fid, startbyte(num), -1);
    img = fread(fid, x(num).*y(num), 'ubit8=>uint8'); 
    targets.image{count} = reshape(img, x(num), y(num))';
    targets.pid{count} = [filename '_' num2str(num,'%05.0f')];
end;
fclose(fid);

end

