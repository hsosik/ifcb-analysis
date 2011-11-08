function [ img ] = get_image_file ( pathname, n )
adc = [pathname '.adc'];
roi = [pathname '.roi'];
fid=fopen(roi);
adcdata = load(adc, '-ascii');  %load merged adc file
xsize = adcdata(:,12);
ysize = adcdata(:,13);
startbyte = adcdata(:,14);
position = startbyte(n);
fseek(fid, position, -1);
img = fread(fid, xsize(n)*ysize(n), 'uint8=>uint8');
img = reshape(img, xsize(n), ysize(n));
end