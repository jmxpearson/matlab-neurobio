load '../data/week2/fef_spikes.mat'

% data notes
% spikes is Ntrials x Nunits; contains timestamps relative to motion onset
% H and V are Ntrials x time (Ntimes ms)

% bin spike times to get binary signal
[Ntrials, Nunits] = size(spikes);
[~, Ntimes] = size(H);

% first pass, works on sample data
[counts, ~] = histcounts(spikes{1, 1}, 0:Ntimes);

sum(counts) == length(spikes{1, 1})  % test for correctness

% generalize
unit = 1;
trial = 1;
edges = 0:Ntimes;  % what if we want bigger bins later?
[counts, ~] = histcounts(spikes{trial, unit}, edges);
sum(counts) == length(spikes{trial, unit})  % test for correctness

% now with loops
edges = 0:Ntimes;  % what if we want bigger bins later?
raster = nan(length(edges) - 1, Ntrials, Nunits);
for uu = 1:Nunits
    for tt = 1:Ntrials
        raster(:, tt, uu) = histcounts(spikes{tt, uu}, edges);
    end
end

spcounts = cellfun(@length, spikes);
all(spcounts == squeeze(sum(raster, 1)))

% see rasterize.m for function
raster = rasterize(spikes, 0, Ntimes, 1);
spcounts = cellfun(@length, spikes);
all(spcounts == squeeze(sum(raster, 1)))

% raster plot
imagesc(raster(:, :, 1)')

% multipanel plot:
figure
subplot(3, 1, 1)
imagesc(raster(:, :, 1)')
subplot(3, 1, 2)
plot(H', 'color', 'k')
xlim([0, Ntimes])
ylim([-50, 50])
title('horizontal')
subplot(3, 1, 3)
plot(V', 'color', 'k')
xlim([0, Ntimes])
ylim([-50, 50])
title('vertical')

% mean firing rate from psth
dt = 1;
fr = raster ./ dt;
taxis = 1:dt:Ntimes;
unit = 1;
fr_mean = mean(fr(:, :, unit), 2);
plot(taxis, fr_mean)
hold on
fr_smooth = smooth(fr_mean, 31);  % 21 bins = 20 ms window for dt = 1
plot(taxis, fr_smooth, 'LineWidth', 1.5)


% estimating firing rate
t_win = 50;  % window length (in ms)
wid = floor(t_win/dt);

% for smooth, wid needs to be odd, so do this:
if mod(wid, 2) == 0  
    wid = wid + 1;
end

[Ntimes, Ntrials, Nunits] = size(raster);

% preallocate matrix
sm_fr = nan(size(fr));
for trial = 1:Ntrials
    for unit = 1:Nunits
        sm_fr(:, trial, unit) = smooth(fr(:, trial, unit), wid);
    end
end

% plot this
figure
subplot(3, 1, 1)
plot(sm_fr(:, :, 1))
subplot(3, 1, 2)
plot(H', 'color', 'k')
xlim([0, Ntimes])
ylim([-50, 50])
title('horizontal')
subplot(3, 1, 3)
plot(V', 'color', 'k')
xlim([0, Ntimes])
ylim([-50, 50])
title('vertical')            

% what about a convolution?
taxis = -1000:1000;  % make a time axis of 1000 ms
t_wid = 20;  % width of kernel (in ms)
gauss_kernel = normpdf(taxis, 0, t_wid);
gauss_kernel = gauss_kernel ./ sum(gauss_kernel);

% preallocate matrix
kern_sm_fr = nan(size(fr));
for trial = 1:Ntrials
    for unit = 1:Nunits
        kern_sm_fr(:, trial, unit) = ...
            conv(fr(:, trial, unit), gauss_kernel, 'same');
    end
end

figure
subplot(3, 1, 1)
plot(kern_sm_fr(:, :, 1))
subplot(3, 1, 2)
plot(H', 'color', 'k')
xlim([0, Ntimes])
ylim([-50, 50])
title('horizontal')
subplot(3, 1, 3)
plot(V', 'color', 'k')
xlim([0, Ntimes])
ylim([-50, 50])
title('vertical')  

% a final filter type: causal
taxis = 0:1000;  % make a time axis of 1000 ms
t_wid = 20;  % width of kernel (in ms)
causal_kernel = [zeros(1, 1000) exp(-abs(taxis)/t_wid)/t_wid];

% preallocate matrix
causal_kern_sm_fr = nan(size(fr));
for trial = 1:Ntrials
    for unit = 1:Nunits
        causal_kern_sm_fr(:, trial, unit) = ...
            conv(fr(:, trial, unit), causal_kernel, 'same');
    end
end

figure
subplot(3, 1, 1)
plot(causal_kern_sm_fr(:, :, 1))
subplot(3, 1, 2)
plot(H', 'color', 'k')
xlim([0, Ntimes])
ylim([-50, 50])
title('horizontal')
subplot(3, 1, 3)
plot(V', 'color', 'k')
xlim([0, Ntimes])
ylim([-50, 50])
title('vertical')  

% how should we refactor this?
% function for the plot
% function for the convolution
gsmoothed = kernel_smooth(fr, gauss_kernel);
fef_plot(gsmoothed, H', V', 3);

% this was not in the homework, but I think it's neat:
% plot the eye traces, but adjust transparency according to the spike rate
% at that point in time; bolder lines thus mean higher firing
% alpha plot
hh = H(1, :);
vv = V(1, :);
vv(end) = NaN;
alpha_values = gsmoothed(:, 1, 1);
patch(hh, vv, 'black', 'EdgeColor', 'blue', ...
    'FaceVertexAlphaData',alpha_values,...
    'EdgeAlpha','interp')

Vnan = V;
Vnan(:, end) = NaN;
patch(H', Vnan', 'black', 'EdgeColor', 'blue', ...
    'EdgeAlpha', 0.1)
xlim([-20, 5])
ylim([-5, 20])

clf
hold on
ALPHA_SCALING = 2;
for trial = 1:Ntrials
    alpha_values = gsmoothed(:, trial, 1)/ALPHA_SCALING;
    vv = V(trial, :);
    vv(end) = NaN;
    patch(H(trial, :)', vv, 'black', 'EdgeColor', 'blue', ...
        'FaceVertexAlphaData',alpha_values, 'AlphaDataMapping','none',...
        'EdgeAlpha','interp')
end
xlim([-20, 5])
ylim([-5, 20])
