function c = randc(p)
    % c = RANDC(p) returns a category chosen from a categorical distribution 
    % specified by a vector p.
    % p does not have to be normalized
    S = cumsum(p, 2);
    [~, c] = max(rand(size(p, 1), 1) .* S(end) < S, [], 2);
