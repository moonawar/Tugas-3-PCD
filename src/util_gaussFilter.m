function result = util_gaussFilter(input, n, sigma)
    gaussKernel = createGaussianKernel(n, sigma);
    if (size(input, 3) == 3)
        result = zeros(size(input));
        for i = 1:3
            result(:, :, i) = applyGaussFilterSingleCh(input(:, :, i), gaussKernel);
        end
    else
        result = applyGaussFilterSingleCh(input, gaussKernel);
    end
end

function gaussKernel = createGaussianKernel(n, sigma)
    half = floor(n/2);
    [X, Y] = meshgrid(-half:half, -half:half);

    gaussKernel = exp(-(X.^2 + Y.^2) / (2 * sigma^2));
    gaussKernel = gaussKernel / sum(gaussKernel(:));
end

function channel = applyGaussFilterSingleCh(input, kernel)
    channel = util_conv(input, kernel);
end