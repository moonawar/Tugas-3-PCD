function result = edge_log(input, n, sigma)
    gaussFiltered = util_gaussFilter(input, n, sigma);
    % laplace_kernel = [0 1 0; 1 -4 1; 0 1 0];
    laplace_kernel = [1, 1, 1; 1, -8, 1; 1, 1, 1];
    result = util_conv(gaussFiltered, laplace_kernel);
end