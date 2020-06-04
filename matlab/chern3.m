function [chern_nb_p, chern_nb_n] = chern3(berry_curv_plot, nband, dS)
%
% output sum of positive/negative Berry curv
%
% berry_curv_plot = zeros(Nk, 3, Nband);
% berry_curv_plot(ik, 1, nband) : kx
% berry_curv_plot(ik, 2, nband) : ky
% berry_curv_plot(ik, 3, nband) : Berry curvature


chern_nb_p = 0;
chern_nb_n = 0;

dims = size(berry_curv_plot);
Nk = dims(1);


for i=1:Nk
    if (berry_curv_plot(i, 3, nband) > 0)
        chern_nb_p = chern_nb_p + berry_curv_plot(i, 3, nband)*dS; 
    else
        chern_nb_n = chern_nb_n + berry_curv_plot(i, 3, nband)*dS; 
    end
end

chern_nb_p = chern_nb_p / (2*pi());
chern_nb_n = chern_nb_n / (2*pi());

end