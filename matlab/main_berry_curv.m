clear all
clc

a = 1;

% params : Nband resolution Nkx Nky
params = importdata('params.txt')
Nband = params(1);
res = params(2);
Nkx = params(3);
Nky = params(4);

Nk = Nkx * Nky;

epsilon = importdata('epsilon.txt', ',');

data = create_data(params);
data = normalize(epsilon, data, params, a);


berry_curv = zeros(Nkx, Nky, Nband);
berry_curv_plot = zeros(Nk, 3, Nband);

b2 = 2 / (sqrt(3));

dkx = 1./Nkx * (2*pi() /a);
dky = 1./Nky * (2/sqrt(3)) * (2*pi() /a);
dS = dkx * dky;

k_K = [2/3.; 0];
berry_curv_plot_K = zeros(Nky, 2, Nband);
dkx_min = 100;
dkx_min_index = 0;

for nkx=1:Nkx
    kx = (nkx-1) * 1. / (Nkx-1);
    if (abs(k_K(1)-kx)<dkx_min)
        dkx_min_index = nkx;
        dkx_min = abs(k_K(1)-kx);
    end
end

for nband=1:1
    iter = 1;
    for nkx=1:Nkx
        for nky=1:Nky
            if (nband >= 2 && nband <= 3)
                berry_curv(nkx, nky, nband) = berry_phase3(epsilon, data, nkx, nky, params, a, 2, 3) / dS;
            else
                berry_curv(nkx, nky, nband) = berry_phase2(epsilon, data, nkx, nky, nband, params, a) / dS;
            end
            
            kpath1 = (nkx-1) * 1. / (Nkx-1);
            kpath2 = (nky-1) * 1. / (Nky-1);
            kx = kpath1;
            ky = b2*kpath2 - kpath1 / sqrt(3) ;
            
            berry_curv_plot(iter, 1, nband) = kx;
            berry_curv_plot(iter, 2, nband) = ky;
            berry_curv_plot(iter, 3, nband) = berry_curv(nkx, nky, nband);
            iter = iter + 1;
            
            if (nkx == dkx_min_index)
                berry_curv_plot_K(nky, 1, nband) = ky;
                berry_curv_plot_K(nky, 2, nband) = berry_curv(nkx, nky, nband);
            end
            
        end
    end
end


for nband=1:1
    dlmwrite(strcat('berry_curv_', num2str(nband), '.txt'), berry_curv_plot(:,:,nband), 'delimiter', '\t', 'precision', 5, 'newline', 'pc');
    dlmwrite(strcat('berry_curv_', num2str(nband), '_K.txt'), berry_curv_plot_K(:,:,nband), 'delimiter', '\t', 'precision', 5, 'newline', 'pc');
end


%
% print valley Chern number or total Chern number from different integration scheme
%

% calculate the valley Chern number at K or K' (the limit of integration is diagonal-half the BZ)
chern_nb_K0_d = chern_diag(berry_curv_plot, 1, dS, 0) 
chern_nb_K1_d = chern_diag(berry_curv_plot, 1, dS, 1) 

% calculate the valley Chern number at K or K' (the limit of integration is vertical-half the BZ)
chern_nb_K0 = chern(berry_curv_plot, 1, dS, 0) 
chern_nb_K1 = chern(berry_curv_plot, 1, dS, 1) 

chern_nb_K0 + chern_nb_K1 

% calculate the valley Chern number at K (the limit of integration is vertical-half the BZ), or the total Chern number
chern_nb2 = chern2(epsilon, data, 1, 0, params, a) 
chern_nb2_tot = chern2(epsilon, data, 1, 2, params, a) 

% calculate the sum of positive/negative Berry curv
[chern_nb_p, chern_nb_n] = chern3(berry_curv_plot, 1, dS) 



