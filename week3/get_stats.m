function out = get_stats(data, codes)
% given an images x trials data array, return a struct of useful statistics

% which trials are in which group?
[stims, ~, scodes] = unique(codes);

% preallocate
[Nv, Nh, ~] = size(data);
mm = nan(Nv, Nh, length(stims));  % mean images across stims
sem = nan(Nv, Nh, length(stims));  % sem images across stims

for sc = 1:length(stims)
   sel = scodes == sc;  % subset of trials matching stimulus code
   
   mm(:, :, sc) = mean(data(:, :, sel), 3);
   sem(:, :, sc) = std(data(:, :, sel), 0, 3)/sqrt(sum(sel)); 
end

out.mean = mm;
out.sem = sem;