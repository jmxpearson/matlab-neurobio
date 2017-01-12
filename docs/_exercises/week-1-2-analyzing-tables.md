---
layout: page
title: Analyzing table data
desc: Matlab notes, assignments, and code
week: 1
part: 2
author: John Pearson
---
# Analyzing table data

Last time, we practiced loading, recoding, and tidying an example dataset. We also worked on a very limited example of exploratory analysis, constructing summary statistics and plots. Today, we'll push that analysis further, using Matlab to filter our data and ask whether some of our variables make a statistical difference to the outcomes we care about.

## Filtering and subsetting data
In Matlab, taking a subset of rows or columns (often called "slicing" in other languages) works the same for tables as for arrays. And just as we can filter arrays using logical conditions, we can filter the data in tables. For our first analysis, let's limit our attention to the following:

- trials on which the actor had a free choice (`cued` = 0)
- spiking responses during the reward delivery epoch (`RewardOn_sp_count`)

<div class="question" markdown="1">
1. Produce a new table restricted to the data subset described above.

1. What percentage of trials does this subset represent?
</div>

## Spikes as a function of outcome
We might naturally ask whether spiking responses during the reward period are related to who is receiving reward and how much.

<div class="question" markdown="1">
1. As a function of outcome type:
- What is the mean spike count?
- Make a boxplot of this data.

1. As a function of reward magnitude:
- What is the mean spike count?
- Make a boxplot of this data.
</div>

## Choice as a function of reward
A key question in the original study is what factors influence prosocial choices &mdash; those resulting in the outcomes BOTH or OTHER.

<div class="question" markdown="1">
1. Add a binary `prosocial` column to the dataset. What percentage of prosocial choices did each subject make? What percentage of prosocial choices did each make as a function of reward?

1. Fit a logistic regression model that attempts to predict `prosocial` using `subj` and `reward` as regressors. Your model should include an interaction term between the two, as well as both main effects.
    1. What effects, if any, are significant?
    1. Save the output of the model to a variable. Take a look at the information available in this object (`fieldnames`). For future reference, among the most interesting are:
        - `Coefficients`: table of regression coefficients with p-values
        - `Rsquared`: structure with \\(R^2\\) goodness-of-fit statistics
        - `ModelCriterion`: model comparison measures like AIC and BIC
        - `LogLikelihood`: log likelihood of data given model

1. Fit another logistic regression model with no regressors (intercept only). Which model has lower BIC?
</div>


## Putting it all together
This sort of analysis works when we're exploring data, but what if we wanted to perform this sort of modeling over multiple datasets, or make a model for every neuron?

In these cases, it helps to write functions that perform a basic analysis so that we can run that function on multiple data subsets.

<div class="question" markdown="1">
1. Write a function that fits the logistic regression model above and returns two outputs:
    - the table of regression coefficients and p-values
    - a Boolean variable (true/false) indicating whether or not the fitted model is preferred (lower BIC value) to the null model (intercept only)

    In a larger analysis, we might use this second variable to determine whether or not to use the returned values from the model.
</div>

## [Solutions](https://github.com/jmxpearson/matlab-neurobio/blob/master/week1/)
