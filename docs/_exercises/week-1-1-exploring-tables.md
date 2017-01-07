---
layout: page
title: Exploring table data
desc: Matlab notes, assignments, and code
week: 1
part: 1
author: John Pearson
---
# Exploring table data
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

<div class="question" markdown="1">
1. Load the data into Matlab. This can be done via the `readtable` function.

1. Print the first 5 rows of the table. What are the column names? What is a way to find this out without printing the table directly (i.e., what if you had to find this out within a function)?
</div>

## Reformat data
One of the downsides of text formats like `.csv` is that files don't specify the type of data in each column. Programs that read such data typically use heuristics to make an educated guess. In particular, programs need some policy for deciding whether string data (e.g., "chicken") merely represent text or are categorical data (e.g., the column can only be "chicken," "duck," or "turkey"). When loading in tabular data, one often has to write boilerplate code to reinterpret some variables as categorical, others as dates, etc.

<div class="question" markdown="1">
1. Which columns in the dataset should be categorical? What syntax would you use to replace this column with a categorical version of itself?

1. Write code that allows you to make this correction for an arbitrary number of columns:
    1. How would you specify a list of columns? What data structure would you use?
    1. How would you generalize your code from the first part to transform a single column if you were given that column in a variable? (Hint: If `colname` is a variable containing a column name and `tbl` a table, `tbl.(colname)` selects the column. This also works for structs.)
    1. How would you repeat the process for every column in the list?
</div>
