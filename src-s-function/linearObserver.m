function dy = linearObserver(t, y)
lp = 1; ld = 20;
delta = [sin(t); 2 * sin(0.5 * t); 3* sin(20 * t)];
dy = zeros(6,1);
dy(1:3) = y(4:6) + ld * (delta - y(1:3));
dy(4:6) = lp * ld * (delta - y(1:3));