---
layout: page
title: Fitting simulated models
desc: Matlab notes, assignments, and code
week: 5
part: 2
author: John Pearson
---
# Fitting simulated models
In our last class, we looked at fitting models based on a known probability distribution. This let us write down a likelihood function that we could calculate and subsequently optimize to find the model's parameters. But what if the probability distribution changes from trial-to-trial? What about models where there's no simple formula we can write down?

Thankfully, we can *still* make progress in cases like this because all that is required is that we can *compute* the likelihood algorithmically, not necessarily that it has a simple form we can write down. For this exercise, we'll be examining a very simple example of this by fitting a reinforcement learning model to data from a two-alternative forced choice (2AFT) task.

## The task
The task is simple: subjects are repeatedly presented with a pair of choices. One choice (A), delivers a reward of 2 units 70% of the time (and 0 otherwise), while another option (B) delivers a reward of 4 units 40% of the time. (**Quick**: which is better?) Subjects learn by trial and error about the values of each option and attempt to maximize reward.

[The data](https://github.com/jmxpearson/matlab-neurobio/blob/master/data/week5/choice.mat) for this session consist of two vectors, one entry per trial, of a single subject's choices and outcomes.


<div class="question" markdown="1">
1. Load the data. Which option does the subject choose more frequently over time?
</div>

## The model
Our goal is to fit a simple reinforcement learning algorithm to these data. This model consists of two pieces:

1. A *value model* that describes the benefit of choosing each option, along with a method of updating these values based on outcomes.
1. A *choice model* or *policy* that uses an estimate of the value of each option to make decisions.

The value model will assign each option a value \\(Q\\), its best estimate of the average reward gained by choosing that option. If, on a particular trial, choosing option A results in reward \\(R\\), then we update the value of \\(Q_A\\) according to
\\[
Q_A \leftarrow Q_A + \alpha (R - Q_A)
\\]
with \\(\alpha\in [0, 1]\\) the learning rate and \\(R - Q_A\\) the difference in observed and expected outcomes &mdash; the *reward prediction error*. Option B is updated in the same way when it is chosen.

When making choices, we assume the agent uses a *softmax* (in this case logistic) function that transforms the difference in value between options A and B into a probability. That is
\\[
p(B) = \frac{1}{1 + e^{-\beta (Q_B - Q_A)}}
\\]
and \\(p(A) = 1 - p(B)\\). The parameter \\(\beta\\) captures the variability in choice, with large \\(\beta\\) corresponding to an agent that always chooses the option with higher \\(Q\\) and \\(\beta = 0\\) an agent that chooses randomly.

Our goal will be to use the observed choices and outcomes to find the most likely values of the agent's parameters \\(\alpha\\) and \\(\beta\\). To do so, we will maximize the likelihood of the observed choices by adjusting the parameter values.

<div class="question" markdown="1">
1. Write a function that takes as inputs a vector of parameters, a vector of choices, and a vector of outcomes and returns the log likelihood of the choices and outcomes given the parameters. You will want to break this down into steps:
    1. The strategy is to loop over trials. For each trial you want to:
        1. Calculate the probabilities of choosing A or B given \\(Q_A\\) and \\(Q_B\\).
        1. Use these probabilities to compute the log likelihood of the **observed choice**. (**Hint:** if one has two mutually exclusive options, each chosen with a given probability, what's the distribution? What form does the likelihood take?)
        1. Calculate the reward prediction error (RPE).
        1. Use the RPE to update the \\(Q\\)-values **for the next trial**.
    1. The result will be a vector of log likelihoods, one per trial. If the trials are all independent (given the \\(Q\\)s), then there is a straightforward way of combining all these log likelihoods into a single value to be returned by your function.
1. Write a function to be optimized by Matlab (**Hint:** use a function handle). Two important notes:
    1. Your function to be optimized can only take a single input, the vector of parameters.
    1. Matlab only finds the **minimum** of functions, whereas we'd like to **maximize** the log likelihood.
1. Optimize your function to find the maximum likelihood values of \\(\alpha\\) and \\(\beta\\). Since we need \\(\alpha \in [0, 1]\\) and \\(\beta \ge 0\\), you'll need to use the optimization command that allows for constraints, [`fmincon`](https://www.mathworks.com/help/optim/ug/fmincon.html). `fmincon` has a pretty extensive list of options, but the ones you'll want are the upper and lower bounds on variables. If you only want to provide those, you can use `[]` for the other inputs:

   ```matlab
   fmincon(myfun, x0, [], [], [], [], lb, ub)
   ```
where `lb` is a vector of lower bounds and `ub` is a vector of upper bounds. If a particular variable is only constrained on one side, you can give `Inf` as the upper bound or `-Inf` as the lower bound.
</div>

## [Solutions](https://github.com/jmxpearson/matlab-neurobio/blob/master/week5/)
