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

function [imgList, nrRef] = findImgList(ENC, ii, jj)

index = 1;
imgList=[];
jump = 0;
%% line
if ((jj>1) && (jj<15))
    if (ENC(ii, jj-1))
        imgList(index,1:2) = [ii, jj-1];
        index=index+1;
    else
        if (ENC(ii, jj+1))
            imgList(index,1:2) = [ii, jj+1];
            index=index+1;
        end
    end
else
    if (jj==1)
        if (ENC(ii, jj+1))
            imgList(index,1:2) = [ii, jj+1];
            index=index+1;
        end
        if (ENC(ii-1, jj))
            imgList(index,1:2) = [ii-1, jj];
            index=index+1;
        else
            if (ENC(ii+1, jj))
                imgList(index,1:2) = [ii+1, jj];
                index=index+1;
            end
        end
        if (ENC(ii-1, jj+1))
            imgList(index,1:2) = [ii-1, jj+1];
            index=index+1;
        end
        if (ENC(ii+1, jj+1))
            imgList(index,1:2) = [ii+1, jj+1];
            index=index+1;
        end
        jump=1;
    else
        if (ENC(ii, jj-1))
            imgList(index,1:2) = [ii, jj-1];
            index=index+1;
        end
        if (ENC(ii-1, jj))
            imgList(index,1:2) = [ii-1, jj];
            index=index+1;
        else
            if (ENC(ii+1, jj))
                imgList(index,1:2) = [ii+1, jj];
                index=index+1;
            end
        end
        if (ENC(ii-1, jj-1))
            imgList(index,1:2) = [ii-1, jj-1];
            index=index+1;
        end
        if (ENC(ii+1, jj-1))
            imgList(index,1:2) = [ii+1, jj-1];
            index=index+1;
        end
        jump=1;
    end
end
%% column
if (~jump)
    if ((ii>1) && (ii<15))
        if (ENC(ii-1, jj))
            imgList(index,1:2) = [ii-1, jj];
            index=index+1;
        else
            if (ENC(ii+1, jj))
                imgList(index,1:2) = [ii+1, jj];
                index=index+1;
            end
        end
    else
        if (ii==1)
            if (ENC(ii+1, jj))
                imgList(index,1:2) = [ii+1, jj];
                index=index+1;
            end
            if (ENC(ii, jj-1))
                imgList(index,1:2) = [ii, jj-1];
                index=index+1;
            else
                if (ENC(ii, jj+1))
                    imgList(index,1:2) = [ii, jj+1];
                    index=index+1;
                end
            end
            if (ENC(ii+1, jj-1))
                imgList(index,1:2) = [ii+1, jj-1];
                index=index+1;
            end
            if (ENC(ii+1, jj+1))
                imgList(index,1:2) = [ii+1, jj+1];
                index=index+1;
            end
            jump=1;
        else
            if (ENC(ii-1, jj))
                imgList(index,1:2) = [ii-1, jj];
                index=index+1;
            end
            if (ENC(ii, jj-1))
                imgList(index,1:2) = [ii, jj-1];
                index=index+1;
            else
                if (ENC(ii, jj+1))
                    imgList(index,1:2) = [ii, jj+1];
                    index=index+1;
                end
            end
            if (ENC(ii-1, jj-1))
                imgList(index,1:2) = [ii-1, jj-1];
                index=index+1;
            end
            if (ENC(ii-1, jj+1))
                imgList(index,1:2) = [ii-1, jj+1];
                index=index+1;
            end
            jump=1;
        end
    end
end

if (~jump)
    %% diag
    DiagList =[];
    ind = 1;
    if (ENC(ii-1, jj-1))
        DiagList(ind, 1:3) = [(ii-1 - 8)^2 + (jj-1-8)^2 ii-1 jj-1] ;
        ind=ind+1;
    end
    if (ENC(ii-1, jj+1))
        DiagList(ind, 1:3) = [(ii-1 - 8)^2 + (jj+1-8)^2 ii-1 jj+1] ;
        ind=ind+1;
    end
    if (ENC(ii+1, jj-1))
        DiagList(ind, 1:3) = [(ii+1 - 8)^2 + (jj-1-8)^2 ii+1 jj-1] ;
        ind=ind+1;
    end
    if (ENC(ii+1, jj+1))
        DiagList(ind, 1:3) = [(ii+1 - 8)^2 + (jj+1-8)^2 ii+1 jj+1] ;
        ind=ind+1;
    end
    if (~isempty(DiagList))
        [val, pos] = sort(DiagList(:,1));
        nrRef = min(4,index-1+ size(DiagList,1));
        imgList(index:nrRef,1:2) = DiagList(1:nrRef-(index-1), 2:3);
    else
        nrRef = index-1;
    end
else
    nrRef = min(4,size(imgList,1));
end

end