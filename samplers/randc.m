function c = randc(p)
    % c = RANDC(p) returns a category chosen from a categorical distribution 
    % specified by a vector p.
    % p does not have to be normalized
    r = rand(size(p, 1), 1) .* sum(p, 2);
    c = randc_mex(p, r);
