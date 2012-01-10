% rep_dist calculates the representative distance by which to multiply the
% area to get the prismatic volume for complex shapes
% this protocol is used for "non-major axis images"

function [volume] = rep_dist(image) 
warning('off','signal:findpeaks:noPeaks'); % sets warning to off

% image needs to be an unfilled image (i.e. a boundary)
DIST = bwdist(image); % gets distance of every point to nearest non-zero point

DIST = DIST + 1; % adds 1 to each point to align with how we have been defining our pyramids (8.5.10)
image_fill = imfill(image,'holes'); % gets a filled image
DIST(image_fill==0) = NaN; % sets all distances outside of the filled image to NaN (changed from zero 8.5.10); we are not interested in the exterior distances

% this gets commented out in the "new volume calc, as detailed in page 8 of
% LRN notebook

% [m,n] = size(DIST); % gets size
% DIST = mat2cell(DIST, m,ones(1,n)); % converts columns each to a cell so 'findpeaks' can be used on each column vector
% makes this the value output 6/24/10


% pks = cellfun(@findpeaks,DIST,'UniformOutput', 0); % returns peak sizes for each column; uniform output must be set to 0 in order for this to work (allow multiple outputs for peaks)
% pks = cell2mat(pks); % returns all the peak values in a vector

% l = mean(pks); % averages all of the peak values

% % l = max(DIST); % finds the maximum of each column
% % l = mean(l(l>0)); % finds mean of the non-zero maxima (zeros correspond to background)
% % 
% % q= mean(DIST(DIST>0)); % finds mean of all non-zero values
% % 
% % q1 = mean(DIST(DIST>1)); % finds mean of all values above one (one = perimeter)
% % 
% % q2 = mode(DIST(DIST>1)); % finds the mode among all values above one (if one is allowed, it is the mode)

% does volume calculation
x = nanmean(reshape(DIST,numel(DIST),1))*4 - 2; % uses relation detailed on pg 28 of LRN to get a "representative distance"; 8.5.10

cf = (x.^2./2)./(x.^2/2 + x + 1/4); % defines the correction factor (see page 28 of LRN); 8.5.10

volume = 2*1.5708*cf*(nansum(reshape(DIST,numel(DIST),1))); % calculates the volume according to protocal on pg. 8 of LRN; 1.5708 is the correction factor
