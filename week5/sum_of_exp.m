%% sum of exponentials model
% f(t) = a_1 * exp(-t/tau_1) + a_2 * exp(-t/tau_2) + c

%% generate some fake data
% measure t in seconds
tau_1_real = 0.005;
tau_2_real = 0.06;
a_1_real = 1;
a_2_real = -1;
baseline_real = -0.10;
noise = 0.1;
taxis = 0:0.001:0.2;

trace = a_1_real * exp(-taxis/tau_1_real) + a_2_real * exp(-taxis/tau_2_real) + baseline_real;
data = trace + noise * randn(1, length(trace)); 
clf
plot(taxis, trace)
hold on
plot(taxis, data, 'linestyle', 'none', 'marker', 'o')

%% define a function to feed to the optimizer

model_fun = @(beta, t) ( beta(1) * exp(-t/beta(2)) + beta(3) * exp(-t/beta(4)) + beta(5));

sse_fun = @(beta) ( sum((model_fun(beta, taxis) - data).^2) );

%% do optimization to fit model
beta = fminsearch(sse_fun, [0.5, 0.01, 0.5, 0.01, 0]);

%% plot on top
predictions = model_fun(beta, taxis);

plot(taxis, predictions, 'linewidth', 1.5, 'color', 'r')

%% alternately

% function sse_fun = make_sse_fun(tdata, ydata)
% model_fun = @(beta, t) ( beta(1) * exp(-t/beta(2)) + beta(3) * exp(-t/beta(4)) + beta(5));
% sse_fun = @(beta) ( sum((model_fun(beta, tdata) - ydata).^2) );
% end


%% in the case of more complex models
% assume we have some function LogLikelihood(params, data)
% then define
% opt_fun = @(beta)(-LogLikelihood(beta, my_data));