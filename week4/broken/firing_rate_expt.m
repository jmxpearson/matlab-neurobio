function pval = firing_rate_expt(baseline, effect, Tbaseline, Tstim, ...
    trial_noise_std, Ntrials)
% Calculate the p-value of a paired t-test between firing rates in two
% epochs, a baseline and a stimulus period.
%
% PARAMETERS:
% baseline: baseline firing rate (spikes/s)
% effect: fractional change from baseline (e.g., 1.5 is a 50% change)
% Tbaseline: duration of baseline period (s)
% Tstim: duration of stimulus period (s)
% trial_noise_std: standard deviation of trial-to-trial variance in **log**
% firing rates
% Ntrials: number of repeats

% make random pairs of firing rates
baseline_rates = exp(log(baseline) * (1 + trial_noise_std * randn(Ntrials, 1)));
stim_rates = (log(effect * baseline) * (1 + trial_noise_std * randn(Ntrials, 1)));

% generate random spike counts
baseline_counts = poissrnd(baseline_rates);
stim_counts = poissrnd(stim_rates);

% empirical firing rates
obs_baseline_rates = baseline_counts / Tbaseline;
obs_stim_rates = stim_counts / Tstim;

% test
[~, pval] = ttest(obs_baseline_rates, obs_baseline_rates); 