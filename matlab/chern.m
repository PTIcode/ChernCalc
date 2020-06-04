function chern_nb = chern(berry_curv_plot, nband, dS, valley)
% calculate the valley Chern number at K or K' 
% (the limit of integration is vertical-half the BZ)
% berry_curv_plot = zeros(Nk, 3, Nband);
% berry_curv_plot(ik, 1, nband) : kx
% berry_curv_plot(ik, 2, nband) : ky
% berry_curv_plot(ik, 3, nband) : Berry curvature

chern_nb = 0;

dims = size(berry_curv_plot);
Nmid = floor(dims(1)/2.);

if (valley == 0)
    for i=1:Nmid
       chern_nb = chern_nb + berry_curv_plot(i, 3, nband)*dS; 
    end
end

if (valley == 1)
    for i=Nmid:dims(1)
       chern_nb = chern_nb + berry_curv_plot(i, 3, nband)*dS; 
    end
end

chern_nb = chern_nb / (2*pi());

end