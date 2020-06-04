function phase = berry_phase3(epsilon, data, nkx, nky, params, a, nband1, nband2)
% for multi- band
% Calculate the Berry phase for each plaquettes composed of 4 k-points circulating in anti-clockwise way
% The 4 k-points form a square in k-space and the Berry phase is associated with the k-point (nkx, nky) located in the bottom-left corner
% A parallel transport gauge is performed so that the Berry phase is only non-zero close to the magnetic monopole
% The berry phase is forced to be in the branch (-pi, +pi)

Nkx = params(3);
Nky = params(4);

tab_phase = zeros(1,nband2-nband1+1);
tab_prod = ones(1,nband2-nband1+1);

if ((nkx == Nkx) && (nky ~= Nky))
    % right boundary
    kx = [1, 2, 2, 1];
    ky = [nky, nky, nky+1, nky+1];
elseif ((nky == Nky) && (nkx ~= Nkx))
    % top boundary
    kx = [nkx, nkx+1, nkx+1, nkx];
    ky = [1, 1, 2, 2];
elseif (nkx == Nkx && nky == Nky)
    % top-right corner
    kx = [1, 2, 2, 1];
    ky = [1, 1, 2, 2];
else
    kx = [nkx, nkx+1, nkx+1, nkx];
    ky = [nky, nky, nky+1, nky+1];
end


iter_band = 1;
for nband=nband1:nband2
    
    for i=1:4
        if (i==4)
            j = 1;
        else
            j = i+1;
        end
        left = data(:, :, kx(i), ky(i), nband);
        right = data(:, :, kx(j), ky(j), nband);
        tab_prod(iter_band) = tab_prod(iter_band) * inner_prod(epsilon, left, right, params, a);
    end
    
    
    tab_phase(iter_band) = imag( log(tab_prod(iter_band)) );
    
    iter = 0;
    if ( tab_phase(iter_band) < -pi() )
        while ( tab_phase(iter_band) < -pi() )
            s='less than -pi';
            iter = iter + 1;
            tab_phase(iter_band) = tab_phase(iter_band) + 2*pi();
        end
    elseif ( tab_phase(iter_band) > pi() )
        while ( tab_phase(iter_band) > pi() )
            s='more than pi';
            iter = iter + 1;
            tab_phase(iter_band) = tab_phase(iter_band) - 2*pi();
        end
    end
    
    iter_band = iter_band + 1;
    
end

phase = sum(tab_phase);

end