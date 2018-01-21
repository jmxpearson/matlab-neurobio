---
layout: page
title: "Homework: optimization"
desc: Matlab notes, assignments, and code
week: 3
part: 3
author: John Pearson
---
# Homework: optimization

This homework focuses on extending and speeding up our code for detecting tuned cells in calcium imaging data. As part of making our analysis more realistic, we'll walk through a lite version of the method used in [Ohki et al.](http://www.nature.com/nature/journal/v433/n7026/abs/nature03274.html).

## Refactor: difference images
In class, we used a statistical approach that simply averaged all baseline frames and all frames for each moving grating stimulus together. We also discussed some of the potential drawbacks of this method. For this homework, we'll use a different approach: calculating an activation minus baseline difference image for each trial. This will allow us to compute a low-variance effect for each trial while calculating a more honest variance measure across trials.

<div class="question" markdown="1">
1. Load the calcium imaging data from this week.
1. Create a variable that contains a difference image for each trial in the data set. The difference image is the image formed by subtracting the image formed by taking the mean across baseline frames from the image formed by taking the mean across stimulus frames for the single trial.
</div>

## Refactor: detecting tuned pixels
In class, we remarked that much better methods were available for detecting whether or not a particular pixel is tuned. One such method is detailed in [Ohki et al.](http://www.nature.com/nature/journal/v433/n7026/abs/nature03274.html), which boils down to the following three steps:

1. Check to see whether a one-way ANOVA shows a main effect of stimulus for a given pixel.
1. If it does not, the pixel is untuned. If it does, find the preferred (i.e., max mean activation) stimulus.
1. Construct the tuning index \\(R = 1 - \frac{r_{orth}}{r_{pref}}\\) for the pixel. Here, \\(r_{pref}\\) is the mean activation for the preferred stimulus, while \\(r_{orth}\\) is the activation in the orthogonal direction (180&deg; for direction tuning). If \\(R\\) is greater than some minimum value (0.33 is generally accepted), the cell is tuned.

<div class="question" markdown="1">
1. Implement a new function that determines whether a pixel is tuned and if so, returns its preferred direction.
    - The matlab command for a one-way ANOVA is `anova1`. The default return value of the command is the p-value. You should use a false positive rate for the test of \\(\alpha = 0.05\\).
    - You might want to choose a [sentinel value](https://en.wikipedia.org/wiki/Sentinel_value) for your function to return in cases where the pixel is not tuned.
1. Use this function to create a tuning image just as we did in class.
    - Adjusting the colormap can be tricky. If your pixel values for the tuning image are in the range \\([1, n_{stims}]\\) (and untuned pixels have values < 1), then the following code snippet will handle plotting correctly:

      ```matlab
      figure
      image(plot_img, 'CDataMapping', 'scaled');
      colormap([zeros(1, 3); parula(nstims)])
      cc = colorbar();
      cc.TickLabels = {'None', stim_names};          
      ```

      where

        - `plot_img` is the image to plot
        - `nstims` is the number of stimuli
        - `stim_names` is a cell array of stimulus labels for the colorbar
</div>

## Optimization: loop order
In many cases of interest, the order in which we loop over arrays can impact performance. Let's see if it makes a difference in our case.

<div class="question" markdown="1">
1. Use Matlab to time the execution of the part of your code that calculates the tuning image pixel-by-pixel.
1. How does the timing compare if you loop over the array in the opposite order (i.e., rows in the inner loop instead of columns or vice-versa)? Why or why not does this make a difference?
</div>

## Optimization: profiling
Clearly, the pixel-by-pixel calculation of tuning is the most time-intensive step in our procedure. To get a better sense of where our program is spending its time, we'll use the [Matlab profiler](https://www.mathworks.com/help/matlab/matlab_prog/profiling-for-improving-performance.html) to take a look:

<div class="question" markdown="1">
1. Profile your code (either the tuning image generation itself or the entire homework).

    - Where does your code spend most of its time?
    - What piece of the code would you need to speed up in order to improve performance?
    - How might you do this?
</div>

## Optimization: parallelism
In cases where the bottleneck in our code is one of Matlab's own functions, and we're *not* free to change our approach to the problem (e.g., the algorithm or approximation we're using), we can still gain some traction by using parallel computing. The simplest method for doing this is `parfor`, which executes code in parallel processes on your laptop (or on a cluster you're connected to). In our case, because the calculation at each pixel is independent of every other, the problem is [embarrassingly parallel](https://en.wikipedia.org/wiki/Embarrassingly_parallel) and we can easily use `parfor`.

<div class="question" markdown="1">
1. Use `parfor` to parallelize your pixel tuning calculation. Use `parpool` to request 4 workers.

1. How big a speedup did you get? (Make sure not to time the `parpool` setup step, which is once per session.) We would naively expect the computation time to be 4x smaller. Why might your answer differ from this?
</div>
