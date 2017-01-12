function [ptable, ispreferred] = class2_fit_model(tbl)
% this function takes an input table of data, fits a logistic regression
% based on the data inside, and returns a table of pvalues and regression
% coefficients, along with a boolean variable that says whether this model
% is preferred to a null model with only a constant
% we assume that the needed columns are present in the input table
fit = fitglm(tbl, 'prosocial~subj*reward', 'Distribution', 'binomial');
nullfit = fitglm(tbl, 'prosocial~1', 'Distribution', 'binomial');

ptable = fit.Coefficients;
ispreferred = fit.ModelCriterion.BIC < nullfit.ModelCriterion.BIC;
end