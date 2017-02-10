rng(12345)

%% simulate data
% note that we'll use a very similar process when fitting the data
% that's because we're fitting a *generative model*: a model of the process
% that we think generated the observed data
alpha = 0.05;
beta = 1.5;
Ntrials = 500;
pA = 0.7;
pB = 0.4;
RwdA = 2;
RwdB = 4;

Q = nan(Ntrials, 2);
Q(1, :) = 0;  % init options to 0 value
choice = nan(Ntrials, 1);
outcome = nan(Ntrials, 1);
for ii = 1:Ntrials
    QA = Q(ii, 1);
    QB = Q(ii, 2);
    
    % calculate probability of choosing Right
    p = 1./(1 + exp(-beta * (QB - QA)));
    
    % use this probability to calculate choice
    choice(ii) = (rand < p) + 1;
    
    % find outcome of choice
    switch choice(ii)
        case 1
            outcome(ii) = (rand < pA) * RwdA;
        case 2
            outcome(ii) = (rand < pB) * RwdB;
    end
    
    % calculate reward prediction error
    this_Q = Q(ii, choice(ii));
    RPE = outcome(ii) - this_Q;
    
    % update value
    new_Q = this_Q + alpha * RPE;
    
    % write values forward
    if ii < Ntrials
        Q(ii + 1, :) = Q(ii, :);
        Q(ii + 1, choice(ii)) = new_Q;
    end
end

%% plot
plot(Q)

%% fit data
LLfit = @(beta) sum(-LL_RL(beta, choice, outcome));

beta_RL = fmincon(LLfit, [1, 0.5], [], [], [], [], [0.001, 0], [Inf, 1]);