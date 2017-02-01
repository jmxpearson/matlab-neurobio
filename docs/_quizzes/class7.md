---
layout: page
title: Class 7
desc: Matlab notes, assignments, and code
week: 4
part: 1
author: John Pearson
---
<!--
Warning: question 1: you can't go lower than the breakpoint; q5: correct answers are 2 and 3!!! -->
1. Assume you have a set of functions `foo` calls `bar` calls `baz` calls `qux`. Using the debugger, you set a breakpoint in `bar`. When the program pauses, you issue the set of commands `dbup`, `dbup`, `dbdown`, `dbdown`. What function are you then inside?
    1. `foo`
    1. `bar`
    1. `baz`
    1. `qux`
    1. You left the debugger.

1. You are debugging a function that contains the three lines below

   ```matlab
   A = B' * B;
   C = inv(A);  % you are here
   for i = 1:nsteps
   ```
   If you are about to execute the middle line of the three, where does the command `dbstep in` take you?

   1. The following line.
   1. Past the end of the loop.
   1. The previous line.
   1. The first line of the `inv` function.
   1. The function that called this one.

1. Which of these is the best definition of a minimal working example (MWE)?
    1. The smallest amount of code needed to demonstrate a feature or reproduce a bug.
    1. The smallest amount of code needed to fix a bug.
    1. The smallest data set that illustrates a concept.
    1. The first piece of the code we can identify as bug-free.
    1. The easiest bug to fix.

1. If you wish to run your code and only enter the debugger if your calculation contains a NaN, which debugger command would you use?
    1. `dbstop on nan`
    1. `dbstop if nan`
    1. `dbstop in <file>`
    1. `dbstop if naninf`
    1. `dbstop`

1. If you wanted to pause execution of a program *before* it ran line 5 in `foo.m`, how would you instruct the debugger to do that?
    1. `dbstop in foo` and `dbstep` to line 5
    1. `dbstop in foo at 5`
    1. Click the `-` next to line 5 of `foo.m` in the editor.
    1. 1 or 2
    1. 1 or 3
