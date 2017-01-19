---
layout: page
title: "Homework: refactoring"
desc: Matlab notes, assignments, and code
week: 2
part: 3
author: John Pearson
---
# Homework: refactoring

This homework is a chance to practice what we've learned this week about modularity, refactoring, and analyzing point process data by reproducing a well-known result in systems neuroscience. For the first part of the homework, you'll be reproducing the left half of Figure 9A in [Roitman and Shadlen (2002)](https://www.researchgate.net/profile/Jamie_Roitman/publication/11047612_Response_of_neurons_in_the_lateral_intraparietal_area_during_a_combined_visual_discrimination_reaction_time_task/links/5449248d0cf2ea6541302c6e.pdf). One of the nice things about this data set is that it's publicly available online and well-documented [here](https://www.shadlenlab.columbia.edu/resources/RoitmanDataCode.html). You are free to use those data, but for purposes of the homework, I'm giving you a `.csv` file that's preprocessed to include only the data of interest [(link)](https://github.com/jmxpearson/matlab-neurobio/blob/master/data/week2/roitman_data.csv).

The goal of this assignment is to give you practice in building a small piece of an end-to-end analysis. Multiple strategies will work, but you will need to make decisions about what data to use, how to process it, and what operations need to be done to match those in the paper. I suggest you start small, perhaps by subsetting the data, and iteratively improving your code.

## Firing rates
<div class="question" markdown="1">
1. Load the data. Each row includes a spike count for a given time bin in a given trial. Other columns indicate dot coherence, the unit being recorded, whether the choice was correct, and whether the target appeared in the response field (RF) of the neuron.
1. Reproduce the left half of Figure 9A in the paper (the plot from 0 to 1000ms). I expect:
    - Axis labels and titles
    - A legend
    - Lines thick enough to be legible
    - Colors that are consistent for a given coherence
    - Dotted lines where dotted lines are used
    - Appropriate smoothing (**Conceptual question**: Is it better to average across trials then smooth, or smooth and then average?)

   I do not expect:

    - Colors to be the same as those in the paper.
    - The "a" and "b" annotations with arrows.
    - Your plot to look *exactly* the same. In particular, the figure in the paper is smoother than I can figure out how to make mine by using their stated smoothing.
</div>
