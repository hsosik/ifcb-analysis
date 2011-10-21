function [ config ] = configure ()

config = struct;
config.plot = 1; % plot images showing what's happening?
config.date = 'now';

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
config.hysthresh.high = 0.2;
config.hysthresh.low = 0.1;

config.blob_min = 150; % minimum area of blob
% list of region props to compute for blob
config.blob_props = {'ConvexArea', 'Eccentricity', 'EquivDiameter', 'Extent', 'FilledArea', 'MajorAxisLength', ...
    'MinorAxisLength', 'Orientation', 'Perimeter', 'Solidity'};

end