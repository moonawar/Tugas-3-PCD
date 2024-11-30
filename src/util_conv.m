% util_conv - Melakukan konvolusi citra dengan kernel tertentu

% parameter:
%   input: citra yang akan dikonvolusi
%   kernel: kernel yang akan digunakan untuk konvolusi
% return
%   result: citra hasil konvolusi
function result = util_conv(input, kernel) 
    % menggunakan built-in imfilter untuk melakukan konvolusi
    if (size(input, 3) == 3)
        result = zeros(size(input));
        for i = 1:3
            result(:, :, i) = imfilter(input(:, :, i), kernel, 'replicate');
        end
    else
        result = imfilter(input, kernel, 'replicate');
    end
end