function [ img ] = jbi2img(jbi)
% converts java BufferedImage to MATLAB image

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

end