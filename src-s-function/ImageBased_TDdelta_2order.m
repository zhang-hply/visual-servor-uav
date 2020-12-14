function [sys,x0,str,ts] = ImageBased_TDdeltaz(t,x,u,flag) 
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
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0 0];
str = [];
ts  = [0 0];
function sys=mdlDerivatives(t,x,u)
epc=0.004;
v=u(1);

temp = (x(1) - v + 0.6 * abs((epc * x(2)) ^ (5 / 3)) * sign(epc * x(2))) ^ (1 / 5);
if abs(temp) < 1
    sat1 = temp;
else
    sat1 = sign(temp);
end

temp = abs((epc * x(2)) ^ (1 / 3)) * sign(epc * x(2));
if abs(temp) < 1
    sat2 = temp;
else
    sat2 = sign(temp);
end

sys(1) = x(2);
sys(2) = 1 / epc ^ 2 * (- sat1 - sat2); 
function sys=mdlOutputs(t,x,u)
sys(1)=x(2);
