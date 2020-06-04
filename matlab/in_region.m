function cond = in_region(k, valley)

a=1;
cond = 0;

x = k(1);
y = k(2);

b1 = [1, -1/sqrt(3)] *(2*pi()/a);
b2 = [0, 2/sqrt(3)] *(2*pi()/a);

v_shift = [0, 0];
% v_shift = 1/3. * b1 + 2/3. * b2 ;

A = [0, 0] -v_shift;
B = b1 -v_shift;
C = b1 + b2 -v_shift;
D = b2 -v_shift;

% (AB) : yP = yA + (xP-xA)*c_AB
c_AB = (B(2)-A(2))/(B(1)-A(1));

% (AC) : yP = yA + (xP-xA)*c_AC
c_AC = (C(2)-A(2))/(C(1)-A(1));

% (DC) : yQ = yD + (xP-xD)*c_DC
c_DC = (C(2)-D(2))/(C(1)-D(1));

if (valley==0)
    if ( y>=B(2) && y<=C(2) )
        if ( y<=A(2) )
            xP = A(1) + (y-A(2))/c_AB;
            if ( x>=xP && x<=B(1) )
                cond = 1;
            end
        elseif ( y>=A(2) )
            xQ = A(1) + (y-A(2))/c_AC;
            if ( x>=xQ && x<=B(1) )
                cond = 1;
            end
        end
    end
end

if (valley==1)
    if ( y>=A(2) && y<=D(2) )
        if ( y<=C(2) )
            xP = A(1) + (y-A(2))/c_AC;
            if ( x>=A(1) && x<=xP )
                cond = 1;
            end
        elseif ( y>=C(2) )
            xQ = D(1) + (y-D(2))/c_DC;
            if ( x>=A(1) && x<=xQ )
                cond = 1;
            end
        end
    end
end

end