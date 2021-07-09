function randc_benchmark(height, width)
    %RANDC_BENCHMARK - Offers a benchmark for different algorithms
    %
    % Syntax: randc_benchmark(height, width),
    % where height and width are dimensions of a testing probability matrix.

    p = rand(height, width);
    seed = randi(1e6);

    % the naive way
    rng(seed); tic; c1 = randc_old_1(p); toc

    % a way to avoid for loops
    rng(seed); tic; c2 = randc_old_2(p); toc

    % (currently best) use the c api
    rng(seed); tic; c3 = randc(p); toc

    c2 = abs(c2 - c1);
    c3 = abs(c3 - c1);

    if any(c2 + c3)
        disp('inconsistent results')
    end

end

function c = randc_old_1(p)
    s = cumsum(p, 2);
    N = size(p, 1);
    r = rand(N, 1) .* s(:, end);

    for idx = N:-1:1
        c(idx, 1) = find(r(idx) < s(idx, :), 1);
    end

end

function c = randc_old_2(p)
    S = cumsum(p, 2);
    [~, c] = max(rand(size(p, 1), 1) .* S(:, end) < S, [], 2);
end
