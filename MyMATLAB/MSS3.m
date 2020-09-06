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

function [D, regions, info] = MSS3(I)
I=double(I);
values = unique(I(:));
[m,n] = size(I);
D = zeros(m,n);
index = 1;
for i=1:length(values)
    BW = zeros(m, n);
    pos = find(I == values(i));
    BW(pos)=1;
    CC = bwconncomp(BW,4);
    for k = 1:CC.NumObjects
        D(CC.PixelIdxList{k}) = index;
        regions{index} = CC.PixelIdxList{k}';
        info(index,1:2)= [index length(regions{index})];
        index = index+1;
    end
end
