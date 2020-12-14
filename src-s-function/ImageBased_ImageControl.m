function [sys,x0,str,ts]=ImageBased_ImageControl(t,x,u,flag)
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
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 12;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
% ImageBased_initParameter;
x0=[-0.8252 -0.3626 2];
str=[];
ts=[-1 0];

function sys=mdlDerivatives(t,x,u)
% omega2 = u(2); omega3 = u(3);
% phi = u(4); theta = u(5); psi = u(6);
% dpsi = sin(phi) / cos(theta) * omega2 + cos(phi) / cos(theta) * omega3;
phi = u(1); theta = u(3); psi = u(5);
dpsi = u(6);
dx = u(8); dy = u(10); dz = u(12);
% 
% psi = u(1); dpsi = u(2);
% dx = u(4); dy = u(6); dz = u(8);


ImageBased_init;

qx = x(1); qy = x(2); qz = x(3);

dqx = dpsi * qy - (cos(psi) * dx - sin(psi) * dy) / z_star + deltax / z_star;
dqy = -dpsi * qx  - (sin(psi) * dx + cos(psi) * dy) / z_star + deltay / z_star;
dqz = -dz / z_star + deltaz / z_star;

% dqx = dpsi * qy + deltax / z_star;
% dqy = -dpsi * qx + deltay / z_star;
% dqz =  deltaz / z_star;
sys(1) = dqx;
sys(2) = dqy;
sys(3) = dqz;

function sys = mdlOutputs(t, x, u)
ImageBased_init;
% x
qx = x(1); qy = x(2); qz = x(3);
sys(1) = qx; sys(2) = qy; sys(3) = qz;






