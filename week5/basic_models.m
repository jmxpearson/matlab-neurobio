%% draw counts from multinomial
p = [0.1, 0.5, 0.2, 0.2];
N = 100;
counts = mnrnd(N, p);

%% show that the solution in the notes works
% $$L \propto p_1^{n_1} p_2^{n_2} \cdots p_K^{n_K}$$
%
% $$\log L = \sum_i n_i \log p_i + const$$
%
% Now $p_K = 1 - \sum_{i=1}^{K-1} p_i$ and $N_K = N - \sum_{i=1}^{K-1}$ so
%
% $$\frac{\partial p_K}{\partial p_i} = -1$$ 
%
% for $i = 1\ldots K - 1$, which gives
%
% $$\frac{\partial}{\partial p_i} \log L = \frac{n_i}{p_i} - 
% \frac{n_K}{p_K} = \frac{n_i}{n_i/N} - \frac{n_K}{n_K/N} = N - N = 0$$
%
% so the gradient vanishes in all directions and $p$ is a local optimum.
% Similarly,
% 
% $$\frac{\partial}{\partial p_i^2} \log L = -\frac{n_i}{p_i^2} - 
% \frac{n_K}{p_K^2} = -N^2\left(\frac{1}{n_i} + \frac{1}{n_K}\right) < 0$$
%
% so the solution is also a local maximum. (In truth, to show local
% maximum, we would need to calculate the Hessian, the matrix of second
% derivatives, and show that it is negative definite. That's a bit much to
% bite off for this exercise, so just trust me that it's true.)

%% calculate ML
phat = counts ./ N;  % reasonably close to p

%% make fake linear data
b0 = -1;
b1 = 0.85;
sig = 0.1;
N = 500;
xvals = rand(N, 1);
y = b0 + b1 * xvals + sig * randn(N, 1);

scatter(xvals, y);

%% make function to calculate SSE
X = [ones(N, 1) xvals];

sse = @(beta) sum((X * beta' - y).^2);

b_fitted = fminsearch(sse, [0, 0]);

%% plot
scatter(xvals, y);
hold on
refline(b_fitted(2), b_fitted(1));