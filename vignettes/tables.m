%% load sample data
load carsmall

%% making arrays
% we'd normally make an array by concatenating columns
arr = [Horsepower, MPG]

% but the Mfg column is a character array, and this concatenates
% characters
arr2 = [Mfg, Horsepower, MPG]

arr3 = [cellstr(Mfg), Horsepower, MPG]  % fails

%% making tables
% matlab's solution is to make a table
% note that we first use 
dat = table(cellstr(Mfg), cellstr(Model), Model_Year, MPG, Weight);

% look at dat in viewer
%% things to do with tables
% useful info
dat.Properties

dat.Properties.VariableNames{1} = 'Mfg';
dat.Properties.VariableNames{2} = 'Model';

% head
dat(1:5, :)

% tail
dat(end-5:end, :)

% sort rows
newdat = sortrows(dat, {'Mfg', 'Model'});

% write
writetable(dat, 'data/sortedcars.csv')