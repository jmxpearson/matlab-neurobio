function smoothed = kernel_smooth(data, kernel)
% smooth a data array in data by using kernel
% array is assumed to be time x trial x unit
% kernel midpoint is assumed to be time 0
% kernel smoothing is over time
% preallocate matrix
[~, Ntrials, Nunits] = size(data);
smoothed = nan(size(data));
for trial = 1:Ntrials
    for unit = 1:Nunits
        smoothed(:, trial, unit) = ...
            conv(data(:, trial, unit), kernel, 'same');
    end
end