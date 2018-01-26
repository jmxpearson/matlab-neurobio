---
layout: page
title: "Homework: dynamic decisions"
desc: Matlab notes, assignments, and code
week: 4
part: 3
author: John Pearson
---
# Homework: dynamic decisions

## Important:
You do **not** need to submit Matlab markup for this assignment. Source code (`.m` files) only.

## Models of dynamic decisions
In preparing for next week's work on model fitting, this homework will have you implement three distinct models for dynamic decision making: the [linear approach to threshold with ergodic rate](http://www.cudos.ac.uk/later.htm) (LATER) model of Carpenter, the [drift diffusion model](https://en.wikipedia.org/wiki/Two-alternative_forced_choice#Drift-diffusion_model) (DDM), and the [race model](https://en.wikipedia.org/wiki/Two-alternative_forced_choice#Race_model). In doing so, you will have a chance to practice the principles of refactoring, profiling, and debugging we've been working on throughout the course.

## LATER model
The LATER model was originally designed to work with saccade latency data, and shares several features with the better known DDM. LATER posits a decision signal starting at \\(S_0\\) that rises with a trial-specific rate \\(r\\) drawn from a normal distribution with mean \\(\mu\\) and standard deviation \\(\sigma\\) to a decision bound at \\(S\\). From this, it is possible to derive that the decision time (the time to rise from \\(S_0\\) to \\(S\\)) is given by
\\[
T = \frac{S - S_0}{r}
\\]
To simplify matters, we will write \\(\theta = S - S_0\\) as the difference in bounds, so the model is simply parameterized by \\(\theta\\), \\(\mu\\), and \\(\sigma\\).

An important consequence of this formulation is that the distribution of \\(\frac{1}{T} = \frac{r}{\theta}\\) is normally distributed.

<div class="question" markdown="1">
1. Write a function that implements LATER. The function should take the three parameters listed above, along with a number of trials, as inputs and return an array of decision times. Because for some choices of parameters the rate \\(r\\) can be negative, your function will also need to accept a maximum RT. All reaction times longer than this, as well as all those for which an RT doesn't exist (i.e. \\(r \le 0\\)) should be assigned this value.

1. Plot the distribution of decision times. Plot the distribution of inverse decision times. What pattern do you see? Is this what you expect?

1. Make a [quantile-quantile plot](https://en.wikipedia.org/wiki/Q%E2%80%93Q_plot) of inverse decision time against a normal distribution (the default for `qqplot`). What pattern emerges? (NB: there is a related plot, the [reciprobit plot](http://www.neural-code.com/index.php/tutorials/action/reaction-time/83-reciprobit-distribution) which is more often made. The idea is the same, but the scales are perhaps more intuitive.)
</div>

## Drift-diffusion_model
The DDM is similar to LATER, except that instead of choosing a single decision accumulation each trial, the rate changes in time according to a biased random walk. That is, at each moment, the decision variable \\(y\\) changes according to
\\[
\Delta y \sim \mathcal{N}(\mu, \sigma^2)
\\]
That is, the *increments* (decrements) in \\(y\\) are normally distributed with mean \\(\mu\\) and standard deviation \\(\sigma\\). Here, we can consider a single decision boundary a distance \\(\theta\\) away, as in the LATER model, or a pair of decision boundaries, one positive, one negative (and not necessarily the same) corresponding to different choices.

<div class="question" markdown="1">
1. Write a function that implements the DDM with a single decision boundary. The function should take the three parameters listed above, along with a number of trials, as inputs and return an array of decision times.

1. Make the same plots as before. Any differences?
</div>

## Race model
The race model is similar to the DDM in that it is designed to model decisions, not simply reaction times. For a two-alternative task, it is governed by a *pair* of biased random walks, one for each option. The first one to cross threshold is the "winner," and that option is chosen. The math is the same as for the DDM, except that there are two diffusion processes.

<div class="question" markdown="1">
1. Write a function that implements the race model. The function should take as input a threshold, two noise means, two standard deviations, and a number of trials to generate. It should return an array of reaction times and an array of decision codes (either 1 or 2).

1. Make the same plots as before. Any differences?
</div>
