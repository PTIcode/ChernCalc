function chern_nb = chern2(epsilon, data, nband, valley, params, a)
% calculate the valley Chern number at K or K'  or the total Chern number
% (the limit of integration is vertical-half the BZ)
%
%
%

Nkx = params(3);
Nky = params(4);

Nxmid = Nkx/2;
dim = 2*Nxmid+(Nky-2)*2;

phase = 0;
prod = 1;

kx = zeros(1, dim);
ky = zeros(1, dim);

iter = 1;

if (valley == 0)
    for nkx=1:Nxmid
        kx(iter) = nkx;
        ky(iter) = 1;
        iter = iter + 1;
    end
    for nky=2:Nky
        kx(iter) = Nxmid;
        ky(iter) = nky;
        iter = iter + 1;
    end
    for nkx=1:Nxmid
        kx(iter) = Nxmid - nkx + 1;
        ky(iter) = Nky;
        iter = iter + 1;
    end
    for nky=1:Nky-1
        kx(iter) = 1;
        ky(iter) = Nky - nky + 1;
        iter = iter + 1;
    end
elseif (valley == 1)
    for nkx=Nxmid:Nkx
        kx(iter) = nkx;
        ky(iter) = 1;
        iter = iter + 1;
    end
    for nky=2:Nky
        kx(iter) = Nkx;
        ky(iter) = nky;
        iter = iter + 1;
    end
    for nkx=1:Nxmid
        kx(iter) = Nkx - nkx + 1;
        ky(iter) = Nky;
        iter = iter + 1;
    end
    for nky=1:Nky-1
        kx(iter) = Nxmid +1;
        ky(iter) = Nky - nky + 1;
        iter = iter + 1;
    end
elseif (valley == 2)
    for nkx=1:Nkx
        kx(iter) = nkx;
        ky(iter) = 1;
        iter = iter + 1;
    end
    for nky=2:Nky
        kx(iter) = Nkx;
        ky(iter) = nky;
        iter = iter + 1;
    end
    for nkx=1:Nkx
        kx(iter) = Nkx - nkx + 1;
        ky(iter) = Nky;
        iter = iter + 1;
    end
    for nky=1:Nky-1
        kx(iter) = 1;
        ky(iter) = Nky - nky + 1;
        iter = iter + 1;
    end
end


for i=1:dim
    if (i==dim)
        j = 1;
    else
        j = i+1;
    end
    left = data(:, :, kx(i), ky(i), nband);
    right = data(:, :, kx(j), ky(j), nband);
    prod = prod * inner_prod(epsilon, left, right, params, a);
end

phase = imag( log(prod) );

chern_nb = phase / (2*pi());


end