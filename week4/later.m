function T = later(theta, mu, sigma, Ntrials, max_RT)
% implements the LATER model of Carpenter, returning an array of decision
% times T
% theta is the decision boundary
% mu is the mean of accumulation slopes across trials
% sigma is the standard deviation of slopes across trials

r = mu + sigma * randn(Ntrials, 1);
T = theta ./ r;
T(T < 0 | T > max_RT) = max_RT;