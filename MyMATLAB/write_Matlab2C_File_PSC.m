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

function write_Matlab2C_File_PSC(img, Cimg, BW, Oimg)

%% %%%%%%%%%%%%%%%% Matlab2C.txt %%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('Matlab2C.txt','wb');
[m n] = size(img(:,:,1));
fwrite(fid, [m n],'int');

% write img
fwrite(fid, img(:,:,1)', 'uchar');
fwrite(fid, img(:,1:end,2)', 'uchar');
fwrite(fid, img(:,1:end,3)', 'uchar');

%% End        
fclose(fid);

%% %%%%%%%%%%%%%%%% Matlab2C_Oimg.txt %%%%%%%%%%%%%%%%%%
fid2 = fopen('Matlab2C_Oimg.txt','wb');

%% write Oimg
fwrite(fid2, Oimg(:,:,1)', 'uchar');

%% write Cimg
NRREG = max(Cimg(:));
fwrite(fid2, NRREG,'int');
fwrite(fid2, Cimg','uchar');
fwrite(fid2, BW','uchar');

%% write Oimg - U and V
fwrite(fid2, Oimg(:,1:end,2)', 'uchar');
fwrite(fid2, Oimg(:,1:end,3)', 'uchar');

%% End 
fclose(fid2);

end