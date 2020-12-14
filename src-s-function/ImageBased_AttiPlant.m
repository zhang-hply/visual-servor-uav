function [sys,x0,str,ts]=ImageBased_AttiPlant(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 6;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 6;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[1 2 3 0.174 0 0];
str=[];
ts=[-1 0];

function sys=mdlDerivatives(t,x,u)
tao_x = u(1); tao_y = u(2); tao_z = u(3);

ImageBased_init;

omega1 = x(1); omega2 = x(2); omega3 = x(3);
phi = x(4); theta = x(5); psi = x(6);

domega1 = (-(Jz - Jy) * omega2 * omega3 + tao_x) / Jx;
domega2 = (-(Jx - Jz) * omega1 * omega3 + tao_y) / Jy;
domega3 = (-(Jy - Jx) * omega1 * omega2 + tao_z) / Jz;
dphi = omega1 + sin(phi) * tan(theta) * omega2 + cos(phi) * tan(theta) * omega3;
dtheta = cos(phi) * omega2 - sin(phi) * omega3;
dpsi = sin(phi) / 1 * omega2 + cos(phi) / cos(0) * omega3;

sys(1) = domega1; sys(2) = domega2; sys(3) = domega3;
sys(4) = dphi; sys(5) = dtheta; sys(6) = dpsi;

function sys=mdlOutputs(t,x,u)
omega1 = x(1); omega2 = x(2); omega3 = x(3);
phi = x(4); theta = x(5); psi = x(6);

sys(1) = omega1; sys(2) = omega2; sys(3) = omega3;
sys(4) = phi; sys(5) = theta; sys(6) = psi;





