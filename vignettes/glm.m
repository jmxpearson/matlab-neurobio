load hostpital.mat

% look at table

fitglm(hospital, 'Smoker ~ Age + Weight', 'Distribution', 'binomial')
fitglm(hospital, 'Smoker ~ 1 + Age + Weight', 'Distribution', 'binomial')

fitglm(hospital, 'Smoker ~ -1 + Age + Weight', 'Distribution', 'binomial')

fitglm(hospital, 'Smoker ~ Age * Weight', 'Distribution', 'binomial')

fit = fitglm(hospital, 'Smoker ~ Age + Weight', 'Distribution', 'binomial');

% Coefficients
% Rsquared
% ModelCriterion
% LogLikelihood

weights = (120:10:350)';
newvals = table(55 * ones(length(weights), 1), weights);
newvals.Properties.VariableNames = {'Age', 'Weight'};

preds = predict(fit, newvals);

plot(weights, preds)
