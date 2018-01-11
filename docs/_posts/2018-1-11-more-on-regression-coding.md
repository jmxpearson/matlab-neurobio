---
layout: default
title: Quantitative Neurobiology
desc: Matlab notes, assignments, and code
post_title: More on regression coding
author: John Pearson
category: blog
---

Following up on our discussion in class today:

When using a categorical variable in your regression (e.g., genotype, drug/no-drug), if you fit an intercept (and this is the default), then you are actually fitting *redundant* parameters. For example, in a model with genotype (WT, KO) and drug (Y, N) as parameters, then
- There are four conditions to be fit: WT-Y, WT-N, KO-Y, KO-N
- The coefficients in the model `y ~ g * d` (with `g` genotype, `d` drug, and an interaction term) are
  - an intercept (corresponding to WT-N)
  - a difference between WT and KO genotypes
  - a difference between drug and no drug
  - an interaction coefficient that captures how the KO-Y condition exceeds the prediction resulting just from the main effects
- But we could also have done:
  - an intercept that is the mean of all four groups
  - two numbers that specify how WT and KO differ from the mean (one is the negative of the other)
  - two numbers that specify how Y/N drug differ from the mean (these also add to 0)
  - four numbers that specify how each individual case differs from the predictions based on the main effects above

In both cases, however, there are four and only four *unique* numbers. They are all just linear combinations of one another. The first case is known as treatment coding, while the second case goes by the name of sum coding. Depending on your use case, one or the other is usually more interpretable.

For Matlab, the default is treatment (dummy) coding. Relevant docs are:
- [Formulas and design matrices](https://www.mathworks.com/help/stats/relationship-between-formula-and-design-matrix-.html)
- [Dummy variables](https://www.mathworks.com/help/stats/dummy-indicator-variables.html)

More info on how these work in [R](https://stats.idre.ucla.edu/r/library/r-library-contrast-coding-systems-for-categorical-variables/) and [Python](http://www.statsmodels.org/dev/contrasts.html).
