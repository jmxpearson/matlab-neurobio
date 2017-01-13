---
layout: default
title: Quantitative Neurobiology
desc: Matlab notes, assignments, and code
post_title: "Week 2: Spike data"
author: John Pearson
category: blog
---
In our second week, we'll be working with a ubiquitous data type in neurobiology: point process or event data. Typically, these events are action potentials, but they could also be EPSPs, vesicle releases, or even communication in social networks. We'll focus on common exploratory data approaches, including the peri-stimulus/peri-event time histogram, and estimation of firing rates.

We'll also be talking about [refactoring](https://www.refactoring.com/), the process of iteratively rewriting code to make it cleaner, more useful, and more maintainable. As a result, much of this week's in-class work will have you writing and rewriting the same analyses, each time making them more generic and reusable. Along the way, we'll touch on related issues such as code smells, testing, and the [red-green-refactor](http://www.jamesshore.com/Blog/Red-Green-Refactor.html) method.

So **before our first class**:

- Read about [best practices](http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1001745) for scientific computing.
- Read about the [test-driven development cycle](https://en.wikipedia.org/wiki/Test-driven_development#Test-driven_development_cycle) (this section only).
- Read about [preallocating arrays](https://www.mathworks.com/help/matlab/matlab_prog/preallocating-arrays.html) in Matlab.
- Read about creating [subplots](https://www.mathworks.com/help/matlab/ref/subplot.html) in Matlab.

and **before our second class**:

- Read about ["good enough" practices](https://arxiv.org/pdf/1609.00037v2.pdf) for scientific computing.
- Read about the `patch` [command](https://www.mathworks.com/help/matlab/ref/patch.html).
- Read about [convolutions](https://en.wikipedia.org/wiki/Convolution#Visual_explanation).
- Watch a short video about convolutions: **coming soon**
    <!-- <video width="100%" align="center" controls src="{{ site.videourl }}/tables.mp4" type="video/mp4">
		Your browser does not support the video tag.
	</video> -->
