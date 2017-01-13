---
layout: page
title: Exploring point process data
desc: Matlab notes, assignments, and code
week: 2
part: 1
author: John Pearson
---
# Point process data
Data recorded from (extracellular) single unit electrophysiology are typically recorded as time series of voltages, but one is typically only interested in the times at which action potentials occur. Thus, after spike detection and sorting, the resulting data are a list of timestamps for each putative neuron, which we'll refer to as a unit. Data that come in the form of event timestamps are known as point process data, and this week, we'll work on reproducing some standard methods for exploring and analyzing them.

## Loading the data
This week's data are available for download on [GitHub](https://github.com/jmxpearson/matlab-neurobio/blob/master/data/week2/fef_spikes.mat). The data are recordings from three units in macaque frontal eye field (FEF) recorded by Tim Darlington in Lisberger Lab. The data are in Matlab's own `.mat` format and consist of three variables:

- `spikes`: a cell array in which each cell contains an array of spike timestamps (trials x units)
- `H` and `V`: horizontal and vertical eye positions (trials x time points)

<div class="question" markdown="1">
1. Load the data.
1. Write code that extracts the number of units, trials, and timepoints from the data.
</div>

## Converting from events to time series
Often, we need to convert from a list of event times to a time series representation of the same data. For instance, rather than listing all times at which a spike occurred, we might want to know how many spikes occurred at each moment in time. That is, we'd like to make a histogram of spike counts using some small bin size.

Matlab used to have two histogram functions, `hist` and `histc` that overlapped in function and were called with different conventions. They still exist, but are being deprecated in favor of the newer, more unified, `histcounts` and `histogram`. The former produces counts, the latter plots.

To perform the conversion, we'll start by taking only a small subset of the data, spikes for a single unit on a single trial, and converting that list to a time series.

<div class="question" markdown="1">
1. Extract the spike times for unit 1 on trial 1.
1. Get a count of spikes during each millisecond of the trial. Note that spike timestamps are recorded in milliseconds.
1. Write a test or tests to check whether you got the right answer. Each test should be a line of code that evaluates to true or false based on the raw data and time series. (Hint: tests often check mathematical properties that should be true both before and after some operation is performed.)
</div>

### Refactor: generalizing to multiple trials and units
Now that you have code that works on a single list, you can generalize to code that works on multiple trials and multiple units.

<div class="question" markdown="1">
1. Generalize your code to do this conversion over multiple trials and units. The result should be a time points x trials x units array.
1. Extend your test code to perform the same sets of checks on the array created by this new code.
</div>

### Refactor: make it a function
Once we have a pattern in code we know we'll be repeating, it's helpful to pull it into a function for several reasons:

- **Functions make our code more readable.** Functions give names to blocks of code, and when we choose these names to reflect what the code does, the flow of logic in our program becomes clearer.
- **Functions help keep our code [DRY](https://en.wikipedia.org/wiki/Don't_repeat_yourself).** When changes need to be made, we only have to edit one location.
- **Functions make our code safer.** Does your code create lots of temporary little variables that you need only for intermediate steps. Do you sometimes reuse these variable names later? Functions have well-defined inputs and outputs, but all other variables inside only exist for the lifetime of the function. This keeps our workspace neater and avoids some subtle bugs.

<div class="question" markdown="1">
1. Pull your spike binning code into a function. That function should take as input a cell array like the `spikes` variable, a minimum, and a maximum time, and return the same kind of spike count array as before.
1. Make sure your tests still pass on the output of the function.
</div>

### Refactor: generalizing to different bin widths
There are plenty of cases where we'd like to get spike counts over larger bins.

<div class="question" markdown="1">
1. Generalize your function to take a bin width as a parameter.
1. Make sure your tests still pass on the output of the function.
</div>

## Visualizing point process data
The most common plot in single unit electrophysiology is the peri-stimulus or peri-event time histogram (PSTH/PETH), which displays firing activity time-locked to some event of experimental importance. Most commonly, PSTHs are constructed as raster plots, in which each row represents one trial, time increases along the horizontal axis, and events are indicated by dots or tick marks.

With our array of spike counts in time, we have all we need to construct the simplest version of this plot. If we think of the first two dimensions of the count array (time and trial) as dimensions of an image, we can plot one image per unit by taking a slice of the count array and using plotting the result as pixels.

<div class="question" markdown="1">
1. Plot a PSTH using the data in the count array. Time should be the *horizontal* axis. (Hint: [`imagesc`](https://www.mathworks.com/help/matlab/ref/imagesc.html) scales the colormap to the range of data.)
</div>

### Refactor: adding behavior
We might also like to compare spiking with behavior. We can use the [`subplot`](http://www.mathworks.com/help/matlab/ref/subplot.html?searchHighlight=subplot&s_tid=doc_srchtitle) command to make multipanel figures that facilitate comparisons between the two. Let's make a figure with three rows and a single column that plot spiking, the horizontal, and the vertical eye positions as a function of time.

<div class="question" markdown="1">
1. Make the plot described above. Make sure the axes align. (Hint: you may want to use `xlim` and `ylim` to adjust for alignment and better readability.) Eye traces should all be plotted in the same color. Each panel should be titled.
</div>

### Refactor: make it a function
For plots we make often, it can be useful to repackage code into a function.

<div class="question" markdown="1">
1. Create a function to produce this plot. The function should take all needed data as inputs and only handle the plotting and layout.
</div>

<!-- ## [Solutions](https://github.com/jmxpearson/matlab-neurobio/blob/master/week1/) -->
