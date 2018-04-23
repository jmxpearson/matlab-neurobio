dat = readtable('../data/week1/ppv_data.csv');

catvars = {'monk', 'session', 'piccat'};
for idx=1:length(catvars)
    cv = catvars{idx};
    dat.(cv) = categorical(dat.(cv));
end

% subset data
session = '9';
piccat = '4';
subset = dat((dat.session == session) & (dat.piccat == piccat), :);
subset = subset(subset.Ntot ~= 0, :);

% plot data
subset.proportion = subset.Nimg./subset.Ntot;
scatter(subset.dv, subset.proportion);

% do fit
fit = fitglm(subset, 'Nimg ~ dv', 'Distribution', 'binomial', 'BinomialSize', subset.Ntot);
coeff_table = fit.Coefficients;
beta = coeff_table.Estimate;

% plot fit
dv = (-150:1:150)';
new_vals = table(dv);
p_pred = predict(fit, new_vals);
hold on
plot(dv, p_pred);

% calculate image value
img_val = beta(1)/beta(2);
p_slope = coeff_table.pValue(2);

% see fit_model.m for function
[imvals, pvals, sessions, categories] = splitapply(@fit_model, dat, findgroups(dat.session, dat.piccat));
mod_tbl = table(imvals, pvals, sessions, categories);

bads = abs(mod_tbl.imvals) > 1000;
mod_tbl(bads, :) = [];