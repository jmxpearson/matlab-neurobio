dat = readtable('../data/week2/roitman_data.csv');
dat = dat(dat.correct == 1, :);

% calculate mean firing rate in each bin
dt = 5;  % bin time in ms
df = grpstats(dat, {'time', 'coherence', 'into_RF'}, 'mean', 'DataVars', 'count');
df.fr = df.mean_count ./ (dt/1000);  % in spikes/s
df.Properties.RowNames = {};

% break by into vs out of RF
into_RF = df(df.into_RF == 1, [1, 2, 6]);
colwise_RF = unstack(into_RF, 'fr', 'coherence');
RF_fr = table2array(colwise_RF(:, 2:end));

out_RF = df(df.into_RF == 0, [1, 2, 6]);
colwise_ooRF = unstack(out_RF, 'fr', 'coherence');
ooRF_fr = table2array(colwise_ooRF(:, 2:end));

% smooth for plotting: just like class 2 this week
sm_wid = 120;  % std of smoothing window in ms (was 60 ms in paper)
wid = sm_wid/dt;  % window size in bins

RF_fr_sm = nan(size(RF_fr));
ooRF_fr_sm = nan(size(ooRF_fr));
for ii = 1:size(RF_fr, 2)
    RF_fr_sm(:, ii) = smooth(RF_fr(:, ii), wid);
    ooRF_fr_sm(:, ii) = smooth(ooRF_fr(:, ii), wid);
end


figure
hold on
plot(colwise_RF.time, RF_fr_sm, 'linewidth', 1.5)
legend('0', '3.2', '6.4', '12.8', '25.6', '51.2')
plot(colwise_RF.time, ooRF_fr_sm, 'linewidth', 1.5, ...
    'linestyle', '--')
xlim([dt 1000])
ylim([20 70])
xlabel('Time (ms)')
ylabel('Firing rate (sp/s)')
