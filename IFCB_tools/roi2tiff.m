%roi2tiff.m
%%%%%
%IFCB analysis code
%Extracts all ROIs from a selected IFCB *.roi file into a subdirectory with the same base name as the file 
%Heidi Sosik, Woods Hole Oceanographic Institution, 2011

%user select a roi file
[roifile, roipath] = uigetfile('*.roi', 'Select roi file', '');

%create output directory if needed
outpath = [roipath roifile(1:end-4) '\'];
if ~exist([roipath roifile(1:end-4)], 'dir'), mkdir(outpath), end;

%get ADC data for start byte and length of each ROI
adcdata = load([roipath roifile(1:end-3) 'adc']);
x = adcdata(:,12);  y = adcdata(:,13); startbyte = adcdata(:,14);

%open roi file
fid=fopen([roipath roifile]);

%loop over classes and save tiffs to subdirs
disp(['writing ' num2str(length(startbyte)) ' ROIs to ' outpath])
for count = 1:length(startbyte);
        fseek(fid, startbyte(count), -1); %move to startbyte
        if x(count), %only for cases with x ~= 0
            img = fread(fid, x(count).*y(count), 'ubit8'); %read img pixels
            img = reshape(img, x(count), y(count)); %reshape to original x-y array
            tiffname = [roifile(1:end-4) '_' num2str(count) '.tif']; 
            imwrite(uint8(img), [outpath tiffname], 'tiff','compression','none'); %write ROI in tiff format
        end;
end;