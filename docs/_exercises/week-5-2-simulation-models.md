---
layout: page
title: Fitting simulated models
desc: Matlab notes, assignments, and code
week: 5
part: 1
author: John Pearson
---
# Fitting simulated models
In our last class, we looked at fitting models based on a known probability distribution. This let us write down a likelihood function that we could calculate and subsequently optimize to find the model's parameters. But what if we can't write down the likelihood, or the probability distribution is unknown? In many cases like this, we can *still* make progress, because all we need is *something* to optimize, not necessarily the likelihood. In [Homework 4]({{ site.url }}/exercises/week-4-homework-dynamic-decisions.html), you wrote functions that simulated three models of dynamic decision-making. In one (the LATER model), the parameters of the model gave rise to a known distribution of response times. In the others, while there are similar results for special cases, even small changes to the assumptions may result in models for which the response time distribution has no known parametric form.

Even so, we often want to fit such models, and this can be done approximately by **simulating** the model to be fit for a fixed set of parameters and comparing some measure of its output to the actual data. The key here is that for purposes of *computation*, all Matlab needs to know is the *number* returned by the function to be optimized &mdash; no closed-form equation is needed.

In this exercise, we'll use an alternative goodness-of-fit measure for univariate distributions, the [Kolmogorov-Smirnov statistic](https://en.wikipedia.org/wiki/Kolmogorov%E2%80%93Smirnov_test) and optimize this to find the best-fitting parameters for of each of the three models.

> **Note**: The KS statistic is by no means the best measure of difference between distributions. For starters, it is only defined for distributions of one variable. More typically, one would use a metric like the [Kullback-Leibler](https://en.wikipedia.org/wiki/Kullback%E2%80%93Leibler_divergence) or [Jensen-Shannon](https://en.wikipedia.org/wiki/Jensen%E2%80%93Shannon_divergence) divergences, or even an approximation to the log likelihood. We are using the KS statistic here because it is simple to have Matlab compute for us.



<!-- <div class="question" markdown="1">
1. Create a function that calculates the sum of the squared residuals (errors between predicted and observed data) given a vector \\(\beta\\) of input parameters. Use Matlab's [`fminsearch`](https://www.mathworks.com/help/matlab/ref/fminsearch.html) to find the values of \\(\beta_0\\) and \\(\beta_1\\) that minimize this function.

1. Plot the best-fit line through the data defined by the regression coefficients you found above.
</div>
 -->
<!-- ## [Solutions](https://github.com/jmxpearson/matlab-neurobio/blob/master/week4/fixed) -->
