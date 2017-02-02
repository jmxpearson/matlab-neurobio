function [pupil, taxis, t0] = prepdata(eyedata)
% loads data in from file and munges it
% makes left and right eye data, mean of the two, and time axis
% t0 is the time stamp at which data collection starts

% munge data
try
    lpup = cleanseries(eyedata.lefteye(:, 12));
    rpup = cleanseries(eyedata.righteye(:, 12));
    
    % get initial timestamp, convert microseconds to seconds
    t0 = min(eyedata.timestamp);
    taxis = us2secs(eyedata.timestamp, t0);
catch
    lpup = cleanseries(eyedata.lefteye(:, 12));
    rpup = cleanseries(eyedata.righteye(:, 12));
    t0 = min(eyedata.timestamp);
    taxis = us2secs(eyedata.timestamp, t0);
end
mpup = nanmean([lpup rpup], 2);
pupil = mpup;

