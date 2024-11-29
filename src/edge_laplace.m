% input is an image that we want to edge-detect
% result is an image of laplace edge detection
function result = edge_laplace(input)
    % laplace_kernel = [0 1 0; 1 -4 1; 0 1 0];
    laplace_kernel = [1, 1, 1; 1, -8, 1; 1, 1, 1];
    result = util_conv(input, laplace_kernel);
end