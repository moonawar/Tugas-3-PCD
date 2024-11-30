% util_gaussFilter - Melakukan filter citra dengan kernel gaussian

% parameter:
%   input: citra yang akan difilter
%   n: ukuran kernel
%   sigma: nilai sigma untuk gaussian kernel
% return
%   result: citra hasil filter
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

% createGaussianKernel - Membuat kernel gaussian

% parameter:
%   n: ukuran kernel
%   sigma: nilai sigma untuk gaussian kernel
% return
%   gaussKernel: kernel gaussian
function gaussKernel = createGaussianKernel(n, sigma)
    half = floor(n/2);
    [X, Y] = meshgrid(-half:half, -half:half);

    gaussKernel = exp(-(X.^2 + Y.^2) / (2 * sigma^2));
    gaussKernel = gaussKernel / sum(gaussKernel(:));
end

% applyGaussFilterSingleCh - Melakukan filter pada satu channel citra

% parameter:
%   input: citra yang akan difilter
%   kernel: kernel gaussian
% return
%   channel: channel citra hasil filter
function channel = applyGaussFilterSingleCh(input, kernel)
    channel = util_conv(input, kernel);
end