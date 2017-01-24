---
layout: page
title: Exploring Image Data
desc: Matlab notes, assignments, and code
week: 3
part: 1
author: John Pearson
---
# Image data
Image data in neurobiology can be broadly divided into two types:

- **Static images**, including histology, gene expression maps, and other 2 and 3-d images. These represent data at a single time point.
- **Dynamic images**, including calcium and fMRI imaging. These represent data as a sequence of images, with a collection of images at each time.

## Loading the data
This week's data are available for download on [GitHub](https://github.com/jmxpearson/matlab-neurobio/blob/master/data/week3/DirectionTuning_V1_dec.mat). The data are recordings of calcium imaging experiments in mouse V1 that come to us courtesy of Ashley Wilson in Lindsey Glickfeld's lab. The data are once again in `.mat` format. This week, they are large by the standards of what we've been working with (~200MB), though far smaller than such datasets are for real experiments. In the actual experiments, images are taken at 30 Hz (30 images per second), whereas the sample data are downsampled to 3 Hz.

In the experiment that generated these data, the mice were exposed to a series of drifting grating stimuli, and recorded responses were images reflecting calcium fluorescence levels. The stimuli consisted of drifting gratings at a variety of orientations, probing the sensitivity of cells in V1 to both orientation and motion direction.

The variables in the data file are:

- `data`: This week, it will be up to you to determine what dimensions correspond to what variables.
- `dirTuningExp`: A structure containing metadata about the experiment. In particular:
    - `nTrials`: Number of trials in the data.
    - `stimOffFrames`: Number of frames during which no stimulus was presented.
    - `stimOnFrames`: Number of frames during which each stimulus was presented.
    - `tGratingDirection`: Direction of drift of the moving grating on each trial.

Each trial (and thus the dataset) *began* with the stimulus off and then switched it on.

<div class="question" markdown="1">
1. Load the data.
1. Based on principles of memory layout we've discussed, which dimension of the array *should* be time, if we're mostly interested in performing analysis on the individual images?
1. Plot sections of the data (as images) to determine which dimension of the `data` array *is* time.
</div>

## Converting from images to time series
In addition to a sequence of images, we can also think of these data as a collection of time series, one per pixel.

<div class="question" markdown="1">
1. Extract the calcium time series for a few representative pixels. Plot them. Be sure your x-axis reflects the actual time between images/samples.
</div>

## Converting from arrays to movies
For spatiotemporal data, one of the best ways to gain qualitative insight is by using your eye as a pattern detector. For a sequence of images, Matlab, like many languages, will allow us to play them as a movie. The [`movie`](https://www.mathworks.com/help/matlab/ref/movie.html) command has facilities for allowing this movie to be stored in standard formats, but a quick and dirty version that allows you to look at the data interactively can be done in only a few lines of code.

<div class="question" markdown="1">
1. Iterate through the frames of the movie, plotting each one, followed by the `drawnow` command. `drawnow` ensures the figure will be shown immediately and updated with each plot, instead of showing only the final image.
1. Make sure the colors in your plot are appropriately normalized. Different image functions have different expectations about the range of values in the data you feed them, but it might help, for example, to make sure that the values in each pixel are between 0 and 1 across all images. More specifically, make sure you are normalizing **across** images, not just **within** images.
</div>

## Tuning curves: a first pass
For each recorded neuron in the movie, we might like to assess its sensitivity to both orientation and motion direction. To do this, we first need to find the locations of cells within the image (and they might move), then appropriately average the calcium fluorescence time series, then finally assess whether a stimulus is tuned and to what degree.

But for programming, we should start simple, with the most straightforward version we can think of: let's try to assess the tuning of each *pixel* and do so with a back-of-the-envelope sort of calculation that we can refine as we go.

<div class="question" markdown="1">
1. Let's start with a fixed point in the image (e.g., (46, 200)). Plot the calcium fluorescence time series for that point.
1. For the stimulus-off baseline and each orientation, find the mean calcium activation. There are lots of ways to do this. Plot the tuning curve as a function of motion direction. Make sure to label the x-axis appropriately and indicate the baseline activation level.
1. Find the orientation for which activation is maximal. Do this programmmatically, since we'll want to automate this for each pixel later.
</div>

Unfortunately, this method for finding the preferred orientation has a few problems:

- It's very brittle. (Imagine what happens if two response values are very close.)
- It ignores the structure of the stimulus. (Shouldn't a tuning curve look like, well, a tuning curve? That is, shouldn't 180&deg; be a low response if the cell is tuned to 0&deg;?)
- It ignores noise. (What if those two close peaks have very different uncertainties?)
- It assumes each pixel is tuned. (What if none of the stimulus responses is different from baseline?)

Next class, we'll work to remedy some of these defects. 

<!-- ## [Solutions](https://github.com/jmxpearson/matlab-neurobio/blob/master/week1/) -->
