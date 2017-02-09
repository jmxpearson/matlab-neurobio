---
layout: page
title: Fitting basic models
desc: Matlab notes, assignments, and code
week: 5
part: 1
author: John Pearson
---
# Fitting basic models
To begin this week, we'll focus on fitting two basic models: multinomial choice and linear regression. These models are special because, among other things, they admit very efficient computational solutions. That is, they do not require the sort of brute-force methods we'll use later in the week to fit more complex models. In both cases, the key to saving computer time will be math, and as a means of understanding the model we're fitting, we'll first generate data from it.

## Multinomial choice
Multinomial choice data are simply data drawn from a [multinomial distribution](https://en.wikipedia.org/wiki/Multinomial_distribution). That is, they're count data from a process where the outcome is discrete and selected from a finite set. The simplest multinomial is a binomial, where the events are heads and tails and the counts are the numbers of heads and tails, but the principle generalizes to, e.g., numbers of selections of each answer on a multiple-choice problem.

A multinomial distribution with \\(K\\) categories is characterized by a probability vector \\(p\\) with one entry for each possible outcome \\(i = 1\ldots K\\). Naturally, this probability must be normalized, \\(\sum_{i=1}^K p_i = 1\\). For any single observation, the outcome is governed by a [categorical distribution](https://en.wikipedia.org/wiki/Categorical_distribution) (the categorical distribution for binary outcomes is called the [Bernoulli distribution](https://en.wikipedia.org/wiki/Bernoulli_distribution)), where the probability of observing outcome \\(i\\) is \\(p_i\\). When we observe multiple outcomes, the probability of seeing \\(n_i\\) of each type out of a total of \\(\sum_i n_i = N\\) is given by the multinomial distribution:
\\[
p(\lbrace n_i\rbrace) = \frac{N!}{n_1!n_2!\cdots n_K!} p_1^{n_1} p_2^{n_2} \cdots p_K^{n_K}
\\]
Our goal will be to fit this model to data.

<div class="question" markdown="1">
1. Using Matlab's [`mnrnd`](https://www.mathworks.com/help/stats/mnrnd.html) function, generate a vector of counts from the multinomial distribution with probabilities `p = [0.1, 0.5, 0.2, 0.2]`.

1. One way of fitting the model above to these data is by selecting the parameter vector \\(p\\) that maximizes the likelihood (the probability of the data given the parameters) given above. In fact, it is usually simpler to maximize the log of the likelihood, since sums are often easier to compute with than products. Show that the solution
   \\[p = \left(\frac{n_1}{N}, \frac{n_2}{N}, \ldots, \frac{n_K}{N}\right)\\]

   maximizes the log likelihood and is thus the "best fitting" multinomial model.

1. Calculate the maximum likelihood estimate of \\(p\\) for your data. Does it match the one used to generate them? How does this change with \\(N\\)?
</div>

## Linear regression
Linear regression is the best-studied fitting procedure in all of statistics. Here, we'll explore two means of fitting a linear model, both based on maximum likelihood, which we've already seen is equivalent to minimizing the sum of squared errors.

<div class="question" markdown="1">
1. Generate 500 data points from the model
\\[
    y = \beta_0 + \beta_1 x + \varepsilon
\\]
with `x` randomly (uniformly) distributed between 0 and 1, \\(\beta_0 = -1\\), \\(\beta_1 = 0.85\\), and \\(\varepsilon\\) randomly (normally) distributed with standard deviation 0.1. Make a scatterplot of these data.

1. Create a function that calculates the sum of the squared residuals (errors between predicted and observed data) given a vector \\(\beta\\) of input parameters. Use Matlab's [`fminsearch`](https://www.mathworks.com/help/matlab/ref/fminsearch.html) to find the values of \\(\beta_0\\) and \\(\beta_1\\) that minimize this function.

1. Plot the best-fit line through the data defined by the regression coefficients you found above.
</div>

## [Solutions](https://github.com/jmxpearson/matlab-neurobio/blob/master/week5/)
