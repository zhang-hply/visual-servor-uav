[t, y] = ode45(@linearObserver, [0 10], [0, 0, 0, 0, 0, 0]);
subplot(3,1,1)
plot(t, y(:, 1), 'r--', t, sin(t), 'b');
legend('\hat{\delta_x}', '\delta_x');

subplot(3,1,2)
plot(t, y(:, 2), 'r--', t, 2 * sin(0.5 * t), 'b');
legend('\hat{\delta_y}', '\delta_y');

subplot(3,1,3)
plot(t, y(:, 3), 'r--', t, 3* sin(20 * t), 'b');
legend('\hat{\delta_z}', '\delta_z');