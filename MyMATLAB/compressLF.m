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
function [CMS, CMS_ERROR] = compressLF2(LF, colorMap)

%% Set Parameters
[MyOrder] = getOrderMatrix2();
CMS = zeros(15,15);
ENC = zeros(15,15);
if (colorMap == 'RGB')
    colorMap = 1;
end
if (colorMap == 'YUV')
    colorMap = 2;
end

%% Anchor - Encode the central view (8, 8)
Mframe = readOneImage(LF, 8, 8, colorMap);
[CMS(8, 8), error] = getCalic(Mframe, 1);
ENC(8, 8) = 1;

%% CMS
for f = 2:193
    
    %% Extract de image
    [ii, jj] = find(MyOrder == f);
    Mframe = readOneImage(LF, ii, jj, 1);
    
    myImgRef=[];
    myImgRef_yuv=[];
    
    %% reference list
    indexii = [ii jj];
    [imgList, nrRef] = findImgList(ENC, ii,jj);
    nrRef=1;
    for iref = 1:nrRef
        myImgRef{iref} = readOneImage(LF, imgList(iref, 1), imgList(iref, 2), 1);
    end
    
    %% Encode
    yuv_Ref = double(rgb2ycbcr_i(myImgRef{1}));
    for iref = 1:nrRef
        myImgRef_yuv{iref} = double(rgb2ycbcr_i(myImgRef{iref}));
    end
    if (colorMap==1)
        Mframe = double(Mframe);
        for iref = 1:nrRef
            myImgRef{iref} = double(myImgRef{iref});
        end
    end
    if (colorMap==2)
        Mframe = double(rgb2ycbcr_i(Mframe));
        for iref = 1:nrRef
            myImgRef{iref} = double(rgb2ycbcr_i(myImgRef{iref}));
        end
    end
    
    SGM = getMySGM(myImgRef{1}, yuv_Ref(:,:,1), 15);
    
    maxReg = max(SGM(:)) + 1;
    pg2  = 0.1;
    BW2  = edge(yuv_Ref(:,:,1),'canny', pg2);
    pos = find(BW2 ==1);
    SGM(pos) = maxReg;
    
    % edges
    pg  = 0.00000000001;
    for iref = 1:nrRef
        BW{iref}  = double(edge(myImgRef_yuv{iref}(:,:,1),'canny', pg));
    end
    
    write_Matlab2C_File_PSC2(Mframe, SGM, BW, myImgRef, nrRef);
    
    %% Encode 
    [~, w1]=dos('PSC.exe -encode -output out.txt');
    [~, w2]=dos('PSC.exe -decode -output out.txt');
    s = dir('out.txt');
    nrBytes = s.bytes;
    
    %% Check lossless coding
    [Himg] = read_C5Matlab_file(size(Mframe(:,:,1)'),3);
    er1 = double(Mframe) - double(Himg);
    errorsPos = find(er1~=0);
    nrError = length(errorsPos);
    
    %% update
    ENC(ii,jj) = 1;
    CMS(ii,jj) = nrBytes;
    CMS_ERROR = nrError;
    
    if (rem(f, 10)== 0)
        disp([ num2str(f) '/193 Views encoded']);
%         disp(ENC);
%         disp(' ')
    end
end
disp([ num2str(f) '/193 Views encoded']);

%% Clean
delete Matlab2C.txt
delete Matlab2C_Oimg2.txt
delete C5Matlab.txt
delete out.txt

end
