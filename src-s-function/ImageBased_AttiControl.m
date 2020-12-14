function [sys,x0,str,ts] = ImageBased_AttiControl(t,x,u,flag) 
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
sizes.NumInputs      = 15;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];

function sys=mdlOutputs(t,x,u)

phid = u(1); thetad = u(2);
omega1_es = u(3); omega2_es = u(4); omega3_es = u(5);
q1 = u(6); q2 = u(7); q3 = u(8); q4 = u(9); 
omegad1 = u(10);
omegad2 = u(14);
omegad3 = u(15);
domegad1 = u(11); domegad2 = u(12); domegad3 = u(13);

ImageBased_init;
R = (q1 ^ 2 - [q2 q3 q4] * [q2 q3 q4]') * eye(3) + 2 * ([q2 q3 q4]' * [q2 q3 q4] - q1 * Skew([q2 q3 q4]));
Rd = [cos(psid) sin(psid) 0; -sin(psid) cos(psid) 0; 0 0 1;]...
    * [cos(thetad) 0 -sin(thetad); 0 1 0; sin(thetad) 0 cos(thetad)]...
     * [1 0 0; 0 cos(phid) sin(phid); 0 -sin(phid) cos(phid)];
eR = 0.5 * SkewInverse(Rd' * R - R' * Rd);
ew = [omega1_es; omega2_es; omega3_es] - R' * Rd * [omegad1; omegad2; omegad3];
tao = - kR * eR - komega * ew - Skew([Jx * omega1_es, Jy * omega2_es, Jz * omega3_es])...
    * [omega1_es; omega2_es; omega3_es] - [Jx 0 0; 0 Jy 0; 0 0 Jz] * (Skew([omega1_es; omega2_es; omega3_es])...
    * R' * Rd * [omegad1; omegad2; omegad3] -  R' * Rd * [domegad1; domegad2; domegad3]);

sys(1) = tao(1); sys(2) = tao(2); sys(3) = tao(3);

