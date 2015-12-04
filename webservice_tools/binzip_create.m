function [ ] = binzip_create( pid, zipPath )
% use dashboard to create binzip for a given pid
import java.io.File;
import java.io.FileOutputStream;
import java.util.zip.ZipOutputStream;
import java.util.zip.ZipEntry;
import java.io.StringReader;
import java.io.OutputStreamWriter;
import java.io.BufferedWriter;
import org.apache.commons.io.IOUtils;
import java.io.RandomAccessFile;

import java.io.FileInputStream;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;

bin_lid = lid(pid);

zos = ZipOutputStream(FileOutputStream(File(zipPath)));

% for XML and CSV representations, fetch from dashboard
exts = {'xml', 'csv'};
for n=1:2
    ext = exts{n};
    url = [pid '.' ext];
    entryName = [bin_lid '.' ext];
    content = urlread(url);

    entry = ZipEntry(entryName);
    zos.putNextEntry(entry);
    reader = StringReader(content);
    writer = BufferedWriter(OutputStreamWriter(zos));
    IOUtils.copy(reader,writer);
    writer.flush();
    zos.closeEntry();
end

% for images, read ADC and ROI files
adcPath = [tempname '.adc'];
roiPath = [tempname '.roi'];
pngPath = [tempname '.png'];

c = onCleanup(@() cleanup(adcPath, roiPath, pngPath));

websave(adcPath,[pid '.adc']);
websave(roiPath,[pid '.roi']);

%get ADC data for start byte and length of each ROI
adcdata = load(adcPath);
x = adcdata(:,16);  y = adcdata(:,17); startbyte = adcdata(:,18);

fid = fopen(roiPath);

for count = 1:length(startbyte);
    fseek(fid, startbyte(count), -1); %move to startbyte
    if x(count), %only for cases with x ~= 0
        img = fread(fid, x(count).*y(count), 'ubit8'); %read img pixels
        img = reshape(img, x(count), y(count))'; %reshape to original x-y array
        imwrite(uint8(img), pngPath, 'png'); %write ROI in png format
        fis = FileInputStream(pngPath);
        entryName = [bin_lid '_' num2str(count,'%05.0f') '.png'];
        entry = ZipEntry(entryName);
        zos.putNextEntry(entry);
        IOUtils.copy(fis,zos);
        fis.close();
        zos.closeEntry();
    end
end

zos.close();

fclose(fid);

function cleanup(adcPath, roiPath, pngPath)
    if exist(adcPath,'file')
        delete(adcPath);
    end
    if exist(roiPath,'file')
        delete(roiPath);
    end
    if exist(pngPath,'file')
        delete(pngPath);
    end
end

end

