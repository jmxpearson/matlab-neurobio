function raster = rasterize(spikes, Tmin, Tmax, dt)
% given a trials x units cell array with entries that are lists of spike
% times, return a time points x trials x units array of spike counts
edges = Tmin:dt:Tmax;
[Ntrials, Nunits] = size(spikes);
raster = nan(length(edges) - 1, Ntrials, Nunits);
for uu = 1:Nunits
    for tt = 1:Ntrials
        raster(:, tt, uu) = histcounts(spikes{tt, uu}, edges);
    end
end