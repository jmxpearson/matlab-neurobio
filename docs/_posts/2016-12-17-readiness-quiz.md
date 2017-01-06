---
layout: default
title: Quantitative Neurobiology
desc: Matlab notes, assignments, and code
post_title: Matlab readiness quiz
author: John Pearson
category: blog
---

First of all, **don't panic**. This quiz is supposed to be challenging. My goal is to figure out how much basic programming you're familiar with in Matlab so we can calibrate the course properly. In principle, the material here should be doable for anyone who's completed something like [this](https://www.coursera.org/learn/matlab) online class.

You can download the data for all the questions [here](https://github.com/jmxpearson/matlab-neurobio/tree/master/data/pretest). Data for each question are in the corresponding `.mat` file, which you can load into Matlab. This is a self-assessment. You do not need to mail your answers to me, but feel free to contact me to ask questions if you're stuck. Use whatever resources you want to complete the assignment; programming is not about having things memorized.

So here goes:

1. **FizzBuzz**: Write a program that prints the numbers 1 to 100 to the Matlab console. Only observe the following exceptions:
  - if the number is a multiple of 3, print "fizz."
  - if the number is a multiple of 5, print "buzz."
  - if the number is a multiple of 3 and 5, print "fizzbuzz."

2. Write a function that accepts as input a probability `p` and an integer `n`. The function should return a vector of `n` random binary numbers (either 0 or 1). Each entry should be 1 with probability `p`.

3. Given the data matrix `D`, with a separate data series in each row, write a function that returns a matrix `Z` of the same dimensions. Each row of `Z` contains the same data as `D`, but z-scored (i.e., mean 0, standard deviation 1).

4. Given the matrix `A`, make a new matrix `B` consisting of all rows in `A` that contain no negative elements.

5. Given the two-column matrix `A` (first column, observations; second column, time points), plot the raw data (as points) and a solid line showing the smoothed data using any method you choose.

6. Write a function that takes as input the array of structs `S` and returns a cell array equal to the number of fields of each struct in `S`. Each element of the returned cell array should collect all the values from the corresponding field in `S`. For example, if the elements of `S` are points with `x` and `y` fields, the returned value would be a cell array with two cells, one containing a vector of all the `x` values, the other all `y` values.
