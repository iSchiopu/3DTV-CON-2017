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

function vecini = findMyNeig(ireg, D)

[nr nc] = size(D);

[ii jj] = find(D == ireg);
ii = [ii    ii  ii+1 ii-1];
ii = ii(:);
jj = [jj+1 jj-1 jj jj];
jj = jj(:);

p1= ii<1;
ii(p1)=[];
jj(p1)=[];

p2 = ii>nr;
ii(p2)=[];
jj(p2)=[];

p1= jj<1;
ii(p1)=[];
jj(p1)=[];

p2 = jj>nc;
jj(p2)=[];
ii(p2)=[];
pos = sub2ind([nr nc], ii, jj);
vecini = unique(D(pos));
vecini(vecini==ireg)=[]; %remove himsef


end
