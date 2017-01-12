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

