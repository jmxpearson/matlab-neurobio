---
layout: default
title: Quantitative Neurobiology
desc: Matlab notes, assignments, and code
post_title: "Week 4: Debugging"
author: John Pearson
category: blog
---
In our forth week, we're going to pivot from our tour of data analysis to a set of skills that will become increasingly important as you investigate topics in quantitative neurobiology. Each week so far has featured a programming theme along with a data type:

1. Table data
1. Refactoring
1. Profiling

These are all useful and applicable to even simple cases of running small data analyses, but for more complex work in modeling, we expect that code will grow and with it the complexity of writing and maintaining larger software projects. To begin to tackle that complexity, this week will focus on debugging.

All beginning programming students are either taught or stumble upon two methods of debugging:

1. Pepper your code with print statements like `disp('got to line 17')` also known as "debugging by `printf`."

1. Aimlessly changing things until the code sort of works. Call it "debugging by guesswork" or less charitably, "debugging by random walk."

To these, the last few years have made available another advanced technique: debugging by posting on StackOverflow.

These techniques can be highly effective. No kidding. But as you do a better job of refactoring code into functions and profiling to remove bottlenecks, code can become more difficult to explore interactively without doing major surgery. That is why almost every serious program language makes available a debugger.

So **before our first class**:

- Read an introduction to [Matlab's debugger](https://www.mathworks.com/help/matlab/matlab_prog/debugging-process-and-features.html)
- Pay special attention to the associated [keyboard commands](https://www.mathworks.com/help/matlab/debugging-code.html)

and **before our second class**:

- **TBD**
