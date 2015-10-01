function [ img ] = jbi2img(jbi)
% converts java BufferedImage to MATLAB image
% this is the type of image read with functions such as
% - javax.imageio.ImageIO.read

% extract pixel data and convert to unsigned 8-bit
nrows = jbi.getHeight;
ncols = jbi.getWidth;
pixelData = uint8(jbi.getData.getPixels(0,0,ncols,nrows,[]));

% get pixel size in bits
bps = jbi.getColorModel.getPixelSize;

% assume the following based on pixel size:
% 1 = bitmap (1 bit per pixel)
% 8 = 8-bit grayscale
% 24 = 8-bit/channel RGB image
% other image formats not supported
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

end