function data = create_data(params)
% params should be [Nband res Nkx Nky]
% Create data in form matrix : (res x res) x (Nkx x Nky) x Nband
% The .txt files we need to read are of the form ev_i_j_real.txt and ev_i_j_imag.txt
% i stands for index of k-point in 1D major col order (i.e sweep of nky for one nkx) : i=0:(Nkx*Nky)-1
% j stands for number of the band we have : j=1:Nband

Nband = params(1);
res = params(2);
Nkx = params(3);
Nky = params(4);

data = zeros(res, res, Nkx, Nky, Nband);

Nk = Nkx * Nky;
base_name_ev = 'ev';

for nband=1:Nband
    iter_nky = 1;
    iter_nkx = 1;
    for nki=0:Nk-1
        filename = strcat(base_name_ev, '_', num2str(nki), '_', num2str(nband), '.h5');
        %h5disp(filename);
        dataset1_real = h5read(filename, '/z.r');
        dataset1_imag = h5read(filename, '/z.i');
        dataset1 = dataset1_real + 1i * dataset1_imag;
        if (iter_nky == Nky+1)
            iter_nky = 1;
            iter_nkx = iter_nkx + 1;
        end
        data(:, :, iter_nkx, iter_nky, nband) = dataset1'; % transposed because x,y have been reversed
        iter_nky = iter_nky + 1;
    end
end

end
%======================================