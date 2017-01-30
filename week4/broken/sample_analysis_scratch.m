% scratchpad for working out some sample plots of behavior

%% load data
load '../../data/week4/pupiltest.mat'

%% prepare data
[pupil, taxis, t0] = prepdata(eyedata);

%% set options
dset.sr = 60;  % sampling rate of Tobii = 60 Hz
dset.t0 = t0;
dset.soundtime = [data.soundtime];  % eye tracker timestamps for sound time
dset.normtype = 0;  % 0 for subtractive, 1 for divisive
dset.plottype = 1;  % 0 for no sem, 1 for error shading, 2 for dotted lines
dset.trialvec = trialve; % was each trial standard or oddball
dset.pupil = pupil; % pupil time series
%% run task-specific analysis
tpre = -0.3;
tpost = 8;
analyze_oddball(dset, tpre, tpost)