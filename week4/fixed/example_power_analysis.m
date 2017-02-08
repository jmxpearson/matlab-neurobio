%% set up numbers
baseline = 20;  % Hz
Tbaseline = 0.8; % sec
Tstim = 0.5;  % sec
effect = 1.2;  % gain multiplier
trial_noise_std = 0.05;  % percent change on log scale
Ntrials = 40; % number of trials
Nexpt = 1000; % number of simulated experiments
alpha = 0.05;

%% calculate power
calc_power(alpha, Nexpt, @firing_rate_expt, baseline, effect, Tbaseline, Tstim, ...
    trial_noise_std, Ntrials)