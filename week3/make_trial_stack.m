function imstack = make_trial_stack(data, codes, Noff, Non)
% given the data (images x times) in data and the trial labels in codes,
% return a 3d stack of images (images x trials) representing the
% *difference* in fluorescence from baseline
% Noff is the number of baseline frames per trial and Non the number of
% stimulus presentation frames

% preallocate
[Nv, Nh, ~] = size(data);
imstack = nan(Nv, Nh, length(codes));

offset = 0;
for tt = 1:length(codes)
    baseline = mean(data(:, :, offset + (1:Noff)), 3);
    offset = offset + Noff;
    stim = mean(data(:, :, offset + (1:Non)), 3);
    offset = offset + Non;
    imstack(:, :, tt) = stim - baseline;
end