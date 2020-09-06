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

function [img] = read_C5Matlab_file(sizeg,nrM)
fid = fopen('C5Matlab.txt','r');

txt=fread(fid,sizeg(1)*sizeg(2),'uchar');
img_Y = reshape(txt,sizeg);
img_Y = img_Y';

% sizeg(1) = ceil(sizeg(1)/2);

img_U = zeros(size(img_Y));
if (nrM>=2)
    txt=fread(fid,sizeg(1)*sizeg(2),'uchar');
    img_Ux = reshape(txt,sizeg);
    img_Ux = img_Ux';
    img_U(:,1:end) = img_Ux;
else
    
end

img_V = zeros(size(img_Y));
if (nrM==3)
    txt=fread(fid,sizeg(1)*sizeg(2),'uchar');
    img_Vx = reshape(txt,sizeg);
    img_Vx = img_Vx';
    img_V(:,1:end) = img_Vx;
end
img=cat(3, img_Y, img_U, img_V);
fclose(fid);