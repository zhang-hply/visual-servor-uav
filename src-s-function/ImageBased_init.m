g = 9.8; m = 2;
e3 = [0 0 1]';
qz_d = 1;
z_star = 4;
deltax = 0; deltay = 0; deltaz = 0;
% delta_a = [1 0 0]';
ld = 20; 

%%%%%----位置控制器参数----%%%%
mu1 = 0.1; D1 = 1; D2 = 1;
DM = mu1 * D1 + D2;
kr = 8; eps = 20;lp = 0.2;

Jx = 0.0081; Jy = 0.0081; Jz = 0.0142;
% J = [Jx 0 0; 0 Jy 0; 0 0 Jz];
%%%%----观测器参数----%%%%%
k1 = 10; r = 5;

kR = 8.81; komega = 2.54;
psid = 0;
