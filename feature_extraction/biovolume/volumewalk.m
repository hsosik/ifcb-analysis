% finds the volume via slicing / Sieracki method
% this is appropriate ONLY for objects that are characterized by the major
% axis
% image needs to be a BW perimeter (or filled image), with the perimeter as foreground (i.e.
% 1's)

function [volume] = volumewalk(image)

[m,n] = find(image == 1); % finds non zero elements, i.e. the perimeter

g = horzcat(m,n); % combines vectors for easier viewing

try,
    [temp,idx] = unique(n, 'legacy'); % indexes (idx) the (last) unique elements in the vector n (x direction); changed 'u' to '~' 6/14/10
catch,
    [temp,idx] = unique(n);
end

idx2 = vertcat([0],idx); 
% creates a shifted index so that we can later get the number of repeated integers for each to feed into the mat2cell function 
idx2 = idx2(1:end-1); 

% gets rid of the last cell so that idx and idx2 can be subtracted 
len = idx - idx2; 

% % idx2 = idx(2:end); % creates a shifted index so that we can later get the number of repeated integers for each to feed into the mat2cell function
% % idx1 = idx(1:end-1); % gets rid of the last cell so that idx and idx2 can be subtracted
% % 
% % len = idx2 - idx1; % subtracts idx2 from idx so that each element of len represents how many repeated digits were there from the last repeated digit; CHECK THAT THIS SIGN IS CORRECT! 6/14/10
data = mat2cell(g,len,[1,1]); % creates a cell array in which each x value has its own cell (separated vertically)
data = data(:,1); % isolates column 1, which is the y-data

A = cellfun(@min,data); % finds the minimum (y-value) of each cell
B = cellfun(@max,data); % finds the maximum (y-value) of each cell

C = abs(B-A)/2; % gives the radius of each A,B pair OR half the height of the perimeter at each x location

vol = C.^2*pi*1; % calculates the volume of each cyclindrical slice; the 1 represents the width in the x-direction, which is 1 pixel
volume = sum(vol); % sums vol to get the overall volume of the figure
