function T = ddm(theta, mu, sigma, Ntrials)

T = nan(Ntrials, 1);

for tt = 1:Ntrials
    % initialize variables for this trial
    finished = 0;
    y = 0;  % decision variable
    t = 0;  % decision time
    
    % do biased random walk until threshold crossed
    while ~finished
        y = y + mu + sigma * randn;
        t = t + 1;
        if y >= theta
            T(tt) = t;
            finished = 1;
        end
    end
end