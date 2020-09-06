%=======================================================================
% JUN-2017
% Ionut Schiopu (https://goo.gl/dFR95R)
% Tampere University of Technology (TUT)
%
% Please cite my work:
% I. Schiopu, M. Gabbouj, A. Gotchev and M. M. Hannuksela, 
% "Lossless compression of subaperture images using context modeling," 
% 2017 3DTV Conference: The True Vision - Capture, Transmission and Display 
% of 3D Video (3DTV-CON), Copenhagen, 2017, pp. 1-4, 
% doi: 10.1109/3DTV.2017.8280403.
%
% ----------------------------------------------------------------------
% Updated on 06-SEP-2020
% Ionut Schiopu
% Vrije Universiteit Brussel
%=======================================================================

%% Setup
clear all
clc
addpath('MyMATLAB');

%% Parameters
% Download the images from: http://plenodb.jpeg.org/lf/epfl
LFimageName = 'Pillars.mat';
colorMap = 'RGB'; % 'YUV'

%% Algorithm

% read image
load('Pillars.mat');
disp(['Encoding the LF image: [' LFimageName '] in the [' colorMap '] colormap']);

% encode
[CMS_MAP, CMS_ERROR] = compressLF(LF, colorMap);

% results 
if (CMS_ERROR==0)
    disp('Lossless compression!')
    disp(['Compressed size: ' num2str(sum(CMS_MAP(:))/1024/1024) ' MB']);
else
    error('ERROR! THE COMPRESSION IS NOT LOSSLESS!');
end

