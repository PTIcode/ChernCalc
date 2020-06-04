function I = inner_prod(epsilon, left, right, params, a)
% return  : type double integration
% iner product : <left|right> === 2D-integration
% (Monte-Carrlo method used for 2D-integration)
% left/right : res x res matrix
% params  : object that gives info about grid size
% a : constant lattice

prod1 = conj(left) .* epsilon .* right;
N = params(2)^2;

% not sure ? look at doc mpb
% Surface unit cell
S = a*a*sqrt(3)/2;

mean = sum(sum(prod1)) / N;
I = S * mean;

end
%======================================