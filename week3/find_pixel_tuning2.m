function preferred = find_pixel_tuning2(pixvals, codes, min_idx)
% given a set of pixel values and a vector of stimulus
% identities for each trial, find the preferred direction of each pixel
% based on the following:
% 1) Significant anova for pixel value vs stimulus
% 2) direction index 1 - (response_orthogonal/response_preferred) > min_idx

alpha = 0.05;  % false positive rate

pval = anova1(pixvals, codes, 'off');
nstims = length(unique(codes));

if pval < alpha
    pixmeans = grpstats(pixvals, codes);
    [rpref, pref] = max(pixmeans);
    orthogonal = mod(pref - 1 + nstims/2, nstims) + 1;
    rnull = pixmeans(orthogonal);
    if 1 - (rnull/rpref) > min_idx
        preferred = pref;
    else
        preferred = nan;
    end
else
    preferred = nan;
end