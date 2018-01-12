---
layout: page
title: Analyzing point process data
desc: Matlab notes, assignments, and code
week: 2
part: 2
author: John Pearson
---
# Analyzing spike data
Today, we'll get to analyzing spike data. In particular, we'll deal with estimating firing rates, which are typically the variables of interest. Once we have a good firing rate estimate, we often want to know how such rates are related to behavior, either evoked by it (as in sensory areas) or driving it (as in the motor system).

We'll begin with where we left off [last class](/exercises/week-2-1-exploring-spikes.html).

## Estimating mean firing rates
The simplest method for estimating a firing rate for a cell is to average its spiking responses across multiple trials.

<div class="question" markdown="1">
1. Using the spike histogram data, compute the average spike count in each bin across trials for unit 1.
1. Convert this from a mean spike count per bin to a mean firing rate.
1. Plot the result as a function of time.
</div>

### Smoothing
Typically, even with trial averaging, firing rates have a lot of noise. Under the assumption that rates are not changing drastically from one bin to the next, we can often get a more interpretable result by smoothing.

The most common method of smoothing is calculating a moving average, which we can do in Matlab via the `smooth` command.

<div class="question" markdown="1">
1. Smooth the trial-averaged firing rate over a 20ms window.
1. Plot this as a function of time on the same plot as the unsmoothed average.
</div>

## Estimating firing rates for single trials
In cases where trial-to-trial variability (neural *or* behavioral) is important, we might want to have an estimate of firing rate on a single trial to correlate with behavior. This is a tricky proposition, since, again, firing rate is not something we directly observe. In statistical language, we observe events from a Poisson *process*, which is equivalent, as we have seen, to observing counts within time bins that are governed by a Poisson *distribution*. In both cases, we assume there is an underlying spike rate or spike density \\(\lambda(t)\\) that varies in time.

So how do we estimate a firing rate from a single spike train? One (not very clever) way to do it is to assume that firing rate rose rapidly *only* during those bins where we observed spikes and was 0 at all other times. Moreover, we could assume that the rate during bins that had spikes is the rate for which that exact spike count was the one most likely to have been observed. This is equivalent to what is called the *maximum likelihood* method, and while it's a powerful technique, we're in a situation with high variability and little data.

A more reasonable assumption is that the rate \\(\lambda(t)\\) does not change that drastically from one bin to the next. That is, if we see a spike at time \\(t\\) we would not be that surprised to also see spikes at \\(t - 1\\) and \\(t + 1\\). (Recall that for a Poisson process, these counts are independent of one another.) Put another way, whereas the maximum likelihood method attributed each spike only to the time when it occurred, inferring a nonzero firing rate in a single bin, we might want to *spread* the influence of each spike around the time it was observed, implying that firing rates were *locally* higher around the time of each observed spike.

This gives rise to the idea of smoothing spike trains in order to estimate underlying firing rates. In effect, we replace each spike with a smooth distribution spread in time, which is mathematically equivalent to a [convolution](https://en.wikipedia.org/wiki/Convolution#Visual_explanation). Each choice of distribution or *filter* represents either a different statistical estimator of, or different prior belief about, the underlying firing rate.

So let's estimate some single-trial firing rates. The simplest kernel is a boxcar or sliding window of width \\(w\\). This simply replaces each spike count of \\(n\\) with a spike count of \\(n/w\\) in each bin of the window, i.e., a moving average.

<div class="question" markdown="1">
1. Create a time points x trials x units array of firing rate estimates by performing a moving average. You may find `smooth` is an easy way to do this.

1. Experiment with different window widths. What tradeoff is made by using these different widths?

1. Plot the collection of single-trial firing rates for a given unit as the first panel of a multi-panel plot of the same form as last class.
</div>

### Gaussian smoothing
We would like to use a filter that does not "share" the spike equally among many time bins but keeps the bulk of its effect concentrated near the real data. That is, we'd like something more bump-like. A natural candidate is the Gaussian, or Normal, distribution.

For smoothing by an arbitrary filter, Matlab has many methods available, but the most straightforward one is to generate a vector representing the filter and use the convolution command (`conv`) to perform the smoothing.

<div class="question" markdown="1">
1. Create a Gaussian filter.
    1. Start by creating a range of times over which to define the filter. I suggest `-1000:1000`, which is 1 second on either side of 0.
    1. Pick a smoothing width. This will be the standard deviation of the distribution. I suggest 20ms to start.
    1. Create the filter. The `normpdf` function implements the classic bell curve.
    1. Normalize your filter so that it sums to 1. This is important so that we maintain the total spike density in the time series (i.e., the sum of the smoothed signal is still the total spike count.)
    1. Plot your filter as a function of time to make sure it's right.

1. Perform the smoothing. This will work just like the moving average, except you will use `conv` in place of `smooth` to generate the single-trial estimates. A few caveats:
    - The first argument to `conv` should be the spike count time series. The second argument is the filter. While convolution as a mathematical operation treats both arguments the same (it is [commutative](https://en.wikipedia.org/wiki/Commutative_property)), extra arguments to the Matlab function do make assumptions.
    - To wit: you will need to specify the `'same'` argument to `conv`. This is to ensure that Matlab returns a time series of the same length as the one you put in. It's also the reason we needed to specify the spikes and filter in the order we did, and why the middle of the filter is treated as time lag 0.

1. Generate the same plot as above using these new smoothed firing rates.

1. What happens as you change the width of the filter?
</div>

### Refactor: make it a function
As before, let's take our code for smoothing and refactor it into a function.

<div class="question" markdown="1">
1. Write a function that takes as inputs a count array of spikes and a vector representing a filter and returns single-trial firing rates in an array of the same shape as the input spikes.
</div>

## [Solutions](https://github.com/jmxpearson/matlab-neurobio/blob/master/week2/)
