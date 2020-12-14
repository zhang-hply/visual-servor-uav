function [sys,x0,str,ts] = ImageBased_PControl(t,x,u,flag) 
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 12;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];

function sys=mdlOutputs(t,x,u)
ImageBased_init;
DM = mu1 * D1 + D2;
psi = u(11);
splusr1 = (lp * u(1) + u(4)); 
splusr2 = (lp * u(2) + u(5)); 
splusr3 = (lp * u(3) + u(6)); 
norm_splusr = sqrt(splusr1 ^ 2 + splusr2 ^ 2 + splusr3 ^ 2);

if norm_splusr > eps
    input_u1 = -DM * splusr1 / norm_splusr;
    input_u2 = -DM * splusr2 / norm_splusr;
    input_u3 = -DM * splusr3 / norm_splusr;
else
    if norm_splusr <= eps
        input_u1 = -DM * splusr1 / eps;
        input_u2 = -DM * splusr2 / eps;
        input_u3 = -DM * splusr3 / eps;
    end
end

Fdx = -(kr * (lp * u(1) + u(4)) - input_u1);
Fdy = -(kr * (lp * u(2) + u(5)) - input_u2);
Fdz = -(kr * (lp * u(3) + u(6)) - input_u3);

A = -[cos(psi) -sin(psi) 0; sin(psi) cos(psi) 0; 0 0 1]' * [Fdx; Fdy; Fdz];
Fdx = A(1); Fdy = A(2); Fdz = A(3);
u1 = sqrt(Fdx ^ 2 + Fdy ^ 2 + (Fdz-g ^ 2) * m;
% phid = atan(-Fdy / sqrt(Fdx ^ 2 + Fdz ^ 2));
% thetad = atan(Fdx / Fdz);

phid = atan((sin(psi) * cos(psi) * Fdx - cos(psi) * cos(psi) * Fdy) / Fdz);

X = cos(psi) * (cos(psi) * Fdx + sin(psi) * Fdy) / Fdz;
if(X > 1)
    thetad = pi / 2;
else
    if(X < -1)
        thetad = -pi / 2;
    else
        thetad = asin(X);        
    end
end



sys(1) = u1;
sys(2) = phid;
sys(3) = thetad;















