function [sys,x0,str,ts] = ImageBased_TDomega_d2(t,x,u,flag) 
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
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0 0 0];
str = [];
ts  = [0 0];
function sys=mdlDerivatives(t,x,u)
ebs1=0.10;
vt=u(1);
temp1=(abs(ebs1*x(2))^(9/7))*sign(ebs1*x(2));
temp2=x(1)-vt+temp1;
temp2=abs(temp2)^(1/3)*sign(temp2);
temp3=abs(ebs1^2*x(3))^(3/5)*sign(ebs1^2*x(3));
sys(1)=x(2);
sys(2)=x(3);
sys(3)=(-2^(3/5)*4*temp2-4*temp3)*1/ebs1^3;
function sys=mdlOutputs(t,x,u)
sys(1)=x(2);
