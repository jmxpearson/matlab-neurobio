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

### Categorical

One of the downsides of text formats like `.csv` is that files don't specify the type of data in each column. Programs that read such data typically use heuristics to make an educated guess. In particular, programs need some policy for deciding whether string data (e.g., "chicken") merely represent text or are categorical data (e.g., the column can only be "chicken," "duck," or "turkey"). When loading in tabular data, one often has to write boilerplate code to reinterpret some variables as categorical, others as dates, etc.

<div class="question" markdown="1">
1. Which columns in the dataset should be categorical? What syntax would you use to replace this column with a categorical version of itself?

1. Write code that allows you to make this correction for an arbitrary number of columns:
    1. How would you specify a list of columns? What data structure would you use?
    1. How would you generalize your code from the first part to transform a single column if you were given that column in a variable? (Hint: If `colname` is a variable containing a column name and `tbl` a table, `tbl.(colname)` selects the column. This also works for structs.)
    1. How would you repeat the process for every column in the list?
</div>

### Text to numeric
In some cases, tabular data may be read in as text when it should be coded as numeric.

<div class="question" markdown="1">
1. What type is the `cued` column? What should it be?

1. Write code that converts the `cued` column to an appropriate type.
    1. How would you convert a single value in this column?
    1. How would you apply this to every value in the column? (Hint: `cellfun`.)
</div>

## Tidying data
Many data tables are structured with multiple observations in each row, but for many analysis and visualization needs, data are better structured as one observation per row or ["tidy" data](https://www.jstatsoft.org/article/view/v059i10). While not perfect for all purposes, tidy data provides a method for canonicalizing data so that software can focus on transferring to and from a fixed form.

In Matlab, the key functions for this purpose are `stack` and `unstack`. For a more full-featured approach in R, see [tidyr](https://blog.rstudio.org/2014/07/22/introducing-tidyr/).


<div class="question" markdown="1">
1. What changes must be made to put this dataset in tidy format?

1. Write code that performs this conversion:
    - Make sure that any new columns you introduce are named appropriately. This can be specified as extra arguments to the necessary functions.
    - It may be tempting to write out all the columns that need to be manipulated by hand, but work toward a solution that would work if you had 20 or 50 such columns. (Hint: do the column names form a pattern? How would you get the names of all columns that follow this pattern?)
</div>

## Group-level statistics
Having data in tidy format can facilitate easier comparisons across observation types. In Matlab, the relevant function for calculating statistics across categorical groups is `grpstats`.

<div class="question" markdown="1">
1. Use `grpstats` to calculate the mean and variance of spike counts in each epoch.
</div>

## Exploratory plotting
For comparing data across categories, the typical visualization is a [box plot](http://www.physics.csbsju.edu/stats/box2.html) or [violin plot](https://en.wikipedia.org/wiki/Violin_plot). The former is available in Matlab, while the latter requires using third-party code.


<div class="question" markdown="1">
1. Create a box plot of spike count versus epoch. What do you learn about these data? What could be problematic about comparing means of these distributions, as we did earlier?
</div>
