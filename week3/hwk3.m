%% load data
load '../data/week3/DirectionTuning_V1_dec.mat'

[Nvert, Nhorz, Nframes] = size(data);

%% get trial codes and other useful variables
codes = cell2mat(dirTuningExp.tGratingDirectionDeg);
stim_names = unique(codes);
nstims = length(stim_names);

Ntrials = length(codes);
Noff = dirTuningExp.stimOffFrames;
Non = dirTuningExp.stimOnFrames;

%% get a data structure with one difference image per trial
tstack = make_trial_stack(data, codes, Noff, Non);

%% do it pixel-by-pixel
tic
preferred_img = nan(Nvert, Nhorz);
for hh = 1:Nhorz
    for vv = 1:Nvert
        preferred_img(vv, hh) = find_pixel_tuning2(squeeze(tstack(vv, hh, :)), codes, 0.33);
    end
end
toc

% ~35s on my machine
%% do it pixel-by-pixel (other loop order)
% tic
% preferred_img = nan(Nvert, Nhorz);
% for vv = 1:Nvert
%     for hh = 1:Nhorz
%         preferred_img(vv, hh) = find_pixel_tuning2(squeeze(tstack(vv, hh, :)), codes, 0.33);
%     end
% end
% toc

% ~35s on my machine
%% do it pixel-by-pixel
parpool(4);
tic
preferred_img = nan(Nvert, Nhorz);
parfor hh = 1:Nhorz
    for vv = 1:Nvert
        preferred_img(vv, hh) = find_pixel_tuning2(squeeze(tstack(vv, hh, :)), codes, 0.33);
    end
end
toc

% ~15s on my machine
%% plot
% replace nan with sentinel value -1 for plotting
plot_img = preferred_img;
plot_img(isnan(plot_img)) = -1;

figure
image(plot_img, 'CDataMapping', 'scaled');
colormap([zeros(1, 3); parula(nstims)])
cc = colorbar();
cc.TickLabels = {'None', stim_names};