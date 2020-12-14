function [sys,x0,str,ts]=ImageBased_estimation(t,x,u,flag)
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
sizes.NumOutputs     = 3;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[0 0 0 0 0 0];
str=[];
ts=[-1 0];

function sys=mdlDerivatives(t,x,u)
delta_x = u(1); delta_y = u(2); delta_z = u(3);

delta_es_x = x(1); delta_es_y = x(2); delta_es_z = x(3);
delta_zero_x = x(4); delta_zero_y = x(5); delta_zero_z = x(6);

ImageBased_init;

ddelta_es_x = delta_zero_x + ld * (delta_x - delta_es_x);
ddelta_es_y = delta_zero_y + ld * (delta_y - delta_es_y);
ddelta_es_z = delta_zero_z + ld * (delta_z - delta_es_z);
ddelta_zero_x = lp * ld * (delta_x - delta_es_x);
ddelta_zero_y = lp * ld * (delta_y - delta_es_y);
ddelta_zero_z = lp * ld * (delta_z - delta_es_z);

sys(1) = ddelta_es_x; sys(2) = ddelta_es_y; sys(3) = ddelta_es_z;
sys(4) = ddelta_zero_x; sys(5) = ddelta_zero_y; sys(6) = ddelta_zero_z;

function sys=mdlOutputs(t,x,u)
delta_es_x = x(1); delta_es_y = x(2); delta_es_z = x(3);
x
sys(1) = delta_es_x; sys(2) = delta_es_y; sys(3) = delta_es_z;



