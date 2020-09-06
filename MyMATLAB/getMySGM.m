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

function [SGM]=getMySGM(I1_, I1_yuv, suppix_size)

mySgm2 =  superpixelSGM(I1_, suppix_size);
mySgm = zeros(size(I1_(:,:,1)));
size1 = size(mySgm);
size2 = size(mySgm2);
if isequal(size1,size2)
    mySgm=mySgm2;
else
    mySgm(2:end-1,2:end-1) = mySgm2;
    maxreg = max(mySgm(:));
    pos = find(mySgm==0);
    mySgm(pos) = maxreg+1;
end

F = zeros(size(I1_yuv));
R = I1_yuv;
for i=1:max(mySgm(:)) % regions
    pos = find(mySgm == i);
    F(pos) = round(mean(abs(R(pos))));
end
F = round(((F-min(F(:)))/(max(F(:)-min(F(:)))))*10);

[D1, regions, info] = MSS3(F);
nrLoop = 30;
again = 1;
while (nrLoop && again)
    D= D1;
    again = 0;
    minReg = 200;
    regIndex = info(info(:,2)<minReg,1);
    for i=1:length(regIndex)
        iReg = regIndex(i);
        pos = find(D1 == iReg);
        if (~isempty(pos))
            vecini = findMyNeig(iReg, D1);
            vecini = info(vecini((info(vecini,2)>minReg)),1);
            if (isempty(vecini))
                again = 1;
            else
                if (length(vecini)>1)
                    [bValue, bPos] = max(info(vecini,2));
                    vecin = vecini(bPos);
                else
                    vecin = vecini;
                end
                D(pos) = info(vecin,1);
            end
        end
    end
    [D1, regions, info] = MSS3(D);
    nrLoop = nrLoop-1;
end
SGM = D1;

end