% edge_log - Melakukan deteksi tepi dengan metode LoG (Laplacian of Gaussian)

% parameter:
%   input: citra grayscale yang akan dideteksi tepinya
%   sigma: nilai sigma untuk gaussian kernel
% return
%   result: citra hasil deteksi tepi
function result = edge_log(input, sigma)
    gaussFiltered = util_gaussFilter(input, 5, sigma); % menggunakan kernel 5x5

    % kernel laplace yang digunakan
    laplace_kernel = [1, 1, 1; 1, -8, 1; 1, 1, 1];

    % konvolusi citra hasil filter gaussian dengan kernel laplace
    result = util_conv(gaussFiltered, laplace_kernel);
end