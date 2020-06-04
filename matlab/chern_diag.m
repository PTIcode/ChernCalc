function chern_nb = chern_diag(berry_curv_plot, nband, dS, valley)
% calculate the valley Chern number at K or K' 
% (the limit of integration is diagonal-half the BZ)

chern_nb = 0;

dims = size(berry_curv_plot);

for i=1:dims(1)
    k = [berry_curv_plot(i, 1, nband), berry_curv_plot(i, 2, nband)];
    if (in_region(k, valley))
       chern_nb = chern_nb + berry_curv_plot(i, 3, nband)*dS; 
    end
end

chern_nb = chern_nb / (2*pi());

end