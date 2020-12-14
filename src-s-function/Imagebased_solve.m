function dx = Imagebased_solve(t, x)
ImageBased_init;
dx = zeros(21, 1);
%%%--- ---%%%
%%%--- position control ---%%%
if (norm(dx(16:18) + lp * x(16:18)) > eps)
    input_u = -DM * (dx(16:18) + lp * x(16:18)) / norm(dx(16:18) + lp * x(16:18));
else
     input_u = -DM * (dx(16:18) + lp * x(16:18)) / eps;
end
Fd = kr * dx(16:18) + lp * x(16:18) - input_u - g * e3;
u1 = norm(Fd) * m; phid = atan(-Fd(2) / norm([Fd(1) Fd(3)])); thetad = atan(Fd(1) / Fd(3));
%%%--- position plant ---%%%
R = [cos(x(6)) sin(x(6)) 0; -sin(x(6)) cos(x(6)) 0; 0 0 1]...
    * [cos(x(5)) 0 -sin(x(5)); 0 1 0; sin(x(5)) 0 cos(x(5))]...
    * [1 0 0; 0 cos(x(4)) sin(x(4)); 0 -sin(x(4)) cos(x(4))];
dx(7:9) = x(10:12);
dx(10:12) = -u1 / m * R * e3 + g * e3;
%%%--- image feature dynamics ---%%%
R_psi = [cos(x(6)) sin(x(6)) 0; -sin(x(6)) cos(x(6)) 0; 0 0 1];
dx(13:15) = -Skew(dx(6) * e3) * (x(13:15) - qz_d * e3) - R_psi' * x(10:12) / z_star + delta_a / z_star;
%%%--- parameter estimation ---%%%
dx(16:18) = x(19:21) + ld * (x(13:15) - qz_d * e3 - x(16:18));
dx(19:21) = lp * ld * (x(13:15) - qz_d * e3 - x(16:18));
%%%--- attitude control ---%%%
R = [cos(x(6)) sin(x(6)) 0; -sin(x(6)) cos(x(6)) 0; 0 0 1]...
    * [cos(x(5)) 0 -sin(x(5)); 0 1 0; sin(x(5)) 0 cos(x(5))]...
    * [1 0 0; 0 cos(x(4)) sin(x(4)); 0 -sin(x(4)) cos(x(4))];
Rd = [cos(psid) sin(psid) 0; -sin(psid) cos(psid) 0; 0 0 1;]...
    * [cos(thetad) 0 -sin(thetad); 0 1 0; sin(thetad) 0 cos(thetad)]...
    * [1 0 0; 0 cos(phid) sin(phid); 0 -sin(phid) cos(phid)];
omegad = [1 0 0; 0 cos(phid) 0; 0 0 -sin(phid)] * [diff(phid) diff(thetad) diff(thetad)]';
% omegad = [1 1 1]';
eR = 0.5 * SkewInverse(Rd' * R - R' * Rd);
ew = x(1:3) - R' * Rd * omegad;
tau = - kR * eR - komega * ew - Skew(J * x(1:3)) *  x(1:3) ...
    - J * (Skew(x(1:3)) * R' * Rd * omegad  -  R' * Rd * [diff(omegad(1)); diff(omegad(2)); diff(omegad(3))]);
% tau  = omegad;
%%%--- attitude plant ---%%%
dx(1:3) = (-Skew(x(1:3)) * (J * x(1:3)) + tau)' / J;
dx(4:6) = [1 sin(x(4)) * tan(x(5)) cos(x(4)) * tan(x(5));
    0 cos(x(4)) -sin(x(4));
    0 sin(x(4)) / cos(x(5)) cos(x(4)) / cos(x(5))] * x(1:3);

end