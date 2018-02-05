---
layout: default
title: Quantitative Neurobiology
desc: Matlab notes, assignments, and code
post_title: "Week 5: Fitting models"
author: John Pearson
category: blog
---
In our last week on programming, we'll pivot toward the rest of the semester's material by talking about fitting computational models. Perhaps surprisingly, the actual mechanics behind fitting models to data is rarely discussed, and so we'll focus a little on the theory of fitting and the rest of our time on the actual mechanics of writing code that does this.

So **before our first class**:

- Read about Matlab's [`fminsearch`](https://www.mathworks.com/help/matlab/ref/fminsearch.html) function.
- Watch a video on the math behind linear regression:
    <video width="100%" align="center" controls src="{{ site.videourl }}/linear_regression.mp4" type="video/mp4">
		Your browser does not support the video tag.
	</video>

In the most generic case, finding the minimum of an arbitrary function \\(f(x)\\) is computationally intractable: there is no guarantee we can find the global minimum. However, in many cases of interest, special properties of \\(f(x)\\) allow us to make use of symmetries that allow for efficient solution of the problem. Much of the research on optimization involves either proving that some class of optimization problems can be reduced to another with nice mathematical properties (so optimization can be performed efficiently) or designing new optimization algorithms that solve some class of problems faster (in fewer steps or less time per step).

For our second class this week, we'll focus on simply using Matlab's facilities for optimization without getting into details of the algorithms involved. That is, we'll treat these as "black box" methods that take in an function \\(f\\) and spit out an answer.

So, **before our second class**:

- Read about [optimizing nonlinear functions](https://www.mathworks.com/help/matlab/math/optimizing-nonlinear-functions.html)
- Read about [curve fitting via optimization](https://www.mathworks.com/help/matlab/math/example-curve-fitting-via-optimization.html).
