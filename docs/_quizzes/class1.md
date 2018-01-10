---
layout: page
title: Class 1
desc: Matlab notes, assignments, and code
week: 1
part: 1
author: John Pearson
---
Consider the table below:

Mouse | Genotype | Rotarod | Tail Suspension | Drug | Age
--- | --- | --- | --- | --- | ---
1 | WT | 15.14 | 35.1 | Yes | 25
2 | KO | 11.51 | 10.2 | No | 26
3 | WT | 12.22 | 25.1 | Yes | 25
3 | WT | 17.07 | 22.7 | No | 25
3 | WT | 11.81 | 31.6 | Yes | 25

1. Which columns of this table should best be transformed to `categorical` in Matlab?
    1. Mouse, Genotype, Drug
    1. Mouse, Genotype
    1. Genotype, Drug
    1. Mouse, Drug
    1. Mouse, Genotype, Rotarod, Drug

1. This table is not tidy. Which best describes *why?*
    1. Columns are not rounded to the same number of decimal places.
    1. Some rows contain redundant information.
    1. Rows are not uniquely identified.
    1. Each row represents more than one observation.
    1. Both 2 and 3.

1. What would need to be done to tidy this table?
    1. Make a separate table for Mouse, Genotype, and Age.
    1. "Melt" the Rotarod and Tail Suspension columns.
    1. "Melt" the Rotarod, Tail Suspension, and Drug columns.
    1. Move Genotype and Drug into a separate table.
    1. Add a unique session number for each row.

1. Which of the following snippets builds a table with the variables `animal` and `treatment` and sorts the rows by `animal` and then by `treatment` within `animal`. Assume `animal` and `treatment` are existing categorical variables.
    1. ```matlab
       tbl = table(animal, treatment);
       sortrows(tbl, {'animal', 'treatment'});
       ```
    1. ```matlab
       tbl = table(animal, treatment);
       sortrows(tbl, animal, treatment);
       ```
    1. ```matlab
       dat = table(animal, treatment);
       sortrows(tbl, {'animal', 'treatment'});
       ```
    1. ```matlab
       dat = table('animal', 'treatment');
       sortrows(dat, {'animal', 'treatment'});
       ```
    1. ```matlab
       tbl = table(animal, treatment);
       sortrows(tbl, 'animal', 'treatment');
       ```

1. Which of the following creates a function named `last` that returns the final element of an array?
    1. ```matlab
       last = @(A) A(end);
       ```
    1. ```matlab
       last = function(A) A(end);
       ```
    1. ```matlab
       last = function(A)
          return A(end);
       end
       ```
    1. ```matlab
       @last(A) A(end);
       ```
    1. ```matlab
       last = function(A)
          last = A(end);
       end
       ```
