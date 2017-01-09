---
layout: page
title: "Homework: split-apply-combine"
desc: Matlab notes, assignments, and code
week: 1
part: 3
author: John Pearson
---
# Homework: split-apply-combine

For this homework, we'll explore another tabular dataset involving animal choice behavior from [this paper](http://journal.frontiersin.org/article/10.3389/fnins.2013.00165/full). In the experiment, male monkeys were given a choice between delivery of two juice rewards, one of which was paired with an image. The images were chosen from one of four categories &mdash; dominant male monkeys, subordinate male monkeys, images of female monkey sex skin, and a gray square &mdash; while the relative amount of juice available for each option varied across choices. When animals were indifferent between the juice and juice-plus-image options for a given discrepancy in juice values, that difference was taken to be the value of the paired image. At issue in the experiment is how image values differed by category and across individuals.

In this homework, we will replicate pieces of this analysis by fitting choice models to subsets of the data. In doing so, we'll have recourse to the [split-apply-combine](https://www.jstatsoft.org/article/view/v040i01) pattern, which allows us to first define an analysis on an arbitrary subset of data and then apply this analysis across some grouping of the data set. The key advantage of this method is that it separates the analysis itself from the method used to split the data into groups, resulting in more flexible, reusable code.

## Loading the data
The data are contained in [this csv file](https://media.githubusercontent.com/media/jmxpearson/matlab-neurobio/master/data/week1/ppv_data.csv) with columns:

- `monk`: animal doing the task
- `session`: session number (unique across all animals)
- `piccat`: picture category:
    1. gray square
    1. female sex skin
    1. dominant male
    1. subordinate male
- `dv`: difference in value between the juice-plus-image and juice-only options; positive values mean more fluid for choosing the juice-plus-image option
- `Nimg`: number of times the animal chose the juice-plus-image option
- `Ntot`: total number of times the choice was presented
- `sessdate`: date of the session in which these data were collected

<div class="question" markdown="1">
1. Load the data into Matlab
1. Transform any columns into `categorical`, as needed.
1. Tidy the data, as needed.
</div>

## Analysis: image value
Our goal will be to design an analysis capable of calculating the value of each image category each session. We'll do this by using split-apply-combine.

### Subsetting the data
For many applications of the split-apply-combine method, it's easiest to begin by designing the "apply" portion first. That is, we design and test the analysis we want to perform on an arbitrary subset of the data. To do this, we'll often extract a representative subset of the data in order to perform testing.

<div class="question" markdown="1">
1. Extract a subset of the data to use in developing the analysis. For instance, session 9, picture category 4.

1. Remove any rows in the data subset that correspond to no observations (`Ntot` = 0).
</div>

### Examining the data
The most important tests we tend to do in scientific software involve plotting data and results. Because your eye is a much better pattern detector than most programmatic tests you might write, the fastest way to assess whether your code is functioning correctly is to generate plots.

<div class="question" markdown="1">
1. For each value difference in your data subset, calculate the proportion of trials on which the animal chose the juice-plus-image option.

1. Plot this proportion as a set of points.
</div>

### Fitting the model
We expect that as `dv` increases, animals are more likely to choose the juice-plus-image option. Our observations in this case are numbers of times each choice was presented and numbers of times the image option was selected. For such observations, the standard statistical distribution is a binomial, and the typical model is logistic regression. In logistic regression, we assume
\\[
\log \frac{p}{1-p} = X \beta
\\]
where \\(p\\) is the probability of choosing the image, \\(X\\) is the matrix of regressors in our model (the variables we think might affect this probability), and \\(\beta\\) is a vector of coefficients (weights) for these variables. In our case, we will assume the simplest possible model, in which the probability of choosing the juice-plus-image option depends only on the difference in juice between the two options:
\\[
\log \frac{p}{1-p} = \beta_1 + \beta_2 dv
\\]
Our measure of interest will be the value of \\(dv\\) at which the animal is indifferent between the juice-only and juice-plus-image options, the so-called "point of subjective equality." At this point, we can reason that \\(V_1 = V_2 + V_{\mathrm{image}} \Rightarrow V_{\mathrm{image}} = V_1 - V_2 = -dv\\). That is, the image value is minus the value of \\(dv\\) at which \\(p=\frac{1}{2}\\).

<div class="question" markdown="1">
1. Derive an expression for the image value as a function of \\(\beta\\).

1. Using Matlab's `fitglm` command, fit the logistic regression. (Hint: you may want to use the `'BinomialSize'` argument to specify the number of times each choice was presented.)
</div>

### Checking the fit
For model checking, we want to be sure that our fitted model captures any trends visible in the data. We can do this by plotting a model fit line on the same figure as our raw data.

In Matlab, we can use the `predict` command to generate this fit line. We pass `predict` our fitted model object and a table (alternately, a vector of inputs, if we didn't pass a table to `fitglm`) with values at which to predict the model's output.

<div class="question" markdown="1">
1. Generate a table of new `dv` values. These should be numerous and close enough together that the predicted values will plot as a smooth line.

1. Use the `predict` command to get predictions for \\(p\\) at the new `dv` values. Alternately, you can use the formula above to solve for \\(p\\) in terms of \\(\beta\\) and \\(dv\\).

1. Plot these predictions on the same figure as the original data.
</div>

## Putting it all together
Now that we know the analysis we want to perform on each data subset, we should be able to follow split-apply-combine:

1. Wrap our existing analysis in a function that takes a data subset in the form of a table.
1. Call Matlab's `splitapply`, which breaks the data into groups. Ideally, we would give this a list of grouping variables.
1. The output of `splitapply` would recombine the results of our analysis in a new table, one row for each group.

This is what happens in most other languages (R, Python, etc.). *Unfortunately*, because The MathWorks is racing to catch up on support for data tables, it doesn't quite work that way in Matlab yet:

- `splitapply` requires a single *numeric vector* labeling the groups. If you look at the `splitapply` documentation, you can see that this is done with the `findgroups` command.
- `splitapply` doesn't feed the analysis function a data subset in the form of the table. Rather, it feeds the function individual columns.

So here's what you'll need to do. Either:

1. Prepare your function to receive multiple inputs. You could write a function that only uses the required columns from the data table, feed a reduced table to `splitapply`, and use the individual columns within the function to do the calculation.
1. Use [`varargin`](https://www.mathworks.com/help/matlab/ref/varargin.html) and reconstruct the data table inside the function. That would look something like this:

   ```matlab
   function img_val = fit_model(varargin)
       data = table(varargin{:});
       data.Properties.VariableNames = {...
       ...
   end
   ```
   That is, we take the `varargin` cell array, use `{:}` to turn it into a [comma-separated list](https://www.mathworks.com/company/newsletters/articles/matlab-tips-and-tricks-exploiting-the-comma-separated-list-vectorizing-cell-array-and-structure-references.html), and feed the resulting list to `table`. The only downside to this is that you must then set the variable names in the resulting table for the code to work as before.

Both of these solutions are significantly limited, since they require your function to know exactly how many columns are coming and in what order (in the first case to provide an argument list; in the second to set variable names). Ideally, we would simply be able to accept a data table and reference the columns we need by name, regardless of where they are in the table or what else is include. As it is, we're forced to implement a solution that's more rigid and thus more brittle.

Likewise, be aware that `splitapply` does not perform the "combine" step: it will instead return a series of vectors, one for each output of the analysis function you provide. Thus it will be up to you to recombine these into a table, if needed.

<div class="question" markdown="1">
1. Write a function following the guidelines above that fits a logistic regression to a given data subset.
    - Note that not all sessions produce a well-behaved fit, so Matlab may complain that some fits are ill-behaved or fail to return a result. This is expected.
    - Because not all sessions produce a well-behaved fit, the array of results may be missing values. Thus, in order to be able to identify what result belongs to what data subset, your function should return not only the value of each image category, but also the session and category to which the data belong. Remember that this information will be passed into the function as part of the original data set.
1. Use `splitapply` along with your analysis function to calculate the value of each image category in each session.
1. Remove any results with \\(\vert V_{\mathrm{image}} > 1000\vert \\) and produce a boxplot of the remaining image values broken out by category.
</div>
