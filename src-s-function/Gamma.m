function A = Gamma(Q)

A = [-Q(2) -Q(3) -Q(4);
    Q(1) * eye(3) + Skew(Q(2:4))];
