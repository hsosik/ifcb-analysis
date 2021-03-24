function [ config ] = configure ()

config = struct;
config.plot = 0; % plot images showing what's happening?
config.date = 'now';
%config.date = '2011-10-20T11:07:16Z';

% phasecong3 parameters
config.pc3 = struct;
config.pc3.nscale = 4;
config.pc3.norient = 6;
config.pc3.minWaveLength = 2;
config.pc3.mult = 2.5;
config.pc3.sigmaOnf = 0.55;
config.pc3.k = 2.0;
config.pc3.cutOff = 0.3;
config.pc3.g = 5;
config.pc3.noiseMethod = -1;

% hysthresh params
config.hysthresh = struct;
config.hysthresh.high = 0.3; 
config.hysthresh.low = 0.09; %.1 / .25-.35

config.blob_min = 40; %150; % minimum area of blob
% list of region props to compute for blob; AREA is done no matter what so
% omit from this list
% add Area back if blobs are pre-computed
%config.blob_props = {'Area', 'BoundingBox', 'ConvexArea', 'Eccentricity', 'EquivDiameter', 'Extent', 'MajorAxisLength', ...
%    'MinorAxisLength', 'Orientation', 'Perimeter', 'Solidity', 'ConvexHull'};
config.blob_props = {'Area', 'BoundingBox', 'Eccentricity', 'EquivDiameter', 'Extent', 'MajorAxisLength', ...
    'MinorAxisLength', 'Orientation'};
config.props2sum = {'Area' 'ConvexArea', 'MajorAxisLength', 'MinorAxisLength', 'Perimeter', 'ConvexPerimeter', 'FeretDiameter', 'Biovolume','SurfaceArea'};
%NOTE, Heidi 22 Mar 2021, props2sum list includes 'FeretDiameter' but this
%doesn't work since new feature is 'maxFeretDiameter'--lots of v4 features
%already computed without this so...is it really useful enough to add back correctly??
end