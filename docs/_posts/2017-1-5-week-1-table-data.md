---
layout: default
title: Quantitative Neurobiology
desc: Matlab notes, assignments, and code
post_title: "Week 1: Tabular data"
author: John Pearson
category: blog
---

In our first week of class, we'll be exploring Matlab's capabilities for working with one of the most common data formats in all of science: tabular data. Data tables are the organizing principle behind spreadsheets, databases, and even [advanced data visualization](http://ggplot2.org/). Tabular data are typically organized with observations in rows and measured variables in columns, with the freedom to mix numbers, text, and dates in the same data structure.

Traditionally, Matlab has lacked facilities for dealing with tables, but in the last several years, it has introduced both [categorical variables](https://www.mathworks.com/help/stats/categorical-arrays.html) and [data tables](https://www.mathworks.com/help/matlab/tables.html), making analysis of mixed-type data sets like surveys and behavioral data much more tractable.

So **before our first class**:

- Make sure you have a recent version of Matlab installed and ready to go. R2016a or later is best.
- Read Hadley Wickham's [Tidy Data](https://www.jstatsoft.org/article/view/v059i10/v59i10.pdf) paper. Don't worry about the R syntax, but do internalize the concepts. How you organize your data can make a huge difference in how easy it is to analyze later.

and **before our second meeting**:

- Read about [the split-apply-combine method](https://www.jstatsoft.org/htaccess.php?volume=40&type=i&issue=01&paper=true). Again, don't worry about the R syntax; focus on the analysis pattern, which generalizes across programming languages. In our second session, we'll cover Matlab's syntax for performing many of the same operations.
