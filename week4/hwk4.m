%% generate trials from LATER model
max_RT = 1000;
theta = 10;
mu = 3;
sigma = 0.2;
Ntrials = 1e4;
T = later(theta, mu, sigma, Ntrials, max_RT);

% remove timeouts (i.e., T == max_RT)
T = T(T < max_RT);
%% histogram times 
histogram(T , 100);

%% histogram inverse times
histogram(1./T, 100);

%% Q-Q plot
qqplot(1./T);

%% DDM trials
theta = 10;
mu = 0.1;
sigma = 0.2;
T = ddm(theta, mu, sigma, Ntrials);

%% histogram times 
histogram(T , 200);

%% histogram inverse times
histogram(1./T, 100);

%% Q-Q plot
qqplot(1./T);

%% race model trials
theta = 10;
mu1 = 0.1;
mu2 = 0.08;
sigma1 = 0.2;
sigma2 = 0.25;
T = racemodel(theta, mu1, mu2, sigma1, sigma2, Ntrials);

%% histogram times 
histogram(T , 200);

%% histogram inverse times
histogram(1./T, 100);

%% Q-Q plot
qqplot(1./T);