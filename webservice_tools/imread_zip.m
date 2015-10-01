function [ img ] = imread_zip(zipfile, entryname)
% reads a single image from a zipfile
% note that the zipfile parameter must be the path to a real zipfile
% and not a URL.

zipJavaFile  = java.io.File(zipfile);
zipFile = org.apache.tools.zip.ZipFile(zipJavaFile);

entry = zipFile.getEntry(entryname);
entryStream = zipFile.getInputStream(entry);
jbi = javax.imageio.ImageIO.read(entryStream);

nrows = jbi.getHeight;
ncols = jbi.getWidth;
pixelData = uint8(jbi.getData.getPixels(0,0,ncols,nrows,[]));

bps = jbi.getColorModel.getPixelSize;

if bps==8
    % 8-bit grayscale
    img = reshape(pixelData,ncols,nrows)';
elseif bps==24
    % 24-bit RGB
    img = permute(reshape(pixelData,3,ncols,nrows),[3 2 1]);
elseif bps==1
    % bitmap
    img = reshape(pixelData * 255,ncols,nrows)';
end

zipFile.close;