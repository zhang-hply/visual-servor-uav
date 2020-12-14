close all;
figure(1);
subplot(311);
plot(t,position(:,1),'b','linewidth',2);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
xlabel('Time(s)');ylabel('x');
legend('x');
subplot(312);
plot(t,position(:,3),'b','linewidth',2);
xlabel('Time(s)');ylabel('y');
legend('y');
subplot(313);
%zd=3*t./t;
zd=10*t./t;
plot(t,zd,'r--',t,position(:,5),'b','linewidth',2);
xlabel('Time(s)');ylabel('z');
legend('zd','z');

figure(2);
subplot(311);
plot(t,force(:,2)/pi*180,'r',t,angle(:,1)/pi*180,'k','linewidth',2);
legend('\theta_d (degree)','\theta (degree)');
subplot(312);
plot(t,force(:,3)/pi*180,'r',t,angle(:,3)/pi*180,'k','linewidth',2);
legend('\phi_d (degree)','\phi (degree)');
subplot(313);
plot(t,angle(:,5)/pi*180,'b','linewidth',2);
legend('\psi (degree)');

figure(3);
subplot(411);
plot(t,force(:,1),'k','linewidth',2);
legend('u1');
subplot(412);
plot(t,tao(:,1),'k','linewidth',2);
legend('u2');
subplot(413);
plot(t,tao(:,2),'k','linewidth',2);
legend('u3');
subplot(414);
plot(t,tao(:,3),'k','linewidth',2);
legend('u4');

figure(4);
subplot(311);
plot(t,q(:,1),'b','linewidth',2);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
xlabel('Time(s)');ylabel('qx');
legend('qx');
subplot(312);
plot(t,q(:,2),'b','linewidth',2);
xlabel('Time(s)');ylabel('qy');
legend('qy');
subplot(313);
%zd=3*t./t;
zd=10*t./t;
plot(t,q(:,3),'b','linewidth',2);
xlabel('Time(s)');ylabel('qz');
legend('qz');


figure(5);
subplot(311);
plot(t,delta(:,1),'b','linewidth',2);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
xlabel('Time(s)');ylabel('\delta_x');
legend('\delta_x');
subplot(312);
plot(t,delta(:,2),'b','linewidth',2);
xlabel('Time(s)');ylabel('\delta_y');
legend('\delta_y');
subplot(313);
%zd=3*t./t;
zd=10*t./t;
plot(t,delta(:,3),'b','linewidth',2);
xlabel('Time(s)');ylabel('\delta_z');
legend('\delta_z');