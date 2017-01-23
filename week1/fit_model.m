function [img_val, p_slope, sess, piccat] = fit_model(varargin)
    data = table(varargin{:});
    data.Properties.VariableNames = {'monk', 'session', 'piccat', 'dv', 'Nimg', 'Ntot', 'sessdate'};
    
    sess = data.session(1);
    piccat = data.piccat(1);
    
    data = data(data.Ntot ~= 0, :);
    
    fit = fitglm(data, 'Nimg ~ dv', 'Distribution', 'binomial', 'BinomialSize', data.Ntot);
    coeff_table = fit.Coefficients;
    beta = coeff_table.Estimate;

    img_val = -beta(1)/beta(2);
    p_slope = coeff_table.pValue(2);

end