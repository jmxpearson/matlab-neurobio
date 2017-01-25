---
layout: default
title: Quantitative Neurobiology
desc: Matlab notes, assignments, and code
post_title: "Week 2: Imaging data"
author: John Pearson
category: blog
---
For week three, we'll be working with imaging data. Two-photon imaging, to be precise, though other types of imaging present similar challenges. Unlike point process (i.e., spike) data, which are just collections of events &mdash; temporal data &mdash; imaging data are *spatiotemporal*: we must deal not only with time, but space as well. In practice, this means not only working with time series, but with images: **time series of images**.

On the coding side, we'll be devoting some time this week to learning what makes code run fast, why some programming languages are faster than others, the strengths and weaknesses of Matlab as a coding platform when we need lots of computation, and the tools Matlab provides for helping us find and remove speed bottlenecks in our code.

Much of what we will learn can be summarized in the classic quote by computer scientist Donald Knuth:

> “We should forget about small efficiencies, say about 97% of the time: **premature optimization is the root of all evil.** Yet we should not pass up our opportunities in that critical 3%. A good programmer will not be lulled into complacency by such reasoning, he will be wise to look carefully at the critical code; but only after that code has been identified.”

So **before our first class**:

- Read about how to measure the [performance of your program](https://www.mathworks.com/help/matlab/matlab_prog/measure-performance-of-your-program.html).
- Read about [`image`](https://www.mathworks.com/help/matlab/ref/image.html),  [`imshow`](http://www.mathworks.com/help/matlab/ref/imshow.html), and [`imagesc`](http://www.mathworks.com/help/matlab/ref/imagesc.html) as well as [the difference](https://www.mathworks.com/matlabcentral/answers/1288-what-is-the-difference-between-image-and-imshow) between them.
- Know about the [`squeeze`](http://www.mathworks.com/help/matlab/ref/squeeze.html) function.

and **before our second class**:

- Learn about [how to use the Matlab profiler](https://www.mathworks.com/help/matlab/matlab_prog/profiling-for-improving-performance.html).
- Learn about [strategies for improving performance](https://www.mathworks.com/help/matlab/matlab_prog/techniques-for-improving-performance.html).
- Learn about simple parallel computing with [parfor](https://www.mathworks.com/help/distcomp/parfor.html).

<!-- - Watch a short video about convolutions:
    <video width="100%" align="center" controls src="{{ site.videourl }}/convolutions.mp4" type="video/mp4">
		Your browser does not support the video tag.
	</video> -->
