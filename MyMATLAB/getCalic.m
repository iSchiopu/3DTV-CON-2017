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

function [nrBytes, error]=getCalic(I2_, colorMap)

%% 
if (colorMap==1) 
    % rgb
    I2_colorMap = double(I2_);
else
    % yuv
    I2_colorMap = double(rgb2ycbcr_i(I2_));
end

%% encode
M1 = I2_colorMap(:,:,1);
M2 = I2_colorMap(:,:,2);
M3 = I2_colorMap(:,:,3);

error=0;
result_calic = calic(M1);
myResult(1) = result_calic(1);
error = error + result_calic(5);

result_calic = calic(M2);
myResult(2) = result_calic(1);
error = error + result_calic(5);

result_calic = calic(M3);
myResult(3) = result_calic(1);
error = error + result_calic(5);

% Bytes!
nrBytes = sum(myResult)/8;

end