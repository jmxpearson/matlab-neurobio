% start from where we left off in class1.m...

% restrict data to choice trials and reward outcome period
subset = (tidy.cued) == 0 & (tidy.Epoch == 'RewardOn_sp_count');
sub_tidy = tidy(subset, :);

% what percentage is this?
mean(subset)  % NOTE: only the percent of observations, NOT trials

% by reward type
grpstats(sub_tidy, 'outcome', 'mean', 'DataVars', 'Count')
boxplot(sub_tidy.Count, sub_tidy.outcome)

% by reward magnitude
grpstats(sub_tidy, 'reward', 'mean', 'DataVars', 'Count')
boxplot(sub_tidy.Count, sub_tidy.reward)

% make prosocial choice column
sub_tidy.prosocial = sub_tidy.outcome == 'other' | sub_tidy.outcome == 'both';

% more group statistics
grpstats(sub_tidy, 'subj', 'mean', 'DataVars', 'prosocial')
grpstats(sub_tidy, {'subj', 'reward'}, 'mean', 'DataVars', 'prosocial')

% a glm fit and a fit for a model with just a constant
% we can compare these with AIC or BIC
fit = fitglm(sub_tidy, 'prosocial~subj*reward', 'Distribution', 'binomial');
nullfit = fitglm(sub_tidy, 'prosocial~1', 'Distribution', 'binomial');

% see class2_fit_model.m for code
[pvals, ispreferred] = class2_fit_model(sub_tidy);