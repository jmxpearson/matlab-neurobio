function preferred = find_pixel_tuning(tseries, labels, min_baseline, thresh)
% given a time series and labels (categorical) of the stimulus shown in each frame (-1 =
% baseline), return the preferred direction of the stimulus as an index
% into the categories of labels

[tuning, sems] = grpstats(tseries, labels, {'mean', 'sem'});
% note that sem is a bad measure here for two reasons:
% 1. The signal is only positive (or should be: you can't have negative
% light), so it's not normally distributed. Standard errors are based on
% normality assumptions.
% 2. The sem calculation treats every frame as independent, which is
% clearly wrong. We could do better by averaging frames within trials and
% calculating the sem across trials, since those numbers are more
% independent.

% a really brittle way to do tuning is to find the max absolute response
% relative to baseline
baseline = tuning(1);
bsem = sems(1);
tcurve = tuning(2:end) - baseline;
tsems = sems(2:end);
[~, peakind] = max(tcurve);

% and let's be sure this is > 3 standard deviations from baseline
threshold = thresh * sqrt(tsems(peakind)^2 + bsem^2);
if baseline > min_baseline && abs(tcurve(peakind)) > threshold
    preferred = peakind;
else
    preferred = nan;
end