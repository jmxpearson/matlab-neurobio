function power = calc_power(alpha, Nexpt, expfun, varargin)
% Calculate power (1 - false negative rate) for an experiment 
% defined in expfun. 
%
% PARAMETERS:
% alpha: desired false positive rate for test
% Nexpt: number of simulated experiments to run
% expfun: function handle that performs a test and returns a p-value
% varargin: structure of arguments to be passed on to expfun

pvals = nan(Nexpt, 1);
for ii = 1:Nexpt
    pvals(ii) = expfun(varargin{:});
end

power = mean(pvals < alpha);

