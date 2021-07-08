function randc_benchmark(height, width)
    %RANDC_BENCHMARK - Offers a benchmark for different algorithms
    %
    % Syntax: randc_benchmark(height, width),
    % where height and width are dimensions of a testing probability matrix.

    p = rand(height, width);
    rng('default')

    % the naive way
    tic
    s = cumsum(p);
    N = size(p, 1);
    r = rand(N, 1) .* s(:, end);
    for idx = N:-1:1
        c1(idx) = find(r(idx) < s(idx, :), 1);
    end
    toc

    rng('default')
    tic
        c2 = randc(p);
    toc

    if nnz(c1~=c2)
        disp('inconsistent results')
    end