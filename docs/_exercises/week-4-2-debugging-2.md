---
layout: page
title: Debugging II
desc: Matlab notes, assignments, and code
week: 4
part: 2
author: John Pearson
---
# Debugging Practicum
Once again, we'll be spending time debugging example code. In this case, we're performing a statistical power analysis by simulating data from idealized experiments. You are given [two functions](https://github.com/jmxpearson/matlab-neurobio/tree/master/week4/broken):

1. `calc_power`: calculates the power of a function that simulates an experiment and performs a statistical test on the resulting data.
1. `firing_rate_expt`: an example of one such experimental function.

In this case, because no data are provided, it is up to you to choose parameters that will help you debug the functions.

## Model
Our idealized experiment works as follows: assume

- a spiking single unit described as a Poisson process with baseline rate \\(\lambda_0\\)
- observed for a duration \\(T_0\\)
- when presented with a stimulus, the unit increases its firing rate to \\(\alpha \lambda_0\\)
- and is observed for a duration \\(T\\)
- from one trial to the next, log firing rates vary based on a percentage of the mean value:
  \\[
  \log \lambda_i = \log \lambda + \epsilon \log \lambda
  \\]
  with \\(\epsilon\\) normally distributed with mean 0 and standard deviation \\(\sigma\\) and \\(\lambda\\) equal to either the baseline or stimulus rate, as appropriate

Then, given observed spike counts generated from Poisson distributions based on these rates and observation durations, we calculate (empirical) firing rates for the stimulus \\(\hat{\lambda}_i\\) and baseline \\(\hat{\lambda}\_{0i}\\)  for each trial and perform a paired t-test of the hypothesis that they are the same.

<div class="question" markdown="1">
1. Fix the code. Two strategies I recommend:
    1. Pick (multiple sets of) input values with obvious correct answers and use these for testing.
    1. Use the debugger to step into the code and plot the calculated quantities at each stage of the code. Do they make sense?
</div>


<!-- ## [Solutions](https://github.com/jmxpearson/matlab-neurobio/blob/master/week3/) -->
