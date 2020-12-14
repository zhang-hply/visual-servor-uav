function [sys, x0, str, ts] = ImageBased_Pplant(t, x, u, flag)
switch flag,
    case 0,
        [sys, x0, str, ts] = mdlInitializeSizes;
    case 1,
        sys=mdlDerivatives(t,x,u);
    case 3,
        sys=mdlOutputs(t,x,u);
    case {2, 4, 9}
        sys = [];
    otherwise
        error(['Unhandled flag = ', num2str(flag)]);
end

function [sys, x0, str, ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 11;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 7;
sizes.NumInputs      = 9;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[0 0 0 cos(0.174) 0 0 sin(0.174) 0 0.3 0.4 sqrt(0.75)];
str=[];
ts=[-1 0];

function sys=mdlDerivatives(t,x,u)
ImageBased_init;
tao_x = u(1); tao_y = u(2); tao_z = u(3);
omega1 = u(4); omega2 = u(5); omega3 = u(6);

omega1_es = x(1); omega2_es = x(2); omega3_es = x(3);
q1 = x(4); q2 = x(5); q3 = x(6); q4 = x(7);
qf1 = x(8); qf2 = x(9); qf3 = x(10); qf4 = x(11); 

rTr = Gamma([qf1, qf2, qf3, qf4])' * Gamma([q1, q2, q3, q4]);
S = Skew([Jx * omega1_es, Jy * omega2_es, Jz * omega3_es]);
rQ = Gamma([q1, q2, q3, q4]);

domega1_es = (S(1, :) * [omega1_es, omega2_es, omega3_es]' + 0.5 * k1 * rTr(1, :) * [omega1 - omega1_es, omega2 - omega2_es, omega3 - omega3_es]' + tao_x) / Jx;
domega2_es = (S(2, :) * [omega1_es, omega2_es, omega3_es]' + 0.5 * k1 * rTr(2, :) * [omega1 - omega1_es, omega2 - omega2_es, omega3 - omega3_es]' + tao_y) / Jy;
domega3_es = (S(3, :) * [omega1_es, omega2_es, omega3_es]' + 0.5 * k1 * rTr(3, :) * [omega1 - omega1_es, omega2 - omega2_es, omega3 - omega3_es]' + tao_z) / Jz;

dq1 = 0.5 * rQ(1, :) * [omega1, omega2, omega3]';
dq2 = 0.5 * rQ(2, :) * [omega1, omega2, omega3]';
dq3 = 0.5 * rQ(3, :) * [omega1, omega2, omega3]';
dq4 = 0.5 * rQ(4, :) * [omega1, omega2, omega3]';

dqf1 = r * (q1 - qf1);
dqf2 = r * (q2 - qf2);
dqf3 = r * (q3 - qf3);
dqf4 = r * (q4 - qf4);

sys(1) = domega1_es; sys(2) = domega2_es; sys(3) = domega3_es;
sys(4) = dq1; sys(5) = dq2; sys(6) = dq3; sys(7) = dq4;
sys(8) = dqf1; sys(9) = dqf2; sys(10) = dqf3; sys(11) = dqf4;

function sys = mdlOutputs(t, x, u)
omega1_es = x(1); omega2_es = x(2); omega3_es = x(3);
q1 = x(4); q2 = x(5); q3 = x(6); q4 = x(7);

sys(1) = omega1_es; sys(2) = omega2_es; sys(3) = omega3_es;
sys(4) = q1; sys(5) = q2; sys(6) = q3; sys(7) = q4;