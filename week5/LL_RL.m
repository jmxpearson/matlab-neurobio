function [LL, Q] = LL_RL(beta, choice, outcome)
% GIVEN parameters
% beta(1): softmax parameter
% beta(2): learning rate
% a vector of choices
% a vector of outcomes (binary: 1 = reward)
% RETURN: the log likelihood of each choice and the Q-values for each option
% on each choice
% ASSUMED: only two options

% PEDANTIC NOTE: this function is fancier than what you need
% If you return multiple values, the optimization routines will only use
% the first; returning a single LL is enough.
% Here, I'm returning both the LL for each trial and the Q-values for each
% trial. This can be helpful for diagnosing numerical problems, but is more
% than the exercise asked for.

Ntrials = length(choice);
alpha = beta(2);
gamma = beta(1);

Q = nan(Ntrials, 2);
LL = nan(Ntrials,1);
Q(1, :) = 0;

for ii = 1:Ntrials
    QA = Q(ii, 1);
    QB = Q(ii, 2);
    pB = 1./(1 + exp(-gamma * (QB - QA)));
    
    switch choice(ii)
        case 1
            LL(ii) = log(1 - pB);
        case 2
            LL(ii) = log(pB);
    end
    
    % calculate reward prediction error
    this_Q = Q(ii, choice(ii));
    RPE = outcome(ii) - this_Q;
    
    % update value
    new_Q = this_Q + alpha * RPE;
    
    if ii < Ntrials
        Q(ii + 1, :) = Q(ii, :);
        Q(ii + 1, choice(ii)) = new_Q;
    end
end