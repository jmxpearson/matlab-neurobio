---
layout: page
title: Debugging I
desc: Matlab notes, assignments, and code
week: 4
part: 1
author: John Pearson
---
# Debugging Practicum
In this class, we'll use all the tools at our disposal to fix some code that isn't working. [The data](https://github.com/jmxpearson/matlab-neurobio/blob/master/data/week4/pupiltest.mat) for this exercise are time series of pupil measurements taken while a participant completed an ["oddball" task](https://en.wikipedia.org/wiki/Oddball_paradigm). The complete code, including several utility functions, is available [on GitHub](https://github.com/jmxpearson/matlab-neurobio/tree/master/week4/broken). As with most code in the wild, this is only lightly commented.

A simple basic analysis is to look at trial-averaged pupil responses to standard and deviant sounds, locked to stimulus presentation. The main script used to run the analysis is `sample_analysis_scratch.m`. This constitutes what is often called a [minimal working example](https://en.wikipedia.org/wiki/Minimal_Working_Example) (MWE), apart from the fact that it's not quite minimal and not quite working.

Your goal in class, using whatever means you have at your disposal, is to find and remove the bugs.

<div class="question" markdown="1">
1. Fix the code. Note that not all bugs generate errors. To find some bugs, you will need to understand what the pieces of the code are trying to accomplish. Using the debugger to help you trace the code may be very helpful.
</div>
<!-- ## [Solutions](https://github.com/jmxpearson/matlab-neurobio/blob/master/week3/) -->
