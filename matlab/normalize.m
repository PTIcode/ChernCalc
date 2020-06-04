function [data] = normalize(epsilon, data, params,a)
% Normalize the field profiles
%
%

Nband = params(1);
Nkx = params(3);
Nky = params(4);

for nband=1:Nband
    for nkx=1:Nkx
        for nky=1:Nky
            dataset1 = data(:, :, nkx, nky, nband);
            norm_u = inner_prod(epsilon, dataset1, dataset1, params, a);
            if (norm_u == 0)
                norm_u = 1;
            end
            data(:, :, nkx, nky, nband) = dataset1 ./ sqrt( norm_u );
        end
    end
end

end