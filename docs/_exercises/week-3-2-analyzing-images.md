---
layout: page
title: Analyzing Image Data
desc: Matlab notes, assignments, and code
week: 3
part: 2
author: John Pearson
---
# Analyzing Image data
In this session, we'll continue our analysis of orientation and motion tuning in the calcium imaging sample from mouse V1. Our first step will be to refactor our current tuning analysis into a function, making it easier to swap out our method for determining preferred orientation while keeping the rest of our code the same (aka, the [strategy pattern](https://en.wikipedia.org/wiki/Strategy_pattern)). The second step will be to write code that calculates tuning across the entire image.

# Tuning curves: refactoring
Before we start, let's clean up our code:

<div class="question" markdown="1">
1. Rewrite your code for finding the preferred stimulus as a function.
1. Write code that finds the preferred orientation for each pixel in the image.
1. Display the result as a color-mapped image:
    - To get a version of a Matlab colormap with `n` values, use, e.g., `parula(n)` (parula is the name of the default colormap).
    - To set the colormap for the current image, use `colormap(cmap)`, where `cmap` is a colormap.
    - The mapping of values in your image to colors in the colormap is controlled by the `caxis` function. I recommend simply creating a colormap with as many colors as you need and plotting the image by assigning each pixel an integer from 1 to the number of stimuli. This should work as expected.
1. What do you note about the resulting image? What does or doesn't make sense biologically?
</div>

For the rest of this exercise, we'll be improving our methods of calculating and plotting the pixel tuning.

# Tuning curves: handling noise
If we want to consider our pixel as tuned, or a particular value the preferred value, it will help to have a sense of how confident we can be in our tuning curve.

<div class="question" markdown="1">
1. Modify your code to calculate both the mean and the standard error of the mean for both the baseline and each stimulus.
    - How do the standard errors for the stimulus and baseline means compare? Why?
    - Is the standard error a good measure of variability for this type of data?
    - Assuming the standard error is okay, are we over- or under-estimating the variability of the signal? How might we change this?
1. How might you test whether a particular value is really a peak, or just a fluctuation due to noise? There are multiple possible strategies. Discuss with me and then implement this change in a new function. Make sure not to use any [magic numbers](https://en.wikipedia.org/wiki/Magic_number_(programming)#Unnamed_numerical_constants). That is, any parameters of your algorithm should be specifiable by callers of your function.
1. Re-plot the tuning map.
</div>

# Tuning curves: tuned at all?
It's clear from both biology and the data at hand that not every pixel is even responsive to the stimuli. We would like a way to "opt out" of coloring a pixel with a preferred orientation in cases where that doesn't make sense.

<div class="question" markdown="1">
1. What test would you use to determine whether or not a pixel is tuned at all? After discussing with me, implement this change in your code?
    - How will you indicate "not tuned" in the return value from your function?
1. Re-plot the data. Make sure your colors reflect that some pixels have no apparent tuning.
</div>

## [Solutions](https://github.com/jmxpearson/matlab-neurobio/blob/master/week3/)
