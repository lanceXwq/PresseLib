function randc_benchmark(height, width)
    %RANDC_BENCHMARK - Offers a benchmark for different algorithms
    %
    % Syntax: randc_benchmark(height, width),
    % where height and width are dimensions of a testing probability matrix.

    p = rand(height, width);
    seed = randi(1e6);
    rng(seed)

    % the naive way
    tic
    s = cumsum(p, 2);
    N = size(p, 1);
    r = rand(N, 1) .* s(:, end);
    for idx = N:-1:1
        c1(idx, 1) = find(r(idx) < s(idx, :), 1);
    end
    toc

    rng(seed)
    tic
        S = cumsum(p, 2);
        [~, c2] = max(rand(size(p, 1), 1) .* S(:, end) < S, [], 2);
    toc
    
    
    rng(seed)
    tic
        c3 = randc(p);
    toc

    c2 = abs(c2 - c1);
    c3 = abs(c3 - c1);
    if any(c2 + c3)
        disp('inconsistent results')
    end