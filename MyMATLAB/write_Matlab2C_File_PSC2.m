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

function write_Matlab2C_File_PSC2(img, Cimg, BW, Oimg, nrOimg)

%% %%%%%%%%%%%%%%%% Matlab2C.txt %%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('Matlab2C.txt','wb');
[m n] = size(img(:,:,1));
fwrite(fid, [m n],'int');

% write img
fwrite(fid, img(:,:,1)', 'uchar');
fwrite(fid, img(:,:,2)', 'uchar');
fwrite(fid, img(:,:,3)', 'uchar');

%% End
fclose(fid);

%% %%%%%%%%%%%%%%%% Matlab2C_Oimg.txt %%%%%%%%%%%%%%%%%%
fid2 = fopen('Matlab2C_Oimg2.txt','wb');

%% write nrOimg
fwrite(fid2, nrOimg,'int');

%% write Cimg
NRREG = max(Cimg(:));
fwrite(fid2, NRREG,'int');
fwrite(fid2, Cimg','uchar');

 %% write Oimg - Y
for iRef = 1:nrOimg
    myImg = Oimg{iRef}(:,:,1);
    fwrite(fid2, myImg', 'uchar');
    myImg = BW{iRef};
    fwrite(fid2, myImg','uchar');
end

%% write Oimg - U
for iRef = 1:nrOimg
    myImg = Oimg{iRef}(:,:,2);
    fwrite(fid2, myImg', 'uchar');
end

%% write Oimg - V
for iRef = 1:nrOimg
    myImg = Oimg{iRef}(:,:,3);
    fwrite(fid2, myImg', 'uchar');
end

%% End
fclose(fid2);

end