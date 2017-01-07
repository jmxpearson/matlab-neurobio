---
layout: page
title: Exploring table data
desc: Matlab notes, assignments, and code
week: 1
part: 1
author: John Pearson
---
## Exploring table data
Let's start by loading this week's sample data set, which you can retrieve from [GitHub](https://media.githubusercontent.com/media/jmxpearson/matlab-neurobio/master/data/week1/dictator.csv) These data are from [this study](http://www.pnas.org/content/112/52/16012.short) of social decision-making. Monkeys played a modified dictator game in which one, the "actor," was confronted on each trial with one of two choices:

* between a juice reward for himself and the other monkey (BOTH) or for himself
alone (SELF)
* between a juice reward for the other monkey (OTHER) or no one (NONE)

The data contain spike counts for several time periods during the trial,
as well as the trial type (some trials were "cued" (i.e., forced choice))
and which animals were involved.

In this lesson, we'll focus on exploring the data using Matlab, including
some tidying, summary statistics, and plotting.

## Loading table data
The most common format for storing tabular data is in comma-separated
value or `.csv` format, in which each line of the file contains a row of
the table, with columns separated by commas. Often, the first line of the
file lists the column names, also separated by commas.

<p class="question">Load the data into Matlab</p>
