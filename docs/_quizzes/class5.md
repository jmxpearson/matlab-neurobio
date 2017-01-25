---
layout: page
title: Class 5
desc: Matlab notes, assignments, and code
week: 3
part: 1
author: John Pearson
---
1. If `A` is a Matlab array with size (3, 1, 2, 1), what is the size of `squeeze(A)`?
    1. (3, 1, 2)
    1. (1, 3, 1, 2, 1)
    1. (3, 2)
    1. (3, 2, 1)
    1. (1, 1) (i.e., a scalar)

1. For a simple function that runs in roughly 0.05 seconds, what is the best method for measuring its speed?
    1. `tic`/`toc`
    1. `cputime`
    1. `timeit`
    1. stopwatch
    1. atomic clock

1. Which of the following is **not** a difference between `image` and `imshow`?
    1. `image` creates images; `imshow` plots them
    1. `image` is about viewing data as images; `imshow` is for displaying variables that already are images
    1. `image` changes the aspect ratio of the data; `imshow` doesn't
    1. `image` keeps axes and labels; `imshow` doesn't
    1. `image` allows you to plot a single matrix in color; `imshow` always plots it in black and white

1. Which of the following is the difference between `image` and `imagesc`?
    1. `imagesc` scales the data in the image so they use the full colormap range
    1. `image` scales the data in the image so they use the full colormap range
    1. `imagesc` does contrast correction on the image
    1. `imagesc` removes `NaN`s from the image
    1. `image` removes `NaN`s from the image

1. Which of the following is **not** a good practice for timing code in Matlab?
    1. Put the code you want to time inside a function.
    1. Run the code multiple times.
    1. Don't time very fast code by itself.
    1. Avoid `clear all`.
    1. Don't assign the output of the function to a variable.
