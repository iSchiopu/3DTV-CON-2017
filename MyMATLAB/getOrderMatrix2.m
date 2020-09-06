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

function [MyOrder] = getOrderMatrix2()

I = abs([7:-1:-7]');
I2 = I(:,ones(1,15));
J2 = I2';
Q = I2.^2 + J2.^2;
Q(Q>61)=100;

MyOrder=zeros(15,15);
index  =1; 
for i=0:61
    pos = find(Q==i);
    if (~isempty(pos));
        MyOrder(pos) = [index:index+length(pos)-1];
        index = index + length(pos);
    end
end

end