load '../data/week3/DirectionTuning_V1_dec.mat'

%% how do we figure out what the dimensions are?
% what would make sense for memory locality?
% what test would you do (visually, computationally) to check your answer?
% let's try to plot
imagesc(data(:, :, 1))
colorbar()
figure
imagesc(data(:, :, 5))
colorbar()
% note that these look similar, which is what we expect if only separated
% in time

[Nvert, Nhorz, Nframes] = size(data);
    
%% let's look at a time series
% frames are acquired at 30 Hz, downsampled to 10 Hz
dt = 1/3;
taxis = dt:dt:size(data, 3)*dt;
clf
hold all
plot(taxis, squeeze(data(55, 125, :)))
plot(taxis, squeeze(data(75, 180, :)))

%% show a "movie"
% adapted from `doc movie`
figure

% normalizer:
pmax = max(data(:));
pmin = min(data(:));

for tt = 1:Nframes
    imagesc((data(:, :, tt) - pmin)/(pmax - pmin))
    drawnow
end


%% let's plot the time series for one pixel
pt_in_img = [46, 200];
tseries = squeeze(data(pt_in_img(1), pt_in_img(2), :));
plot(taxis, tseries)

%% ...and figure out its tuning
% Every orientation is off for 12, on for 6
% strategy: make a grouped variable for each frame, then get a group mean
% for each condition
labels = -1 * ones(length(taxis), 1); % -1 will label baseline (off)
codes = dirTuningExp.tGratingDirectionDeg;
Ntrials = length(codes);
Noff = dirTuningExp.stimOffFrames;
Non = dirTuningExp.stimOnFrames;

offset = 0;
for tt = 1:Ntrials
    offset = offset + Noff;
    labels(offset + (1:Non)) = codes{tt};
    offset = offset + Non;
end
labels = categorical(labels);
orientations = categories(labels);

tuning = grpstats(tseries, labels);

figure
plot(tuning(2:end))
xticklabels(orientations(2:end))
refline(0, tuning(1))
%% a really brittle way to do tuning is to find the max absolute response
% relative to baseline; assumes tuning is always an *increase* above
% baseline
tcurve = tuning(2:end) - tuning(1);
[~, peakind] = max(tcurve);

preferred = orientations{peakind};

%% now let's repeat for all pixels
% pull above function into find_pixel_tuning.m

preferred_img = nan(Nvert, Nhorz);
for hh = 1:Nhorz
    for vv = 1:Nvert
        preferred_img(vv, hh) = find_pixel_tuning(squeeze(data(vv, hh, :)), ...
            labels, 2e4, 3);
    end
end

figure
tuning_img = image(preferred_img);
colormap([zeros(1, 3); parula(length(orientations) - 1)])
cc = colorbar();
cc.TickLabels = {'None', orientations{2:end}};