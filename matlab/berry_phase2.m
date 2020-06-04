function phase = berry_phase2(epsilon, data, nkx, nky, nband, params, a)
% for single band
% Calculate the Berry phase for each plaquettes composed of 4 k-points circulating in anti-clockwise way
% The 4 k-points form a square in k-space and the Berry phase is associated with the k-point (nkx, nky) located in the bottom-left corner
% A parallel transport gauge is performed so that the Berry phase is only non-zero close to the magnetic monopole
% The berry phase is forced to be in the branch (-pi, +pi)

Nkx = params(3);
Nky = params(4);

phase = 0;
prod = 1;

if ((nkx == Nkx) && (nky ~= Nky))
    % right boundary
    kx = [1, 2, 2, 1];
    ky = [nky, nky, nky+1, nky+1];
elseif ((nkx ~= Nkx) && (nky == Nky))
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

if (nkx==1 && nky==1)
    kx;
    ky;
end


for i=1:4
    if (i==4)
        j = 1;
    else
        j = i+1;
    end
    left = data(:, :, kx(i), ky(i), nband);
    right = data(:, :, kx(j), ky(j), nband);
    prod = prod * inner_prod(epsilon, left, right, params, a);
end


phase = imag( log(prod) );

iter = 0;
if ( phase < -pi() )
    while ( phase < -pi() )
        s='less than -pi';
        iter = iter + 1;
        phase = phase + 2*pi();
    end
elseif ( phase > pi() )
    while ( phase > pi() )
        s='more than pi';
        iter = iter + 1;
        phase = phase - 2*pi();
    end
end

end