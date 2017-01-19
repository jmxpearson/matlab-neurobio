function fig = fef_plot(neural, eye_horz, eye_vert, unit)
% make a multipanel plot of neural data traces against horizontal and
% vertical eye position
% unit selects which unit to plot
% for neural and eye data, the first index is time, the second trial
% makes a new figure, which it returns
[Ntime, Ntrial, Nunit] = size(neural);
fig = figure();
subplot(3, 1, 1)
plot(neural(:, :, unit))
subplot(3, 1, 2)
plot(eye_horz, 'color', 'k')
xlim([0, Ntime])
ylim([-50, 50])
title('horizontal')
subplot(3, 1, 3)
plot(eye_vert, 'color', 'k')
xlim([0, Ntime])
ylim([-50, 50])