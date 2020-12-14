function y = SkewInverse(x)
y = zeros(3, 1);
y(1) = x(3, 2);
y(2) = x(1, 3);
y(3) = x(2, 1);