lamda = 0.0032;
x_init = [3 2 8];
a_star = 8e-7;

object = [0.25 0.5;
          -0.25 0.5;
          -0.25 -0.5;
          0.25 -0.5];
      
u = 0.0032 / x_init(3) * (x_init(1) * ones(4, 1) - object(:, 1));   
v = 0.0032 / x_init(3) * (x_init(2) * ones(4, 1) - object(:, 2)); 


ug = sum(u) / 4;
vg = sum(v) / 4;

a = norm(u) ^ 2 + norm(v) ^ 2;

q = zeros(3, 1);

q(3) = sqrt(a_star / a);
q(1) = q(3) * ug / lamda;
q(2) = q(3) * vg / lamda;


