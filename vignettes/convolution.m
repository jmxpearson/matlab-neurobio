W = 11;
v = ones(W, 1)/W;
plot(v)

taxis = linspace(0, 2*pi, 100)';
u = sin(2.8 * taxis) + 0.2 * randn(length(taxis), 1);
plot(u)

plot(conv(u, v))  % i.e., 'full'

plot(conv(u, v, 'same'))
plot(conv(u, v, 'valid'))