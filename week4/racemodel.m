function [T, decision] = racemodel(theta, mu1, mu2, sigma1, sigma2, Ntrials)

T = nan(Ntrials, 1);
decision = nan(Ntrials, 1);

for tt = 1:Ntrials
    % initialize variables for this trial
    finished = 0;
    y1 = 0;  % decision variable
    y2 = 0;  % decision variable
    t = 0;  % decision time
    
    % do biased random walk until threshold crossed
    while ~finished
        y1 = y1 + mu1 + sigma1 * randn;
        y2 = y2 + mu2 + sigma2 * randn;
        t = t + 1;
        if (y1 >= theta || y2 >= theta)
            T(tt) = t;
            finished = 1;
            if y1 > y2
                decision(tt) = 1;
            else
                decision(tt) = 2;
            end
        end
    end
end