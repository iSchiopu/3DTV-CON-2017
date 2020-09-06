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

function [I1_colorMap] = readOneImage(LF, i, j, colorMap)

block = LF(i,j,:,:,1:3);
I1_s = squeeze(block(1,1,:,:,:));
I1_ = double(bitshift(I1_s,-8));

%% rgb to yuv
if (colorMap==1)
    I1_colorMap = double(I1_);
end
if (colorMap==2)
    I1_colorMap = double(rgb2ycbcr_i(I1_));
end


end