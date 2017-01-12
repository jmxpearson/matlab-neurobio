% load data from a csv into a table
dat = readtable('../data/week1/dictator.csv');

% get names of columns
colnames = dat.Properties.VariableNames;

% convert some variables to categorical
dat.unit = categorical(dat.unit);
dat.subj = categorical(dat.subj);

% but we can do this a smart way
cat_vars = {'unit', 'subj', 'outcome'};
for idx = 1:numel(cat_vars)
    var = cat_vars{idx};
    dat.(var) = categorical(dat.(var));
end

% what about 'cued'? It should be a binary (0/1) variable
class(dat.cued)
dat.cued = cellfun(@str2num, dat.cued);

% every variable ending in '_count' should be stacked
count_cols = colnames(endsWith(colnames, '_count'));

% tidy the dataframe
tidy = stack(dat, count_cols, 'NewDataVariableName', 'Count', ...
    'IndexVariableName', 'Epoch');

% group statistics
grpstats(tidy, 'Epoch', 'mean', 'DataVars', 'Count')

% boxplot
boxplot(tidy.Count, tidy.Epoch, 'notch', 'on')  % not particularly illuminating

% restrict data to choice trials and reward outcome period
subset = (tidy.cued) == 0 & (tidy.Epoch == 'RewardOn_sp_count');
sub_tidy = tidy(subset, :);

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

