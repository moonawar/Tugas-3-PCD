% input is an image that we want to convolve
% kernel is a 2D array that we want to convolve with
% result is an image that is the result of the convolution
function result = util_conv(input, kernel) 
    if (size(input, 3) == 3)
        result = zeros(size(input));
        for i = 1:3
            result(:, :, i) = imfilter(input(:, :, i), kernel, 'replicate');
        end
    else
        result = imfilter(input, kernel, 'replicate');
    end
end