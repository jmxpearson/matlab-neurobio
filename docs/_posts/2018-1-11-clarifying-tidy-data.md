---
layout: default
title: Quantitative Neurobiology
desc: Matlab notes, assignments, and code
post_title: Clarifying tidy data
author: John Pearson
category: blog
---

One of the issues that came up this week in our discussion of tidy data is whether there's ever a case when having multiple observed numbers on each row of a table could be considered tidy. The example is Table 12 in the tidy data paper, in which both tmin and tmax are recorded in each row.

The answer is that, apart from a rigorous mathematical definition, there is some wiggle room in deciding whether a data set is tidy. For instance, consider an eye tracking data set with eye position locations at every point in time

Time | X | Y
--- | --- | ---
0.5 | 0.7 | 0.8
0.55 | 0.72 | 0.81
0.6 | 0.75 | 0.88

Note that we have two observations, the x and y coordinates, in each row. By the strictest definition, the data are not tidy. However, there is never a case when we would measure one of these datums without the other. The two of them could also be considered a single *multivariate* observation.

In general, I personally favor keeping multiple observations in the same column when

- Multiple columns are semantically related (eye coordinates, blood pressure numbers).
- These observations are either always present together or always absent. One cannot observe one without the other.
- It makes working with your data easier. Practicality beats purity.

That's my take. Your mileage may vary. Once you know the rule, you're free to break the rule.
