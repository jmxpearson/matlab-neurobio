function analyze_oddball(dset, tpre, tpost)

% compare and plot pupil responses to standard and oddball tones
etimes = us2secs([dset.soundtime], dset.t0);
wasodd = dset.trialvec == 1;
[pmat, binT] = evtsplit(dset.pupil, etimes, tpre, tpost, dset.sr);

pcorr = basenorm(pmat(wasodd, :), binT, [-inf 0], dset.normtype);
pinc = basenorm(pmat(~wasodd, :), binT, [-inf 0], dset.plottype);

plot_with_sem(pcorr, 0, 1/dset.sr, dset.plottype, binT, [0 1 0])
plot_with_sem(pinc, 0, 1/dset.sr, dset.plottype, binT, [1 0 0])

%plot(binT, pmat', 'linewidth', 2.0)
xlim([tpre tpost])
title('Pupillary response to oddball','fontsize', 20, 'fontweight', 'bold')
xlabel('Time from sound (seconds)', 'fontsize', 16, 'fontweight', 'bold')
ylabel('Normalized pupil size (arb units)', 'fontsize', 16, 'fontweight', 'bold')

switch dset.plottype
    case 0
        legend({'Oddball', 'Standard'}, 'location', 'southeast')
    case 1
        legend({'Oddball', '', 'Standard', ''}, 'location', 'southeast')
    case 2
        legend({'Oddball', '', 'Standard', ''}, 'location', 'southeast')
end